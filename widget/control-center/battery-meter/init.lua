local main_color = colors.color6
local active_color = {
  type = "linear",
  from = {0, 0},
  to = {200, 50}, -- replace with w,h later
  stops = {{0, colors.color5}, {0.75, colors.color9}}
}

local widget_text =
  wibox.widget {
  font = "Nineteen Ninety Seven  12",
  text = "PWR",
  valign = "center",
  align = "center",
  widget = wibox.widget.textbox
}

local battery_bar =
  wibox.widget {
  max_value = 100,
  background_color = beautiful.bg_normal,
  color = active_color,
  shape = gears.shape.squircle,
  widget = wibox.widget.progressbar
}

awesome.connect_signal(
  "signal::battery",
  function(percentage, state)
    battery_bar.value = percentage
    widget_text:set_text("Battery " .. percentage .. "%")
  end
)

local batt_meter =
  wibox.widget {
  {
    {
      {
        battery_bar,
        direction = "east",
        widget = wibox.container.rotate
      },
      widget_text,
      layout = wibox.layout.stack
    },
    margins = dpi(30),
    widget = wibox.container.margin
  },
  shape = gears.shape.rounded_rect,
  bg = colors.colorA,
  fg = colors.white,
  forced_height = dpi(185),
  widget = wibox.container.background
}

return batt_meter
