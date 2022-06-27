-- slider widgets
local sliders =
    wibox.widget {
    {
        {
            layout = wibox.layout.flex.horizontal,
            format_item(
                {
                    layout = wibox.layout.flex.vertical,
                    spacing = dpi(15),
                    {
                        {
                            {
                                require('widget.dashboard.sliders.volume-slider'),
                                forced_height = dpi(125),
                                widget = wibox.container.background
                            },
                            widget = wibox.container.margin,
                            margins = dpi(5)
                        },
                        widget = wibox.container.background,
                        bg = beautiful.bg_menu,
                        shape = beautiful.client_shape_rounded_xl
                    },
                    {
                        {
                            {
                                require('widget.dashboard.sliders.brightness-slider'),
                                forced_height = dpi(125),
                                widget = wibox.container.background
                            },
                            widget = wibox.container.margin,
                            margins = dpi(5)
                        },
                        widget = wibox.container.background,
                        bg = beautiful.bg_menu,
                        shape = beautiful.client_shape_rounded_xl
                    }
                }
            )
        },
        margins = dpi(0),
        widget = wibox.container.margin
    },
    shape = beautiful.client_shape_rounded_xl,
    widget = wibox.container.background
}

return sliders
