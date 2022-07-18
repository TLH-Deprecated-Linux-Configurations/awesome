--  _______         __   __   ___ __              __   __
-- |    |  |.-----.|  |_|__|.'  _|__|.----.---.-.|  |_|__|.-----.-----.-----.
-- |       ||  _  ||   _|  ||   _|  ||  __|  _  ||   _|  ||  _  |     |__ --|
-- |__|____||_____||____|__||__| |__||____|___._||____|__||_____|__|__|_____|
-- ------------------------------------------------- --
require('widget.notifications')
-- Apply theme variables
naughty.config.padding = dpi(8)
naughty.config.spacing = dpi(8)
naughty.config.icon_formats = {'svg', 'png', 'jpg', 'gif'}

-- ------------------------------------------------- --
--  provide rules for the notifications
ruled.notification.connect_signal(
    'request::rules',
    function()
        -- Critical notifs
        ruled.notification.append_rule {
            rule = {urgency = 'critical'},
            properties = {
                implicit_timeout = 8
            }
        }

        -- Normal notifs
        ruled.notification.append_rule {
            rule = {urgency = 'normal'},
            properties = {
                implicit_timeout = 5
            }
        }

        -- Low notifs
        ruled.notification.append_rule {
            rule = {urgency = 'low'},
            properties = {
                implicit_timeout = 2
            }
        }
    end
)
-- ------------------------------------------------- --
--  connect to the error signal
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
--  color assignment
local main_color = {
    ['low'] = colors.colorI,
    ['normal'] = colors.colorI,
    ['critical'] = colors.colorA
}
-- ------------------------------------------------- --
local edge_color = {
    ['low'] = colors.colorB,
    ['normal'] = colors.colorB,
    ['critical'] = colors.color4
}
-- ------------------------------------------------- --
-- template for the notifications in general, with icons

naughty.connect_signal(
    'request::display',
    function(n)
        local custom_notification_icon =
            wibox.widget {
            font = beautiful.font .. ' Bold  18',
            align = 'center',
            valign = 'center',
            widget = wibox.widget.textbox
        }

        local main_color = main_color[n.urgency]
        local edge_color = edge_color[n.urgency]
        local icon = icons.awesome
        -- ------------------------------------------------- --
        -- template for actions on notification
        local actions =
            wibox.widget {
            notification = n,
            widget_template = {
                {
                    {
                        {
                            id = 'text_role',
                            font = beautiful.notification_font,
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
            widget = naughty.list.actions,
            bg = beautiful.bg_focus
        }
        -- ------------------------------------------------- --
        -- icon template
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
                shape = beautiful.client_shape_rounded_lg,
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
            -- For antialiasing: The real shape is set in widget_template
            shape = beautiful.client_shape_rounded,
            position = 'bottom_right',
            widget_template = {
                {
                    {
                        notif_icon,
                        {
                            {
                                {
                                    align = 'center',
                                    visible = true,
                                    font = 'Goldman Black Bold 8',
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
                            margins = dpi(4),
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
                -- Anti-aliasing container
                shape = function(cr, width, height)
                    gears.shape.rounded_rect(cr, width, height, dpi(4))
                end,
                bg = main_color,
                fg = colors.white,
                border_width = dpi(1),
                border_color = colors.colorA,
                widget = wibox.container.background
            }
        }

        if _G.dnd_status or nc_status then
            naughty.destroy_all_notifications(nil, 1)
        end
    end
)
