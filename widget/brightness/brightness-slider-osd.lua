local wibox = require('wibox')
local mat_list_item = require('widget.material.list-item')
local slider = require('lib.slider')
local mat_icon_button = require('widget.material.icon-button')
local icons = require('theme.icons')
local spawn = require('awful.spawn')
local signals = require('module.signals')

local slider_osd =
    slider(
    0,
    100,
    1,
    0,
    function(value)
        if (_G.menuopened) then
            signals.emit_brightness(tonumber(value))
        end
        if (_G.oled) then
            spawn('brightness -s ' .. math.max(value, 5) .. ' -F') -- toggle pixel values
        else
            spawn('brightness -s 100 -F') -- reset pixel values
            spawn('brightness -s ' .. math.max(value, 5))
        end
    end
)
_G.brightness2 = slider_osd

slider_osd:connect_signal(
    'button::press',
    function()
        slider_osd:connect_signal(
            'property::value',
            function()
                _G.toggleBriOSD(true)
            end
        )
    end
)

local function UpdateBrOSD()
    if (_G.oled) then
        awful.spawn.easy_async_with_shell(
            'brightness -g -F',
            function(stdout)
                local brightness = string.match(stdout, '(%d+)')
                slider_osd.update(tonumber(brightness))
            end
        )
    else
        awful.spawn.easy_async_with_shell(
            'brightness -g',
            function(stdout)
                local brightness = string.match(stdout, '(%d+)')
                slider_osd.update(tonumber(brightness))
            end
        )
    end
end

_G.UpdateBrOSD = UpdateBrOSD

local icon =
    wibox.widget {
    image = icons.brightness,
    widget = wibox.widget.imagebox
}

local button = mat_icon_button(icon)

local brightness_setting_osd =
    wibox.widget {
    button,
    slider_osd,
    widget = mat_list_item
}

return brightness_setting_osd
