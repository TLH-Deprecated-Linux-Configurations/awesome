local wibox = require('wibox')
local mat_list_item = require('widget.material.list-item')
local mat_slider = require('lib.progress_bar')
local mat_icon = require('widget.material.icon')
local icons = require('theme.icons')
local dpi = require('beautiful').xresources.apply_dpi
local config = require('config')
local file = require('lib.file')
local signals = require('module.signals')
local delayed_timer = require('lib.function.delayed-timer')

local noNetwork = true

signals.connect_wifi_status(
    function(status)
        noNetwork = not status
    end
)

local slider =
    wibox.widget {
    read_only = true,
    widget = mat_slider
}

local max_temp = 80

delayed_timer(
    config.temp_poll,
    function()
        if noNetwork then
            return
        end
        local stdout = file.string('/sys/class/thermal/thermal_zone0/temp') or ''
        if stdout == '' then
            return
        end
        local temp = stdout:match('(%d+)')
        slider:set_value((temp / 1000) / max_temp * 100)
        print('Current temperature: ' .. (temp / 1000) .. ' °C')
    end,
    config.temp_startup_delay
)

local temperature_meter =
    wibox.widget {
    wibox.widget {
        icon = icons.thermometer,
        size = dpi(24),
        widget = mat_icon
    },
    slider,
    widget = mat_list_item
}

return temperature_meter
