
local wibox = require("wibox")
local mat_list_item = require("widget.material.list-item")
local mat_slider = require("lib-widget.progress_bar")
local mat_icon = require("widget.material.icon")
local icons = require("theme.icons")
local dpi = require("beautiful").xresources.apply_dpi
local signals = require("lib-tde.signals")

local slider =
  wibox.widget {
  read_only = true,
  widget = mat_slider
}

signals.connect_disk_usage(
  function(usage)
    slider:set_value(usage)
  end
)

local harddrive_meter =
  wibox.widget {
  wibox.widget {
    icon = icons.harddisk,
    size = dpi(24),
    widget = mat_icon
  },
  slider,
  widget = mat_list_item
}

return harddrive_meter
