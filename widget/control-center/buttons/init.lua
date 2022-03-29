local buttons =
    wibox.widget {
    {
        {
            spacing = dpi(0),
            layout = wibox.layout.flex.vertical,
            {
                format_item(
                    {
                        layout = wibox.layout.flex.horizontal,
                        spacing = dpi(16),
                        require("widget.control-center.bar-button"),
                        require("widget.control-center.dropbox-toggle"),
                        require("widget.control-center.do-not-disturb"),
                        require("widget.control-center.screen-capture"),
                        require("widget.control-center.mute-button"),
                        require("widget.control-center.restart-awesome")
                    }
                ),
                bg = beautiful.bg_focus,
                shape = beautiful.client_shape_rounded,
                widget = wibox.container.background
            }
        },
        margins = dpi(8),
        widget = wibox.container.margin
    },
    shape = beautiful.client_shape_rounded_xl,
    widget = wibox.container.background
}

return buttons
