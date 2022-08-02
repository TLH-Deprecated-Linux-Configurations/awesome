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
                halign = "center",
                valign = "center",
                require("module.notifs.title-text")
            },
            require("module.notifs.clear-all")
        },
        margins = dpi(5),
        widget = wibox.container.margin
    },
    shape = beautiful.client_shape_rounded_medium,
    forced_height = dpi(70),
    border_color = colors.black,
    border_width = dpi(1),
    widget = wibox.container.background,
    bg = colors.alpha(colors.white, "22")
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
                require("module.notifs.notifications-panel")
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
    awful.popup {
    {
        {
            title,
            notification_panel,
            expand = "none",
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

notifs.visible = false

function toggle_notifications()
    if notifs.visible == false then
        notifs.visible = true
    else
        notifs.visible = false
    end
end

awesome.connect_signal(
    "notifications::center:toggle",
    function()
        toggle_notifications()
    end
)

return notifs
