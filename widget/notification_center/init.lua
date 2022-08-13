-- title text
local title =
    wibox.widget {
    {
        {
            spacing = dpi(0),
            layout = wibox.layout.align.horizontal,
            nil,
            {
                layout = wibox.container.place,
                halign = 'center',
                valign = 'center',
                require('widget.notification_center.title-text')
            },
            require('widget.notification_center.clear-all')
        },
        margins = dpi(5),
        widget = wibox.container.margin
    },
    shape = beautiful.client_shape_rounded_medium,
    forced_height = dpi(70),
    border_color = colors.black,
    border_width = dpi(1),
    widget = wibox.container.background,
    bg = colors.alpha(colors.white, '22')
}

-- ------------------------------------------------- --
-- panel with controls
local notification_panel =
    wibox.widget {
    {
        {
            spacing = dpi(12),
            layout = wibox.layout.fixed.vertical,
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = dpi(16),
                require('widget.notification_center.notifications-panel')
            }
        },
        margins = dpi(12),
        widget = wibox.container.margin
    },
    shape = beautiful.client_shape_rounded_xl,
    widget = wibox.container.background
}
-- ------------------------------------------------- --

local notifs =
    wibox.widget {
    {
        {
            title,
            notification_panel,
            expand = 'none',
            layout = wibox.layout.fixed.vertical,
            bg = beautiful.bg_focus
        },
        margins = dpi(0),
        layout = wibox.container.margin
    },
    shape = beautiful.client_shape_rounded_xl,
    widget = wibox.container.background,
    bg = beautiful.bg_normal
}

return notifs
