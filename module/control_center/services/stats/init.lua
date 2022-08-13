local dials =
    wibox.widget {
    {
        {
            spacing = dpi(22),
            layout = wibox.layout.flex.vertical,
            format_item(
                {
                    spacing = dpi(22),
                    require(... .. '.cpu-meter'),
                    require(... .. '.ram-meter'),
                    require(... .. '.temp-meter'),
                    layout = wibox.layout.flex.horizontal
                }
            )
        },
        margins = dpi(0),
        widget = wibox.container.margin
    },
    shape = beautiful.client_shape_rounded_xl,
    widget = wibox.container.background
}

return dials
