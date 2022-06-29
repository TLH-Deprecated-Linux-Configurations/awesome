function network()
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
                            require('widget.network_center.status-icon'),
                            {
                                layout = wibox.container.place,
                                halign = 'center',
                                valign = 'center',
                                require('widget.network_center.status')
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
                                    require('widget.network_center.networks-panel')
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
end
awesome.connect_signal(
    'network:show',
    function()
        network()
    end
)
return network
