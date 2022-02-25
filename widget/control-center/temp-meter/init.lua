--DEPENDENCIES
--lm_sensors

local active_color = {
  type = "linear",
  from = {0, 0},
  to = {200, 50}, -- replace with w,h later
  stops = {{0, colors.color6}, {0.75, colors.color4}}
}
local widget_text =
  wibox.widget {
  font = "Nineteen Ninety Seven  Regular  12",
  text = "TEMP",
  valign = "center",
  align = "center",
  widget = wibox.widget.textbox
}
local temp_bar =
  wibox.widget {
  max_value = 100,
  background_color = beautiful.bg_normal,
  color = active_color,
  shape = gears.shape.squircle,
  widget = wibox.widget.progressbar
}
awesome.connect_signal(
  "signal::temp",
  function(temp)
    temp_bar.value = temp
    widget_text:set_text("Temp \n" .. math.floor(temp) .. "°")
  end
)
local max_temp = 80

local temp_meter =
  wibox.widget {
  {
    {
      {
        {
          direction = "east",
          widget = wibox.container.rotate,
          temp_bar
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
    widget = wibox.container.background
  },
  forced_height = dpi(185),
  widget = wibox.container.margin
}

return temp_meter
