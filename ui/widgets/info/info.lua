local gears = require('gears')
local wibox = require('wibox')
local beautiful = require('beautiful')
local naughty = require('naughty')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi

local pixbuf = require('lgi').GdkPixbuf
local cairo = require('lgi').cairo

local helpers = require('helpers')

local area =
    wibox.widget {
    {
        {
            {
                {
                    image = beautiful.me,
                    resize = true,
                    forced_height = dpi(120),
                    forced_width = dpi(120),
                    widget = wibox.widget.imagebox
                },
                left = dpi(20),
                right = dpi(20),
                top = dpi(5),
                bottom = dpi(5),
                widget = wibox.container.margin
            },
            bg = beautiful.xcolor0 .. 'aa',
            border_color = beautiful.xcolor7,
            border_width = dpi(3),
            shape = gears.shape.circle,
            widget = wibox.container.background
        },
        top = dpi(0),
        bottom = dpi(0),
        widget = wibox.container.margin
    },
    halign = 'center',
    valign = 'center',
    widget = wibox.container.place
}

return area
