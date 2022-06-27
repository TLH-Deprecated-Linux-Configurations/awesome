local dials =
    wibox.widget {
    {
        {
            spacing = dpi(5),
            layout = wibox.layout.flex.horizontal,
            format_item(
                {
                    layout = wibox.layout.fixed.vertical,
                    spacing = dpi(5),
                    require('widget.dashboard.dials.ram-meter'),
                    require('widget.dashboard.dials.cpu-meter')
                }
            ),
            format_item(
                {
                    layout = wibox.layout.fixed.vertical,
                    spacing = dpi(5),
                    require('widget.dashboard.dials.hdd-meter'),
                    require('widget.dashboard.dials.temp-meter')
                }
            )
        },
        margins = dpi(0),
        widget = wibox.container.margin
    },
    shape = beautiful.client_shape_rounded_xl,
    widget = wibox.container.background,
    bg = beautiful.bg_menu
}

return dials
