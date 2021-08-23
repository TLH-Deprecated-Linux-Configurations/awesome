local awful = require('awful')
local gears = require('gears')
local gfs = require('gears.filesystem')
local wibox = require('wibox')
local beautiful = require('beautiful')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi
local helpers = require('helpers')

local battery_pill = {}
local battery_text =
    wibox.widget {
    font = beautiful.font,
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local battery_icon =
    wibox.widget {
    font = beautiful.icon_font_name .. '18',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local battery_pill =
    wibox.widget {
    {
        {battery_icon, top = dpi(1), widget = wibox.container.margin},
        helpers.horizontal_pad(10),
        {battery_text, top = dpi(1), widget = wibox.container.margin},
        layout = wibox.layout.fixed.horizontal
    },
    left = dpi(10),
    right = dpi(10),
    widget = wibox.container.margin
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
awesome.connect_signal(
    'signal::battery',
    function(percentage, state)
        local value = percentage

        local bat_icon = ''

        if value >= 90 and value <= 100 then
            bat_icon = ''
        elseif value >= 70 and value < 90 then
            bat_icon = ''
        elseif value >= 60 and value < 70 then
            bat_icon = ''
        elseif value >= 50 and value < 60 then
            bat_icon = ''
        elseif value >= 30 and value < 50 then
            bat_icon = ''
        elseif value >= 15 and value < 30 then
            bat_icon = ''
        else
            bat_icon = ''
        end
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- if charging
        if state == 1 then
            bat_icon = ''
        end

        -- if full
        if state == 4 then
            bat_icon = ''
        end

        battery_icon.markup = "<span foreground='" .. beautiful.xcolor7 .. "'>" .. bat_icon .. '</span>'
        battery_text.markup =
            "<span foreground='" .. beautiful.xcolor15 .. "'>" .. string.format('%1d', value) .. '%' .. '</span>'
    end
)

return battery_pill
