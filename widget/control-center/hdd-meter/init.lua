local wibox = require("wibox")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi
local colors = require("themes").colors
local watch = require("awful.widget.watch")

local active_color = {
  type = "linear",
  from = {0, 0},
  to = {200, 50}, -- replace with w,h later
  stops = {{0, colors.color12}, {0.75, colors.color2}}
}
local widget_text =
  wibox.widget {
  font = "Nineteen Ninety Seven  Regular  12",
  text = "HDD",
  valign = "center",
  align = "center",
  widget = wibox.widget.textbox
}

local disk_bar =
  wibox.widget {
  max_value = 100,
  background_color = beautiful.bg_normal,
  color = active_color,
  shape = gears.shape.squircle,
  widget = wibox.widget.progressbar
}

awesome.connect_signal(
  "signal::disk",
  function(value)
    disk_bar.value = value
    widget_text:set_text("Disk Free " .. math.floor(value) .. "%")
  end
)

local hdd_meter =
  wibox.widget {
  {
    {
      {
        disk_bar,
        direction = "east",
        widget = wibox.container.rotate
      },
      widget_text,
      layout = wibox.layout.stack
    },
    margins = dpi(30),
    widget = wibox.container.margin
  },
  shape = beautiful.client_shape_rounded_xl,
  bg = colors.colorA,
  fg = colors.white,
  widget = wibox.container.background,
  forced_height = dpi(185)
}

return hdd_meter
