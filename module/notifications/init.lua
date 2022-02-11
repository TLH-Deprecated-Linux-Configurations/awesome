local naughty = require("naughty")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")
local dpi = beautiful.xresources.apply_dpi

local ruled = require("ruled")

require("module.notifications.brightness")

require("module.notifications.volume")
require("module.notifications.battery")

naughty.config.defaults.ontop = true
naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.timeout = 3
naughty.config.defaults.title = "System Notification"
naughty.config.defaults.position = "top_right"

naughty.config.icon_dirs = {
    "/usr/share/icons/chhinamasta/",
    "/usr/share/pixmaps/"
}
naughty.config.icon_formats = {"png", "svg"}

-- Timeouts
naughty.config.presets.low.timeout = 3
naughty.config.presets.critical.timeout = 0

naughty.config.presets.normal = {
    font = "Nineteen Ninety Seven 18",
    fg = beautiful.fg_normal,
    bg = beautiful.bg_normal
}

naughty.config.presets.low = {
    font = "Nineteen Ninety Seven 18",
    fg = beautiful.fg_normal,
    bg = beautiful.bg_normal
}

naughty.config.presets.critical = {
    font = "Nineteen Ninety Seven 18",
    fg = beautiful.fg_normal,
    bg = beautiful.bg_normal,
    timeout = 0
}

naughty.config.presets.ok = naughty.config.presets.normal
naughty.config.presets.info = naughty.config.presets.normal
naughty.config.presets.warn = naughty.config.presets.critical

ruled.notification.connect_signal(
    "request::rules",
    function()
        -- All notifications will match this rule.
        ruled.notification.append_rule {
            rule = {},
            properties = {screen = awful.screen.preferred, implicit_timeout = 6}
        }
    end
)

naughty.connect_signal(
    "request::display",
    function(n)
        local appicon = n.app_icon
        if not appicon then
            appicon = beautiful.notification_icon
        end
        local time = os.date("%H:%M")

        local action_widget = {
            {
                {
                    id = "text_role",
                    align = "center",
                    valign = "center",
                    font = "Nineteen Ninety Seven 18",
                    widget = wibox.widget.textbox
                },
                left = dpi(6),
                right = dpi(6),
                widget = wibox.container.margin
            },
            bg = beautiful.bg_normal,
            forced_height = dpi(25),
            forced_width = dpi(20),
            shape = beautiful.client_shape_rounded,
            widget = wibox.container.background
        }

        local actions =
            wibox.widget {
            notification = n,
            base_layout = wibox.widget {
                spacing = dpi(8),
                layout = wibox.layout.flex.horizontal
            },
            widget_template = action_widget,
            style = {underline_normal = false, underline_selected = true},
            widget = naughty.list.actions
        }

        naughty.layout.box {
            notification = n,
            type = "notification",
            bg = beautiful.bg_normal,
            widget_template = {
                {
                    {
                        {
                            {
                                {
                                    {
                                        {
                                            {
                                                image = appicon,
                                                resize = true,
                                                clip_shape = beautiful.client_shape_rounded_small,
                                                widget = wibox.widget.imagebox
                                            },
                                            strategy = "max",
                                            height = dpi(20),
                                            widget = wibox.container.constraint
                                        },
                                        right = dpi(10),
                                        widget = wibox.container.margin
                                    },
                                    {
                                        markup = n.app_name,
                                        align = "left",
                                        font = "Nineteen Ninety Seven 18",
                                        widget = wibox.widget.textbox
                                    },
                                    {
                                        markup = time,
                                        align = "right",
                                        font = "Nineteen Ninety Seven 18",
                                        widget = wibox.widget.textbox
                                    },
                                    layout = wibox.layout.align.horizontal
                                },
                                top = dpi(7),
                                left = dpi(20),
                                right = dpi(20),
                                bottom = dpi(5),
                                widget = wibox.container.margin
                            },
                            bg = beautiful.bg_normal,
                            widget = wibox.container.background
                        },
                        {
                            {
                                {
                                    {
                                        {
                                            step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
                                            speed = 50,
                                            {
                                                markup = "<span weight='bold'>" .. n.title .. "</span>",
                                                font = "Nineteen Ninety Seven 18",
                                                align = "left",
                                                widget = wibox.widget.textbox
                                            },
                                            forced_width = dpi(204),
                                            widget = wibox.container.scroll.horizontal
                                        },
                                        {
                                            {
                                                markup = n.message,
                                                align = "left",
                                                font = "Nineteen Ninety Seven 18",
                                                widget = wibox.widget.textbox
                                            },
                                            right = 10,
                                            widget = wibox.container.margin
                                        },
                                        spacing = 0,
                                        layout = wibox.layout.flex.vertical
                                    },
                                    layout = wibox.layout.align.vertical
                                },
                                left = dpi(20),
                                right = dpi(20),
                                widget = wibox.container.margin
                            },
                            {
                                {
                                    nil,
                                    {
                                        {
                                            image = n.icon,
                                            resize = true,
                                            clip_shape = beautiful.client_shape_rounded_small,
                                            widget = wibox.widget.imagebox
                                        },
                                        strategy = "max",
                                        height = 40,
                                        widget = wibox.container.constraint
                                    },
                                    nil,
                                    expand = "none",
                                    layout = wibox.layout.align.vertical
                                },
                                top = dpi(0),
                                left = dpi(10),
                                right = dpi(10),
                                bottom = dpi(0),
                                widget = wibox.container.margin
                            },
                            layout = wibox.layout.fixed.horizontal
                        },
                        {
                            {actions, layout = wibox.layout.fixed.vertical},
                            margins = dpi(10),
                            visible = n.actions and #n.actions > 0,
                            widget = wibox.container.margin
                        },
                        layout = wibox.layout.fixed.vertical
                    },
                    top = dpi(0),
                    bottom = dpi(5),
                    widget = wibox.container.margin
                },
                bg = beautiful.xbackground,
                border_width = beautiful.notif_border_width,
                border_color = "#1b1d24aa",
                shape = beautiful.client_shape_rounded,
                widget = wibox.container.background
            }
        }
    end
)
