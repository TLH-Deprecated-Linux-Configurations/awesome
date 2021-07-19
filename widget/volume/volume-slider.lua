local wibox = require("wibox")
local mat_list_item = require("widget.material.list-item")
local slider = require("module.interface.slider")
local mat_icon_button = require("widget.material.icon-button")
local icons = require("theme.icons")
local signals = require("module.settings.signals")
local volume = require("module.hardware.volume")

local vol_slider =
    slider(
    0,
    100,
    1,
    0,
    function(value)
        signals.emit_volume(value)
    end
)

local icon =
    wibox.widget {
    image = icons.volume,
    widget = wibox.widget.imagebox
}

signals.connect_volume(
    function(value)
        local number = tonumber(value)
        if not (number == vol_slider.value) then
            vol_slider.update(number)
        end
    end
)

local button = mat_icon_button(icon)

local function toggleIcon()
    volume.toggle_master()
    signals.emit_volume_update()
end

signals.connect_volume_is_muted(
    function(muted)
        if (muted) then
            icon.image = icons.muted
        else
            icon.image = icons.volume
        end
    end
)

button:connect_signal("button::press", toggleIcon)

local volume_setting =
    wibox.widget {
    button,
    vol_slider,
    widget = mat_list_item
}

return volume_setting
