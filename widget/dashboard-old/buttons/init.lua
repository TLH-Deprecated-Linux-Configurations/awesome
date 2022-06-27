local buttons =
    wibox.widget {
    spacing = dpi(15),
    layout = wibox.layout.flex.vertical,
    {
        layout = wibox.layout.flex.horizontal,
        spacing = dpi(15),
        require('widget.dashboard.buttons.bar-button'),
        require('widget.dashboard.buttons.file-manager-button'),
        require('widget.dashboard.buttons.do-not-disturb')
    },
    {
        layout = wibox.layout.flex.horizontal,
        spacing = dpi(15),
        require('widget.dashboard.buttons.screen-capture'),
        require('widget.dashboard.buttons.mute-button'),
        require('widget.dashboard.buttons.restart-awesome')
    }
}

return buttons
