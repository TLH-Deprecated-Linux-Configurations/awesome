local buttons =
    wibox.widget {
    {
        {
            spacing = dpi(0),
            layout = wibox.layout.flex.vertical,
            format_item(
                {
                    layout = wibox.layout.flex.horizontal,
                    spacing = dpi(6),
                    require("widget.control-center.buttons.bar-button"),
                    require("widget.control-center.buttons.dropbox-toggle"),
                    require("widget.control-center.buttons.do-not-disturb"),
                    require("widget.control-center.buttons.screen-capture"),
                    require("widget.control-center.buttons.mute-button"),
                    require("widget.control-center.buttons.restart-awesome")
                }
            ),
            bg = beautiful.bg_focus,
            shape = beautiful.client_shape_rounded,
            widget = wibox.container.background
        },
        margins = dpi(2),
        widget = wibox.container.margin
    },
    shape = beautiful.client_shape_rounded_medium,
    widget = wibox.container.background
}

return buttons
