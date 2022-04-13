local buttons =
    wibox.widget {
    {
        {
            spacing = dpi(45),
            layout = wibox.layout.fixed.vertical,
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = dpi(45),
                require("widget.control-center.buttons.bar-button"),
                require("widget.control-center.buttons.file-manager-button"),
                require("widget.control-center.buttons.do-not-disturb")
            },
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = dpi(45),
                require("widget.control-center.buttons.screen-capture"),
                require("widget.control-center.buttons.mute-button"),
                require("widget.control-center.buttons.restart-awesome")
            },
            bg = beautiful.bg_focus,
            shape = beautiful.client_shape_rounded,
            widget = wibox.container.background
        },
        margins = dpi(0),
        widget = wibox.container.margin
    },
    shape = beautiful.client_shape_rounded_medium,
    widget = wibox.container.background
}

return buttons
