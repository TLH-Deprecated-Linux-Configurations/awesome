--  __                __     __ __         __
-- |  |_.---.-.-----.|  |--.|  |__|.-----.|  |_
-- |   _|  _  |__ --||    < |  |  ||__ --||   _|
-- |____|___._|_____||__|__||__|__||_____||____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
-- Set tasklist items to set width of 200
local common = require("awful.widget.common")
local task_preview_box = require("layout.bottom-panel.widgets.task-list.task_preview")
task_preview_box.enable {
    placement_fn = function(c) -- Place the widget using awful.placement (this overrides x & y)
        awful.placement.bottom(
            c,
            {
                margins = {
                    bottom = 40
                }
            }
        )
    end
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
function tasklist_update(w, buttons, label, data, objects)
    -- call default widget drawing function
    common.list_update(w, buttons, label, data, objects)
    -- set widget size
    w:set_max_widget_size(100)
end

-- ########################################################################
-- ########################################################################
-- ########################################################################
local tasklist = function(s)
    local tasklist_buttons =
        gears.table.join(
        awful.button(
            {},
            1,
            function(c)
                if c == client.focus then
                    c.minimized = true
                else
                    c:emit_signal("request::activate", "tasklist", {raise = true})
                end
            end
        ),
        awful.button(
            {},
            3,
            function()
                awful.menu.client_list({theme = {width = 250}})
            end
        ),
        awful.button(
            {},
            8,
            function()
                awful.client.focus.byidx(1)
            end
        ),
        awful.button(
            {},
            9,
            function()
                awful.client.focus.byidx(-1)
            end
        )
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local widget_tasklist =
        awful.widget.tasklist {
        screen = s,
        tasklist_update,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        layout = {
            layout = wibox.layout.flex.horizontal
        },
        -- Notice that there is *NO* wibox.wibox prefix, it is a template,
        -- not a widget instance.
        widget_template = {
            {
                {
                    {
                        {
                            {
                                id = "clienticon",
                                awful.widget.clienticon,
                                margins = dpi(6),
                                left = dpi(6),
                                right = dpi(6),
                                top = dpi(12),
                                bottom = dpi(6),
                                widget = wibox.container.margin
                            },
                            {
                                id = "text_role",
                                widget = wibox.widget.textbox
                            },
                            layout = wibox.layout.fixed.horizontal
                        },
                        widget = wibox.layout.align.vertical
                    },
                    left = dpi(6),
                    right = dpi(6),
                    top = dpi(2),
                    bottom = dpi(2),
                    widget = wibox.container.margin,
                    layout = wibox.layout.fixed.horizontal
                },
                shape = beautiful.btn_sm_shape,
                border_width = dpi(2),
                id = "background_role",
                border_color = beautiful.xcolor7 .. "66",
                widget = wibox.container.background
            },
            left = dpi(6),
            right = dpi(6),
            top = dpi(2),
            bottom = dpi(2),
            widget = wibox.container.margin,
            create_callback = function(self, c, index, objects) --luacheck: no unused args
                self:get_children_by_id("clienticon")[1].client = c

                -- BLING: Toggle the popup on hover and disable it off hover
                self:connect_signal(
                    "mouse::enter",
                    function()
                        awesome.emit_signal("task_preview::visibility", s, true, c)
                    end
                )
                self:connect_signal(
                    "mouse::leave",
                    function()
                        awesome.emit_signal("task_preview::visibility", s, false, c)
                    end
                )
            end
        }
    }

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    return widget_tasklist
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
return tasklist
