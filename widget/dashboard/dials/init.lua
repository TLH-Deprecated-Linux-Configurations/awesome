local dials =
    wibox.widget {
    {
        {
            spacing = dpi(1),
            layout = wibox.layout.flex.horizontal,
            format_item(
                {
                    layout = wibox.layout.flex.vertical,
                    spacing = dpi(1),
                    require('widget.dashboard.dials.ram-meter'),
                    require('widget.dashboard.dials.cpu-meter')
                }
            ),
            format_item(
                {
                    layout = wibox.layout.flex.vertical,
                    spacing = dpi(1),
                    require('widget.dashboard.dials.hdd-meter'),
                    require('widget.dashboard.dials.temp-meter')
                }
            )
        },
        margins = dpi(5),
        widget = wibox.container.margin
    },
    shape = beautiful.client_shape_rounded_xl,
    widget = wibox.container.background
}

return dials
