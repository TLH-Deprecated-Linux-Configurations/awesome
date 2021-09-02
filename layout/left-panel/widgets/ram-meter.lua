local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local watch = require("awful.widget.watch")
local wibox = require("wibox")
local vicious = require("lib.vicious")
local dpi = beautiful.xresources.apply_dpi
local icons = require("theme.icons")
local signals = require("module.settings.signals")
local ramgraph_widget = {}

collectgarbage("collect")

-- memory widget
local mem = wibox.widget.textbox()
vicious.cache(vicious.widgets.mem)
vicious.register(mem, vicious.widgets.mem, "$1%", 1)
mem.font = beautiful.font .. " 14"
mem.top = 5
mem.bottom = 5
mem.border_color = beautiful.xforeground
mem.border_width = 3

signals.connect_ram_usage(
    function(value)
        mem.text = value
    end
)

local function worker(user_args)
    local args = user_args or {}
    local timeout = args.timeout or 1

    --- Main ram widget shown on wibar
    local widget_icon =
        wibox.widget {
        id = "icon",
        image = icons.chip,
        forced_width = 36,
        forced_height = 36,
        widget = wibox.widget.imagebox
    }
    local ram_button =
        wibox.widget {
        {
            {
                widget_icon,
                mem,
                spacing = dpi(1),
                layout = wibox.layout.flex.horizontal
            },
            top = dpi(2),
            bottom = dpi(2),
            left = dpi(1),
            right = dpi(1),
            widget = wibox.container.margin
        },
        shape = gears.shape.rounded_rect,
        bg = beautiful.bg_normal .. "77",
        shape_border_color = beautiful.bg_normal,
        shape_border_width = dpi(3),
        widget = wibox.container.background
    }
    ramgraph_widget = ram_button
    local old_cursor, old_wibox

    ram_button:connect_signal(
        "mouse::enter",
        function(c)
            local wb = mouse.current_wibox
            old_cursor, old_wibox = wb.cursor, wb
            wb.cursor = "hand1"
        end
    )
    ram_button:connect_signal(
        "mouse::leave",
        function(c)
            if old_wibox then
                old_wibox.cursor = old_cursor
                old_wibox = nil
            end
        end
    )
    --- Widget which is shown when user clicks on the ram widget
    local popup =
        awful.popup {
        ontop = true,
        visible = false,
        widget = {
            widget = wibox.widget.piechart,
            forced_height = 200,
            forced_width = 400,
            colors = {
                -- used
                beautiful.xcolor9,
                -- free
                beautiful.xcolor4,
                -- buf_cache
                beautiful.xcolor5
            }
        },
        bg = beautiful.xbackground .. "cc",
        shape = gears.shape.rounded_rect,
        border_color = beautiful.xforeground,
        border_width = 1,
        offset = {y = 5}
    }

    --luacheck:ignore 231
    local total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap

    local function getPercentage(value)
        return math.floor(value / (total + total_swap) * 100 + 0.5) .. "%"
    end

    watch(
        'bash -c "LANGUAGE=en_US.UTF-8 free | grep -z Mem.*Swap.*"',
        timeout,
        function(widget, stdout)
            total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap =
                stdout:match("(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*Swap:%s*(%d+)%s*(%d+)%s*(%d+)")

            widget.data = {used, total - used}

            if popup.visible then
                popup:get_widget().data_list = {
                    {"used " .. getPercentage(used + used_swap), used + used_swap},
                    {"free " .. getPercentage(free + free_swap), free + free_swap},
                    {"buff_cache " .. getPercentage(buff_cache), buff_cache}
                }
            end
        end,
        ramgraph_widget
    )

    ramgraph_widget:buttons(
        awful.util.table.join(
            awful.button(
                {},
                1,
                function()
                    popup:get_widget().data_list = {
                        {"used " .. getPercentage(used + used_swap), used + used_swap},
                        {"free " .. getPercentage(free + free_swap), free + free_swap},
                        {"buff_cache " .. getPercentage(buff_cache), buff_cache}
                    }

                    if popup.visible then
                        popup.visible = not popup.visible
                    else
                        popup:move_next_to(mouse.current_widget_geometry)
                    end
                end
            )
        )
    )

    return ramgraph_widget
end

return setmetatable(
    ramgraph_widget,
    {
        __call = function(_, ...)
            return worker(...)
        end
    }
)
