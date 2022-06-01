local network =
    wibox.widget {
    {
        {
            {
                spacing = dpi(0),
                layout = wibox.layout.fixed.vertical,
                format_item(
                    {
                        layout = wibox.layout.align.horizontal,
                        spacing = dpi(16),
                        require('widget.dashboard.network.status-icon'),
                        {
                            layout = wibox.container.place,
                            halign = 'center',
                            valign = 'center',
                            require('widget.dashboard.network.status')
                        }
                    }
                ),
                {
                    {
                        spacing = dpi(0),
                        layout = wibox.layout.flex.vertical,
                        format_item(
                            {
                                layout = wibox.layout.fixed.horizontal,
                                spacing = dpi(6),
                                require('widget.dashboard.network.networks-panel')
                            }
                        )
                    },
                    margins = dpi(5),
                    widget = wibox.container.margin
                },
                shape = beautiful.client_shape_rounded,
                bg = beautiful.bg_focus,
                widget = wibox.container.background
            },
            bg = beautiful.bg_focus,
            widget = wibox.container.background
        },
        margins = dpi(8),
        widget = wibox.container.margin
    },
    shape = beautiful.client_shape_rounded_xl,
    bg = beautiful.bg_normal,
    widget = wibox.container.background
}
return network
