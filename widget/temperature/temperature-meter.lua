local wibox = require("wibox")
local mat_list_item = require("widget.material.list-item")
local mat_slider = require("module.ui-components.progress_bar")
local mat_icon = require("widget.material.icon")
local icons = require("theme.icons")
local dpi = require("beautiful").xresources.apply_dpi
local config = require("module.functions")
local file = require("module.file")
local signals = require("module.signals")
local delayed_timer = require("lib.function.delayed-timer")
local beautiful = require("beautiful")
local noNetwork = true
local gears = require("gears")
local vicious = require("lib.vicious")
signals.connect_wifi_status(
    function(status)
        noNetwork = not status
    end
)

local slider =
    wibox.widget {
    read_only = true,
    widget = mat_slider,
    forced_height = 32,
    forced_width = 32
}

local max_temp = 90

delayed_timer(
    config.temp_poll,
    function()
        if noNetwork then
            return
        end
        local stdout = file.string("/sys/class/thermal/thermal_zone0/temp") or ""
        if stdout == "" then
            return
        end
        local temp = stdout:match("(%d+)")
        slider:set_value((temp / 1000) / max_temp * 100)
        print("Current temperature: " .. (temp / 1000) .. " °C")
    end,
    config.temp_startup_delay
)
local widget_icon =
    wibox.widget {
    id = "icon",
    image = icons.thermometer,
    forced_width = 36,
    forced_height = 36,
    widget = wibox.widget.imagebox
}

local temp = wibox.widget.textbox()
vicious.cache(vicious.widgets.thermal)
vicious.register(temp, vicious.widgets.thermal, "$1°C", 4, "thermal_zone0")
temp.font = beautiful.font .. " 14"

local temperature_meter =
    wibox.widget {
    {
        {
            widget_icon,
            temp,
            spacing = dpi(1),
            layout = wibox.layout.flex.horizontal
        },
        top = dpi(2),
        bottom = dpi(2),
        left = dpi(1),
        right = dpi(1),
        widget = wibox.container.margin
    },
    shape = gears.shape.rounded_rect,
    bg = beautiful.bg_normal .. "77",
    shape_border_color = beautiful.bg_normal,
    shape_border_width = dpi(3),
    widget = wibox.container.background
}

return temperature_meter
