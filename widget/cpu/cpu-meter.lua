
local wibox = require("wibox")
local mat_list_item = require("widget.material.list-item")
local mat_slider = require("lib-widget.progress_bar")
local mat_icon = require("widget.material.icon")
local icons = require("theme.icons")
local dpi = require("beautiful").xresources.apply_dpi
local config = require("config")
local total_prev = 0
local idle_prev = 0
local file = require("lib-tde.file")
local signals = require("lib-tde.signals")
local delayed_timer = require("lib-tde.function.delayed-timer")

local slider =
  wibox.widget {
  read_only = true,
  widget = mat_slider
}

delayed_timer(
  config.cpu_poll,
  function()
    local stdout = file.string("/proc/stat", "^cpu")
    if stdout == "" then
      return
    end
    local user, nice, system, idle, iowait, irq, softirq, steal, _, _ =
      stdout:match("(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s")

    local total = user + nice + system + idle + iowait + irq + softirq + steal

    local diff_idle = idle - idle_prev
    local diff_total = total - total_prev
    local diff_usage = (1000 * (diff_total - diff_idle) / diff_total + 5) / 10

    slider:set_value(diff_usage)
    print("CPU usage: " .. diff_usage .. "%")
    signals.emit_cpu_usage(diff_usage)

    total_prev = total
    idle_prev = idle
  end,
  config.cpu_startup_delay
)

local cpu_meter =
  wibox.widget {
  wibox.widget {
    icon = icons.chart,
    size = dpi(24),
    widget = mat_icon
  },
  slider,
  widget = mat_list_item
}

return cpu_meter
