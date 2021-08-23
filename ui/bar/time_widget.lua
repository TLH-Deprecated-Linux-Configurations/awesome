-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Time Widget -----
local awful = require('awful')
local gears = require('gears')
local gfs = require('gears.filesystem')
local wibox = require('wibox')
local beautiful = require('beautiful')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi
local helpers = require('helpers')

local time_pill = {}
local time_text =
    wibox.widget {
    font = beautiful.font,
    format = '%l:%M %P',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textclock
}

time_text.markup = "<span foreground='" .. beautiful.xcolor15 .. "'>" .. time_text.text .. '</span>'

time_text:connect_signal(
    'widget::redraw_needed',
    function()
        time_text.markup = "<span foreground='" .. beautiful.xcolor15 .. "'>" .. time_text.text .. '</span>'
    end
)

local time_icon =
    wibox.widget {
    font = beautiful.icon_font_name .. '18',
    markup = "<span foreground='" .. beautiful.xcolor7 .. "'></span>",
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local time_pill =
    wibox.widget {
    {
        {time_icon, top = dpi(1), widget = wibox.container.margin},
        helpers.horizontal_pad(10),
        {time_text, top = dpi(1), widget = wibox.container.margin},
        layout = wibox.layout.fixed.horizontal
    },
    left = dpi(10),
    right = dpi(10),
    widget = wibox.container.margin
}
return time_pill
