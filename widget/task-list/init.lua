local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

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
                awful.menu.client_list({theme = {width = 650}})
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

    local widget_tasklist =
        awful.widget.tasklist {
        screen = s,
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
                            awful.widget.clienticon,
                            {
                                id = "text_role",
                                widget = wibox.widget.textbox
                            },
                            spacing = dpi(2),
                            layout = wibox.layout.fixed.horizontal
                        },
                        widget = wibox.layout.align.vertical
                    },
                    left = dpi(6),
                    right = dpi(6),
                    top = dpi(0),
                    bottom = dpi(0),
                    widget = wibox.container.margin,
                    layout = wibox.layout.fixed.horizontal
                },
                shape = beautiful.panel_button_shape,
                border_width = beautiful.btn_border_width,
                id = "background_role",
                border_color = beautiful.border_button,
                widget = wibox.container.background
            },
            margins = dpi(0),
            left = dpi(6),
            right = dpi(6),
            top = dpi(0),
            bottom = dpi(0),
            widget = wibox.container.margin
        }
    }

    return widget_tasklist
end

return tasklist
