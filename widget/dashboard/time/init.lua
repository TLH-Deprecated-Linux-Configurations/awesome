--  _______ __
-- |_     _|__|.--------.-----.
--   |   | |  ||        |  -__|
--   |___| |__||__|__|__|_____|
-- ------------------------------------------------- --
-- Standard awesome library
local awful = require('awful')

-- Theme handling library
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi

-- Widget library
local wibox = require('wibox')

-- ------------------------------------------------- --

local time_hour =
    wibox.widget {
    font = beautiful.font .. ' Bold 54',
    fg = colors.colorA,
    format = '%H',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textclock
}

local time_min =
    wibox.widget {
    font = beautiful.font .. ' Bold 54',
    format = '%M',
    align = 'center',
    valign = 'center',
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
                valign = 'center',
                halign = 'center'
            },
            widget = wibox.container.margin
        },
        widget = wibox.container.background
    },
    spacing = dpi(25),
    layout = wibox.layout.fixed.horizontal,
    widget = wibox.container.background
}

return time
