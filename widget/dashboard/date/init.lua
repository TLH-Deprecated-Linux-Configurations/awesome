-- Standard awesome library
local awful = require('awful')

-- Theme handling library
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi

-- Widget library
local wibox = require('wibox')

-- Helpers
-- Date
---------

local date_day =
    wibox.widget {
    font = 'Nineteen Ninety Seven Bold 22',
    format = '%d',
    valign = 'center',
    halign = 'center',
    widget = wibox.widget.textclock
}

local date_month =
    wibox.widget {
    font = beautiful.font .. ' 18',
    format = '%B',
    valign = 'center',
    halign = 'center',
    widget = wibox.widget.textclock
}

local date =
    wibox.widget {
    {
        {
            {
                date_day,
                nil,
                date_month,
                expand = 'none',
                widget = wibox.layout.align.vertical
            },
            widget = wibox.container.place,
            valign = 'center',
            halign = 'center'
        },
        widget = wibox.container.margin,
        forced_width = dpi(250),
        forced_height = dpi(150)
    },
    widget = wibox.container.background,
    bg = beautiful.bg_button
}

return date
