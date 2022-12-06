--  _______         __   __   ___ __              __   __
-- |    |  |.-----.|  |_|__|.'  _|__|.----.---.-.|  |_|__|.-----.-----.-----.
-- |       ||  _  ||   _|  ||   _|  ||  __|  _  ||   _|  ||  _  |     |__ --|
-- |__|____||_____||____|__||__| |__||____|___._||____|__||_____|__|__|_____|
-- ------------------------------------------------- --
require('widget.notifications')
-- Apply theme variables
naughty.config.padding = dpi(18)
naughty.config.spacing = dpi(8)
naughty.config.shape = beautiful.client_shape_rounded_xl
naughty.config.icon_formats = {'svg', 'png', 'jpg', 'gif'}

-- ------------------------------------------------- --
-- NOTE provide rules for the notifications
ruled.notification.connect_signal(
    'request::rules',
    function()
        -- NOTE Critical notifs
        ruled.notification.append_rule {
            rule = {urgency = 'critical'},
            properties = {
                implicit_timeout = 8
            }
        }

        -- NOTE Normal notifs
        ruled.notification.append_rule {
            rule = {urgency = 'normal'},
            properties = {
                implicit_timeout = 5
            }
        }

        -- NOTE Low notifs
        ruled.notification.append_rule {
            rule = {urgency = 'low'},
            properties = {
                implicit_timeout = 2
            }
        }
    end
)
-- ------------------------------------------------- --
-- NOTE connect to the error signal
naughty.connect_signal(
    'request::display_error',
    function(message, startup)
        naughty.notification {
            urgency = 'critical',
            title = 'Error!' .. (startup and 'There was an error during startup!' or ''),
            message = message,
            app_name = 'System Notification',
            icon = icons.awesome
        }
    end
)
-- ------------------------------------------------- --
-- NOTE color assignment
local main_color = {
    ['low'] = colors.alpha(colors.colorI, '88'),
    ['normal'] = colors.alpha(colors.colorI, '88'),
    ['critical'] = colors.alpha(colors.colorA, '88')
}
-- ------------------------------------------------- --
local edge_color = {
    ['low'] = colors.alpha(colors.colorB, '88'),
    ['normal'] = colors.alpha(colors.colorB, '88'),
    ['critical'] = colors.alpha(colors.color4, '88')
}
-- ------------------------------------------------- --
-- NOTE template for the notifications in general, with icons

naughty.connect_signal(
    'request::display',
    function(n)
        local custom_notification_icon =
            wibox.widget {
            font = beautiful.font .. '  18',
            align = 'center',
            valign = 'center',
            widget = wibox.widget.textbox
        }

        local main_color = main_color[n.urgency]
        local edge_color = edge_color[n.urgency]
        local icon = icons.awesome
        -- ------------------------------------------------- --
        -- NOTE template for actions on notification
        local actions =
            wibox.widget {
            notification = n,
            widget_template = {
                {
                    {
                        {
                            id = 'text_role',
                            font = beautiful.font .. ' 12',
                            widget = wibox.widget.textbox
                        },
                        left = dpi(6),
                        right = dpi(6),
                        widget = wibox.container.margin
                    },
                    widget = clickable_container
                },
                forced_height = dpi(35),
                forced_width = dpi(180),
                widget = wibox.container.background
            },
            style = {
                underline_normal = false,
                underline_selected = true
            },
            widget = naughty.list.actions
        }
        -- ------------------------------------------------- --
        -- NOTE icon template
        local notif_icon =
            wibox.widget {
            {
                {
                    {
                        image = icons.awesome,
                        widget = wibox.widget.imagebox
                    },
                    margins = dpi(5),
                    widget = wibox.container.margin
                },
                shape = beautiful.client_shape_rounded_xl,
                bg = edge_color,
                widget = wibox.container.background
            },
            forced_width = dpi(90),
            forced_height = dpi(90),
            widget = clickable_container
        }

        naughty.layout.box {
            notification = n,
            type = 'notification',
            -- ------------------------------------------------- --
            -- NOTE For antialiasing: The real shape is set in widget_template
            shape = beautiful.client_shape_rounded_lg,
            position = 'top_right',
            widget_template = {
                {
                    {
                        notif_icon,
                        {
                            {
                                {
                                    align = 'center',
                                    visible = true,
                                    font = beautiful.font .. ' 12',
                                    markup = '<b>' .. n.title .. '</b>',
                                    -- widget = wibox.widget.textbox
                                    widget = naughty.widget.title
                                },
                                {
                                    align = 'center',
                                    --wrap = "char",
                                    widget = naughty.widget.message
                                },
                                {
                                    wibox.widget {
                                        forced_height = dpi(10),
                                        layout = wibox.layout.fixed.vertical
                                    },
                                    {
                                        actions,
                                        shape = beautiful.client_shape_rounded,
                                        widget = wibox.container.background
                                    },
                                    visible = n.actions and #n.actions > 0,
                                    layout = wibox.layout.fixed.vertical
                                },
                                layout = wibox.layout.align.vertical
                            },
                            margins = dpi(14),
                            widget = wibox.container.margin
                        },
                        layout = wibox.layout.fixed.horizontal
                    },
                    strategy = 'max',
                    width = dpi(550),
                    height = dpi(250),
                    widget = wibox.container.constraint
                },
                -- ------------------------------------------------- --
                -- NOTE Anti-aliasing container
                shape = beautiful.client_shape_rounded_lg,
                bg = main_color,
                fg = colors.white,
                border_width = dpi(3),
                border_color = colors.colorC,
                widget = wibox.container.background
            }
        }

        if _G.dnd_status or _G.nc_status then
            naughty.destroy_all_notifications(nil, 1)
        end
    end
)
