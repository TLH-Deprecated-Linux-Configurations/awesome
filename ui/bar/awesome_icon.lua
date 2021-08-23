local awful = require('awful')
local gears = require('gears')
local gfs = require('gears.filesystem')
local wibox = require('wibox')
local beautiful = require('beautiful')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi
local helpers = require('helpers')
local icons = require 'icons.matangi'
local awesome_icon = {}

local distro = gears.color.recolor_image(icons.menu_boxed, beautiful.xcolor7)
local icon1 =
    wibox.widget {
    widget = wibox.widget.imagebox,
    image = distro,
    resize = true
}

local awesome_icon =
    wibox.widget {
    {
        icon1,
        top = dpi(3),
        bottom = dpi(3),
        left = dpi(3),
        right = dpi(3),
        widget = wibox.container.margin
    },
    widget = wibox.container.background
}

awesome_icon:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            function()
                awesome.emit_signal('widgets::start::toggle', mouse.screen)
            end
        )
    )
)

return awesome_icon
