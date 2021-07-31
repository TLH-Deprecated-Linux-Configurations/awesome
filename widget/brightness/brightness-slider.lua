-- TODO make this work
local wibox = require("wibox")
local mat_list_item = require("module.interface.material.list-item")
local slider = require("module.interface.slider")
local mat_icon_button = require("module.interface.material.icon-button")
local icons = require("theme.icons")
local signals = require("module.settings.signals")

local spawn = require("awful.spawn")

local brightness_slider =
    slider(
    5,
    100,
    1,
    5,
    function(value)
        if (_G.menuopened) then
            _G.brightness2.update(value)
        end
        if (_G.oled) then
            spawn("brightness -s " .. value .. " -F") -- toggle pixel values
        else
            spawn("brightness -s 100 -F") -- reset pixel values
            spawn("brightness -s " .. value)
        end
    end
)

_G.brightness1 = brightness_slider

local update = function()
    awful.spawn.easy_async_with_shell(
        [[grep -q on ~/.cache/oled && brightness -g -F || brightness -g]],
        function(stdout)
            local brightness = string.match(stdout, "(%d+)")
            signals.emit_brightness(tonumber(brightness))
        end
    )
end

awesome.connect_signal(
    "widget::brightness",
    function(_)
        update()
    end
)

-- The emit will come from the OSD
signals.connect_brightness(
    function(value)
        brightness_slider.update(value)
    end
)

local icon =
    wibox.widget {
    image = icons.sun,
    widget = wibox.widget.imagebox
}

local button = mat_icon_button(icon)

local brightness_setting =
    wibox.widget {
    button,
    brightness_slider,
    widget = mat_list_item
}

return brightness_setting
