--  _______
-- |_     _|.-----.--------.-----.
--   |   |  |  -__|        |  _  |
--   |___|  |_____|__|__|__|   __|
--                         |__|
--  _______         __
-- |   |   |.-----.|  |_.-----.----.
-- |       ||  -__||   _|  -__|   _|
-- |__|_|__||_____||____|_____|__|
-- ------------------------------------------------- --
local active_color = {
  type = "linear",
  from = {0, 0},
  to = {200, 50}, -- replace with w,h later
  stops = {{0, colors.color6}, {0.75, colors.color4}}
}
-- ------------------------------------------------- --
local widget_text =
  wibox.widget {
  font = "Nineteen Ninety Seven Bold  12",
  text = "TEMP",
  valign = "center",
  align = "center",
  widget = wibox.widget.textbox
}
-- ------------------------------------------------- --
local temp_bar =
  wibox.widget {
  max_value = 100,
  bg = colors.black,
  thickness = dpi(12),
  start_angle = 4.3,
  rounded_edge = true,
  colors = {active_color},
  widget = wibox.container.arcchart
}
-- ------------------------------------------------- --
awesome.connect_signal(
  "signal::temp",
  function(temp)
    temp_bar.value = temp
    widget_text:set_text("Temp \n" .. math.floor(temp) .. "°")
  end
)
local max_temp = 80
-- ------------------------------------------------- --
local temp_meter =
  wibox.widget {
  {
    {
      {
        temp_bar,
        direction = "east",
        widget = wibox.container.rotate
      },
      widget_text,
      layout = wibox.layout.stack
    },
    margins = dpi(15),
    widget = wibox.container.margin
  },
  shape = beautiful.client_shape_rounded_xl,
  fg = colors.white,
  forced_height = dpi(225),
  widget = wibox.container.background
}
-- ------------------------------------------------- --
return temp_meter
