local dials =
    wibox.widget {
    spacing = dpi(1),
    layout = wibox.layout.flex.horizontal,
    {
        layout = wibox.layout.flex.vertical,
        spacing = dpi(1),
        require('widget.dashboard.dials.ram-meter'),
        require('widget.dashboard.dials.cpu-meter')
    },
    {
        layout = wibox.layout.flex.vertical,
        spacing = dpi(1),
        require('widget.dashboard.dials.hdd-meter'),
        require('widget.dashboard.dials.temp-meter')
    }
}

return dials
