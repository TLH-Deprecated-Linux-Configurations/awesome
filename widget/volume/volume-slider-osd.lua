-- I decided to create another slider for the OSD's
-- So we can modify its behavior without messing
-- the slider in the dashboard.
-- Excuse my messy code.

local wibox = require("wibox")
local mat_list_item = require("module.interface.material.list-item")
local slider = require("module.interface.slider")
local mat_icon_button = require("module.interface.material.icon-button")
local icons = require("theme.icons")
local signal = require("module.settings.signals")
local volume = require("module.hardware.volume")

local slider_osd =
    slider(
    0,
    100,
    1,
    0,
    function(value)
        signal.emit_volume(value)
    end
)

signal.connect_volume(
    function(value)
        local number = tonumber(value)
        if not (number == slider_osd.value) then
            slider_osd.update(number)
        end
    end
)

local icon =
    wibox.widget {
    image = icons.volume,
    widget = wibox.widget.imagebox
}

local button = mat_icon_button(icon)

button:connect_signal(
    "button::press",
    function()
        volume.toggle_master()
        signal.emit_volume_update()
    end
)

signal.connect_volume_is_muted(
    function(muted)
        if (muted) then
            icon.image = icons.volume_off
        else
            icon.image = icons.volume_up
        end
    end
)

local volume_setting_osd =
    wibox.widget {
    button,
    slider_osd,
    widget = mat_list_item
}

return volume_setting_osd
