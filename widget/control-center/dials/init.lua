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
                    require("widget.control-center.dials.ram-meter"),
                    require("widget.control-center.dials.cpu-meter")
                }
            ),
            format_item(
                {
                    layout = wibox.layout.fixed.vertical,
                    spacing = dpi(5),
                    require("widget.control-center.dials.hdd-meter"),
                    require("widget.control-center.dials.temp-meter")
                }
            )
        },
        margins = dpi(5),
        widget = wibox.container.margin
    },
    shape = beautiful.client_shape_rounded_xl,
    widget = wibox.container.background,
    bg = beautiful.bg_focus
}

return dials
