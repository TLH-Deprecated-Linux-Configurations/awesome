local wibox = require("wibox")
local mat_list_item = require("widget.interface.list-item")
local slider = require("widget.interface.slider")
local icon_button_button = require("widget.interface.icon-button")
local icons = require("theme.icons")
local signals = require("configuration.settings.signals")
local volume = require("widget.hardware.volume")

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
    image = icons.volume_up,
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

local button = icon_button_button(icon)

local function toggleIcon()
    volume.toggle_master()
    signals.emit_volume_update()
end

signals.connect_volume_is_muted(
    function(muted)
        if (muted) then
            icon.image = icons.volume_off
        else
            icon.image = icons.volume_up
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
