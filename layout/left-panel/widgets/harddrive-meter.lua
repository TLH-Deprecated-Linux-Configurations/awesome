local wibox = require("wibox")
local mat_slider = require("widget.interface.progress_bar")
local icons = require("theme.icons")
local dpi = require("beautiful").xresources.apply_dpi
local config = require("widget.functions")
local file = require("widget.functions.file")
local signals = require("widget.settings.signals")
local delayed_timer = require("lib.function.delayed-timer")
local beautiful = require("beautiful")
local noNetwork = true
local gears = require("gears")
local vicious = require("lib.vicious")

local slider =
    wibox.widget {
    read_only = true,
    widget = mat_slider,
    forced_height = 32,
    forced_width = 32
}
signals.connect_disk_usage(
    function(usage)
        slider:set_value(usage)
    end
)

local widget_icon =
    wibox.widget {
    id = "icon",
    image = icons.disc,
    forced_width = 36,
    forced_height = 36,
    widget = wibox.widget.imagebox
}

local fs = wibox.widget.textbox()
vicious.cache(vicious.widgets.fs)
vicious.register(fs, vicious.widgets.fs, "${/ used_p}%")
fs.font = beautiful.font .. " 14"

local harddrive_meter =
    wibox.widget {
    {
        {
            widget_icon,
            fs,
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

return harddrive_meter
