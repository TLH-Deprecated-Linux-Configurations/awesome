--  _______         __   __   ___ __              __   __
-- |    |  |.-----.|  |_|__|.'  _|__|.----.---.-.|  |_|__|.-----.-----.-----.
-- |       ||  _  ||   _|  ||   _|  ||  __|  _  ||   _|  ||  _  |     |__ --|
-- |__|____||_____||____|__||__| |__||____|___._||____|__||_____|__|__|_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")
local ruled = require("ruled")
local naughty = require("naughty")
local menubar = require("menubar")
local beautiful = require("beautiful")
local icons = require("theme.icons")
local dpi = beautiful.xresources.apply_dpi
local clickable_container = require("widget.clickable-container")
local queue = require("lib.datastructure.queue")()
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Defaults
naughty.config.defaults.ontop = true
naughty.config.defaults.icon_size = dpi(32)
naughty.config.defaults.timeout = 5
naughty.config.defaults.title = "System Notification"
naughty.config.defaults.margin = dpi(16)
naughty.config.defaults.border_width = 0
naughty.config.defaults.position = "bottom_right"
naughty.config.defaults.shape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, dpi(12))
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Apply theme variables
naughty.config.padding = dpi(8)
naughty.config.spacing = dpi(8)
naughty.config.icon_dirs = {
    "/usr/share/icons/chhinamasta",
    "/usr/share/icons/Papirus-Dark",
    "/usr/share/icons/Tela",
    "/usr/share/icons/Tela-blue-dark",
    "/usr/share/icons/la-capitaine-icon-theme/",
    "/usr/share/icons/gnome/",
    "/usr/share/icons/hicolor/",
    "/usr/share/pixmaps/"
}

naughty.config.icon_formats = {"svg", "png", "jpg", "gif"}

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Presets / rules

ruled.notification.connect_signal(
    "request::rules",
    function()
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################-- Critical notifications
        ruled.notification.append_rule {
            rule = {
                urgency = "critical"
            },
            properties = {
                bg = "#ff0000",
                fg = "#f4f4f7",
                margin = dpi(16),
                position = "bottom_right",
                implicit_timeout = 10
            }
        }
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Normal notifications
        ruled.notification.append_rule {
            rule = {
                urgency = "normal"
            },
            properties = {
                bg = beautiful.transparent,
                fg = beautiful.fg_normal,
                margin = dpi(16),
                position = "bottom_right",
                implicit_timeout = 5
            }
        }
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Low notifications
        ruled.notification.append_rule {
            rule = {
                urgency = "low"
            },
            properties = {
                bg = beautiful.transparent,
                fg = beautiful.fg_normal,
                margin = dpi(16),
                position = "bottom_right",
                implicit_timeout = 5
            }
        }
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################

-- Error handling
naughty.connect_signal(
    "request::display_error",
    function(message, startup)
        naughty.notification {
            urgency = "critical",
            title = "Oops, An Error Happened" .. (startup and " During Startup!" or "!"),
            message = message,
            app_name = "System Notification",
            icon = icons.logo
        }
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
awesome.connect_signal(
    "startup",
    function()
        gears.timer {
            single_shot = true,
            autostart = true,
            timeout = 5,
            callback = function()
                print("Startup Cycle Finished Playback Queued Items")
                while queue.next() ~= nil do
                    local n = queue.pop()
                    naughty.notification {
                        urgency = n.urgency or "normal",
                        title = n.title or "",
                        message = n.message or "",
                        app_name = n.app_name or "",
                        icon = n.icon or "dialog-warning"
                    }
                end
            end
        }
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- XDG icon lookup
naughty.connect_signal(
    "request::icon",
    function(n, context, hints)
        if context ~= "app_icon" then
            return
        end

        local path = menubar.utils.lookup_icon(hints.app_icon) or menubar.utils.lookup_icon(hints.app_icon:lower())

        if path then
            n.icon = path
        end
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Connect to naughty on display signal
naughty.connect_signal(
    "request::display",
    function(n)
        if screen.count() < 1 or awesome.startup then
            print("Enqueueing: " .. n.title)
            queue.push(n)
            return
        end
        local screen = awful.screen.focused() or awful.screen.primary
        if (screen == nil) then
            print("Enqueueing: " .. n.title)
            queue.push(n)
            return
        end
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Actions Blueprint
        local actions_template =
            wibox.widget {
            notification = n,
            base_layout = wibox.widget {
                spacing = dpi(0),
                layout = wibox.layout.flex.horizontal
            },
            widget_template = {
                {
                    {
                        {
                            {
                                id = "text_role",
                                widget = wibox.widget.textbox
                            },
                            widget = wibox.container.place
                        },
                        widget = clickable_container
                    },
                    bg = beautiful.groups_bg,
                    shape = gears.shape.rounded_rect,
                    forced_height = dpi(30),
                    widget = wibox.container.background
                },
                margins = dpi(4),
                widget = wibox.container.margin
            },
            style = {
                underline_normal = false,
                underline_selected = true
            },
            widget = naughty.list.actions
        }
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Notification box Blueprint
        naughty.layout.box {
            notification = n,
            type = "notification",
            screen = awful.screen.focused(),
            shape = gears.shape.rectangle,
            widget_template = {
                {
                    {
                        {
                            {
                                {
                                    {
                                        {
                                            {
                                                {
                                                    {
                                                        markup = (n.title or n.app_name) or "System Notification",
                                                        align = "center",
                                                        valign = "center",
                                                        widget = wibox.widget.textbox
                                                    },
                                                    margins = beautiful.notification_margin,
                                                    widget = wibox.container.margin
                                                },
                                                bg = beautiful.bg_normal .. "00",
                                                widget = wibox.container.background
                                            },
                                            {
                                                {
                                                    {
                                                        resize_strategy = "center",
                                                        widget = naughty.widget.icon
                                                    },
                                                    margins = beautiful.notification_margin,
                                                    widget = wibox.container.margin
                                                },
                                                {
                                                    {
                                                        layout = wibox.layout.align.vertical,
                                                        expand = "inside",
                                                        nil,
                                                        {
                                                            align = "left",
                                                            widget = naughty.widget.message
                                                        },
                                                        nil
                                                    },
                                                    margins = beautiful.notification_margin,
                                                    widget = wibox.container.margin
                                                },
                                                layout = wibox.layout.fixed.horizontal
                                            },
                                            fill_space = true,
                                            spacing = beautiful.notification_margin,
                                            layout = wibox.layout.fixed.vertical
                                        },
                                        -- Margin between the fake background
                                        -- Set to 0 to preserve the 'titlebar' effect
                                        margins = dpi(0),
                                        widget = wibox.container.margin
                                    },
                                    bg = beautiful.transparent,
                                    widget = wibox.container.background
                                },
                                -- Actions
                                actions_template,
                                spacing = dpi(4),
                                layout = wibox.layout.fixed.vertical
                            },
                            bg = beautiful.transparent,
                            id = "background_role",
                            widget = naughty.container.background
                        },
                        strategy = "min",
                        width = dpi(250),
                        widget = wibox.container.constraint
                    },
                    strategy = "max",
                    height = dpi(250),
                    width = dpi(250),
                    widget = wibox.container.constraint
                },
                bg = beautiful.bg_normal,
                shape = gears.shape.rounded_rect,
                widget = wibox.container.background
            }
        }
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Destroy popups if dont_disturb mode is on
        -- Or if the right_panel is visible
        local focused = awful.screen.focused()
        if _G.dont_disturb or (focused.right_panel and focused.right_panel.visible) then
            naughty.destroy_all_notifications()
        end
    end
)
