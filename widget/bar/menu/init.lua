local return_button = function(color, lspace, rspace)
    local widget_button =
        wibox.widget {
        {
            {
                {
                    {
                        image = icons.menu,
                        widget = wibox.widget.imagebox
                    },
                    top = dpi(4),
                    bottom = dpi(4),
                    left = dpi(12),
                    right = dpi(12),
                    widget = wibox.container.margin
                },
                shape = beautiful.client_shape_rounded,
                bg = color.color,
                widget = wibox.container.background
            },
            widget = clickable_container
        },
        left = dpi(6),
        right = dpi(6),
        top = dpi(3),
        bottom = dpi(3),
        widget = wibox.container.margin
    }
    local icon_size = dpi(108)

    widget_button:buttons(
        gears.table.join(
            awful.button(
                {},
                3,
                nil,
                function()
                    drawer_toggle()
                end
            ),
            awful.button(
                {},
                1,
                nil,
                function()
                    cc_toggle()
                end
            )
        )
    )

    return widget_button
end

return return_button
