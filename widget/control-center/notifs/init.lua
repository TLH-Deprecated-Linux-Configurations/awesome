-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Notification library
local naughty = require("naughty")

-- Widget library
local wibox = require("wibox")

-- Helpers

-- Notification Center
------------------------

local notifs_text =
    wibox.widget {
    font = beautiful.font,
    fg = colors.white,
    markup = "Notifications",
    valign = "center",
    widget = wibox.widget.textbox
}

local notifs_clear =
    wibox.widget {
    markup = "",
    font = "Nineteen Ninety Seven Bold 18",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

notifs_clear:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            function()
                _G.reset_notifs_container()
            end
        )
    )
)

local notifs_empty =
    wibox.widget {
    {
        nil,
        {
            nil,
            {
                markup = "No notifications at this time, please check back later.",
                fg = colors.white,
                font = beautiful.font,
                align = "center",
                valign = "center",
                widget = wibox.widget.textbox
            },
            expand = "none",
            layout = wibox.layout.align.vertical
        },
        expand = "none",
        layout = wibox.layout.align.horizontal
    },
    forced_height = dpi(110),
    widget = wibox.container.background
}

local notifs_container =
    wibox.widget {
    spacing = dpi(6),
    spacing_widget = {
        {
            bg = beautiful.bg_focus,
            shape = gears.shape.rounded_rect,
            widget = wibox.container.background
        },
        top = dpi(2),
        bottom = dpi(2),
        left = dpi(53),
        right = dpi(6),
        widget = wibox.container.margin
    },
    forced_width = beautiful.notifs_width or dpi(240),
    layout = wibox.layout.fixed.vertical
}

local remove_notifs_empty = true

reset_notifs_container = function()
    notifs_container:reset(notifs_container)
    notifs_container:insert(1, notifs_empty)
    remove_notifs_empty = true
end

remove_notif = function(box)
    notifs_container:remove_widgets(box)

    if #notifs_container.children == 0 then
        notifs_container:insert(1, notifs_empty)
        remove_notifs_empty = true
    end
end

local create_notif = function(icon, n, width)
    local time = os.date("%H:%M")
    local box = {}

    box =
        wibox.widget {
        {
            {
                {
                    {
                        image = icon,
                        resize = true,
                        clip_shape = beautiful.client_shape_rounded_small,
                        halign = "center",
                        valign = "center",
                        widget = wibox.widget.imagebox
                    },
                    strategy = "exact",
                    height = dpi(40),
                    width = dpi(40),
                    widget = wibox.container.constraint
                },
                {
                    {
                        nil,
                        {
                            {
                                {
                                    step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
                                    speed = 50,
                                    {
                                        markup = n.title,
                                        font = beautiful.font,
                                        align = "left",
                                        widget = wibox.widget.textbox
                                    },
                                    forced_width = dpi(140),
                                    widget = wibox.container.scroll.horizontal
                                },
                                nil,
                                {
                                    markup = time,
                                    fg = colors.white,
                                    align = "right",
                                    valign = "bottom",
                                    font = beautiful.font,
                                    widget = wibox.widget.textbox
                                },
                                expand = "none",
                                layout = wibox.layout.align.horizontal
                            },
                            {
                                markup = n.message,
                                fg = colors.white,
                                align = "left",
                                font = beautiful.font,
                                forced_width = dpi(165),
                                widget = wibox.widget.textbox
                            },
                            spacing = dpi(2),
                            layout = wibox.layout.fixed.vertical
                        },
                        expand = "none",
                        layout = wibox.layout.align.vertical
                    },
                    left = dpi(12),
                    widget = wibox.container.margin
                },
                layout = wibox.layout.align.horizontal
            },
            margins = dpi(6),
            widget = wibox.container.margin
        },
        bg = beautiful.bg_focus,
        shape = beautiful.client_shape_rounded,
        forced_height = dpi(104),
        widget = wibox.container.background
    }

    box:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                function()
                    _G.remove_notif(box)
                end
            )
        )
    )

    return box
end

notifs_container:buttons(
    gears.table.join(
        awful.button(
            {},
            4,
            nil,
            function()
                if #notifs_container.children == 1 then
                    return
                end
                notifs_container:insert(1, notifs_container.children[#notifs_container.children])
                notifs_container:remove(#notifs_container.children)
            end
        ),
        awful.button(
            {},
            5,
            nil,
            function()
                if #notifs_container.children == 1 then
                    return
                end
                notifs_container:insert(#notifs_container.children + 1, notifs_container.children[1])
                notifs_container:remove(1)
            end
        )
    )
)

notifs_container:insert(1, notifs_empty)

naughty.connect_signal(
    "request::display",
    function(n)
        if #notifs_container.children == 1 and remove_notifs_empty then
            notifs_container:reset(notifs_container)
            remove_notifs_empty = false
        end

        local notif_color = beautiful.groups_bg
        if n.urgency == "critical" then
            notif_color = colors.color1
        end
        local appicon = n.icon or n.app_icon
        if not appicon then
            appicon = beautiful.notification_icon
        end

        notifs_container:insert(1, create_notif(appicon, n, width))
    end
)

local notifs =
    wibox.widget {
    {
        {
            notifs_text,
            nil,
            notifs_clear,
            expand = "none",
            layout = wibox.layout.align.horizontal
        },
        left = dpi(5),
        right = dpi(5),
        layout = wibox.container.margin
    },
    notifs_container,
    spacing = dpi(10),
    layout = wibox.layout.fixed.vertical
}

return notifs
