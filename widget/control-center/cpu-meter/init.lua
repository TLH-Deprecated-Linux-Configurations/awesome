local active_color = {
  type = "linear",
  from = {0, 0},
  to = {200, 50}, -- replace with w,h later
  stops = {{0, colors.color7}, {0.75, colors.color4}}
}

local widget_text =
  wibox.widget {
  font = "Nineteen Ninety Seven  12",
  text = "CPU",
  valign = "center",
  align = "center",
  widget = wibox.widget.textbox
}

local cpu_bar =
  wibox.widget {
  max_value = 100,
  background_color = beautiful.bg_normal,
  color = active_color,
  shape = gears.shape.squircle,
  widget = wibox.widget.progressbar
}

awesome.connect_signal(
  "signal::cpu",
  function(value)
    cpu_bar.value = value
    widget_text:set_text("CPU \n" .. value .. "%")
  end
)

local cpu_meter =
  wibox.widget {
  {
    {
      {
        cpu_bar,
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

return cpu_meter
