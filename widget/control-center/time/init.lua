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
    font = "Nineteen Ninety Seven Bold 24",
    fg = colors.colorA,
    format = "%H",
    align = "center",
    valign = "center",
    widget = wibox.widget.textclock
}

local time_min =
    wibox.widget {
    font = "Nineteen Ninety Seven Bold 24",
    format = "%M",
    align = "center",
    valign = "center",
    widget = wibox.widget.textclock
}

local time =
    wibox.widget {
    {
        {
            {
                {
                    time_hour,
                    time_min,
                    spacing = dpi(25),
                    layout = wibox.layout.fixed.horizontal
                },
                widget = wibox.container.place,
                valign = "center",
                halign = "center"
            },
            widget = wibox.container.margin,
            forced_width = dpi(240),
            forced_height = dpi(100)
        },
        widget = wibox.container.background,
        bg = beautiful.bg_focus
    },
    spacing = dpi(25),
    widget = wibox.layout.fixed.horizontal
}

return time
