-- Standard awesome library
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Widget library
local wibox = require("wibox")

-- Helpers

-- Time
---------

local time_hour =
    wibox.widget {
    font = "Nineteen Ninety Seven Bold 18",
    fg = colors.colorA,
    format = "%H",
    align = "center",
    valign = "center",
    widget = wibox.widget.textclock
}

local time_min =
    wibox.widget {
    font = "Nineteen Ninety Seven Bold 18",
    format = "%M",
    align = "center",
    valign = "center",
    widget = wibox.widget.textclock
}

local time =
    wibox.widget {
    {
        time_hour,
        time_min,
        widget = wibox.container.background,
        layout = wibox.layout.fixed.horizontal,
        bg = beautiful.bg_focus,
        spacing = dpi(25)
    },
    spacing = dpi(25),
    widget = wibox.layout.fixed.horizontal
}

return time
