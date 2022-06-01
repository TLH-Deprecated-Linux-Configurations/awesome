local buttons =
    wibox.widget {
    {
        {
            spacing = dpi(45),
            layout = wibox.layout.fixed.vertical,
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = dpi(45),
                require('widget.dashboard.buttons.bar-button'),
                require('widget.dashboard.buttons.file-manager-button'),
                require('widget.dashboard.buttons.do-not-disturb')
            },
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = dpi(45),
                require('widget.dashboard.buttons.screen-capture'),
                require('widget.dashboard.buttons.mute-button'),
                require('widget.dashboard.buttons.restart-awesome')
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
