--  ______
-- |   __ \.---.-.--------.
-- |      <|  _  |        |
-- |___|__||___._|__|__|__|
--  _______         __
-- |   |   |.-----.|  |_.-----.----.
-- |       ||  -__||   _|  -__|   _|
-- |__|_|__||_____||____|_____|__|
-- ------------------------------------------------- --
local active_color = {
  type = "linear",
  from = {0, 0},
  to = {200, 50},
  stops = {{0, colors.color14}, {0.75, colors.color9}}
}

local widget_text =
  wibox.widget {
  font = "Nineteen Ninety Seven Bold  12",
  text = "RAM",
  valign = "center",
  align = "center",
  widget = wibox.widget.textbox
}

local ram_bar =
  wibox.widget {
  max_value = 100,
  bg = colors.black,
  thickness = dpi(12),
  start_angle = 4.3,
  rounded_edge = true,
  colors = {active_color},
  widget = wibox.container.arcchart
}

awesome.connect_signal(
  "signal::ram",
  function(used, total)
    local r_average = math.floor((used / total) * 100)
    -- the below will render used gigabytes if that is preferred, switch the widget_text variable from r_average to r_used in the tostring function
    -- local r_used = string.format("%.1f", used / 1000) .. "G"

    ram_bar.value = r_average
    widget_text.markup = "RAM \n" .. tostring(r_average) .. "%"
  end
)

local ram_meter =
  wibox.widget {
  {
    {
      {
        ram_bar,
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
  bg = beautiful.bg_focus,
  fg = colors.white,
  forced_height = dpi(225),
  widget = wibox.container.background
}

return ram_meter
