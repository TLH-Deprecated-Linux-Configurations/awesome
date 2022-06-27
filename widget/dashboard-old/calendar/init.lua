local w_calendar =
    wibox.widget {
    wibox.widget {
        {
            date = os.date('*t'),
            widget = wibox.widget.calendar.month,
            start_sunday = false,
            font = 'SFP Pro Rounded Heavy 18',
            week_numbers = false,
            long_weekdays = true,
            align = 'center',
            valign = 'center',
            forced_height = dpi(430),
            forced_width = dpi(450)
        },
        widget = wibox.container.margin,
        margins = dpi(5)
    },
    layout = wibox.layout.flex.horizontal,
    bg = beautiful.bg_button,
    widget = wibox.container.background
}

return w_calendar
