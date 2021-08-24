-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Date Widget -----
local awful = require('awful')
local gears = require('gears')
local gfs = require('gears.filesystem')
local wibox = require('wibox')
local beautiful = require('beautiful')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi
local helpers = require('helpers')

local date_pill = {}
local date_text =
    wibox.widget {
    font = beautiful.font,
    format = '%m/%d/%y',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textclock
}

date_text.markup = "<span foreground='" .. beautiful.xcolor15 .. "'>" .. date_text.text .. '</span>'

date_text:connect_signal(
    'widget::redraw_needed',
    function()
        date_text.markup = "<span foreground='" .. beautiful.xcolor15 .. "'>" .. date_text.text .. '</span>'
    end
)

local date_icon =
    wibox.widget {
    font = beautiful.icon_font_name .. '18',
    markup = "<span foreground='" .. beautiful.xcolor7 .. "'></span>",
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local date_pill =
    wibox.widget {
    {
        {date_icon, top = dpi(1), widget = wibox.container.margin},
        helpers.horizontal_pad(10),
        {date_text, top = dpi(1), widget = wibox.container.margin},
        layout = wibox.layout.fixed.horizontal
    },
    left = dpi(10),
    right = dpi(10),
    widget = wibox.container.margin
}

return date_pill
