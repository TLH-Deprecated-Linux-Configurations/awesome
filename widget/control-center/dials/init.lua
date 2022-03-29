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
                    require("widget.control-center.ram-meter"),
                    require("widget.control-center.cpu-meter")
                }
            ),
            format_item(
                {
                    layout = wibox.layout.fixed.vertical,
                    spacing = dpi(5),
                    require("widget.control-center.hdd-meter"),
                    require("widget.control-center.temp-meter")
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
