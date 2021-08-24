local awful = require('awful')
local gears = require('gears')
local gfs = require('gears.filesystem')
local wibox = require('wibox')
local beautiful = require('beautiful')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi
local helpers = require('helpers')

local systray_widget = {}
local mysystray = wibox.widget.systray()
--mysystray:set_base_size(beautiful.systray_icon_size)

local mysystray_container = {
    mysystray,
    left = dpi(4),
    right = dpi(4),
    top = dpi(2),
    bottom = dpi(2),
    widget = wibox.container.margin,
    bg = beautiful.xbackground .. '00'
}

return systray_widget
