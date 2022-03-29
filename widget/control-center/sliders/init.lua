-- slider widgets
local sliders =
    wibox.widget {
    {
        {
            spacing = dpi(5),
            layout = wibox.layout.flex.horizontal,
            format_item(
                {
                    layout = wibox.layout.flex.vertical,
                    spacing = dpi(5),
                    require("widget.control-center.volume-slider"),
                    require("widget.control-center.brightness-slider")
                }
            )
        },
        margins = dpi(2),
        widget = wibox.container.margin
    },
    shape = beautiful.client_shape_rounded_xl,
    widget = wibox.container.background
}

return sliders
