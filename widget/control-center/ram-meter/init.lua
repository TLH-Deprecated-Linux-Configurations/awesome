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
  to = {200, 50}, -- replace with w,h later
  stops = {{0, colors.color14}, {0.75, colors.color6}}
}

local widget_text =
  wibox.widget {
  font = "SF Pro Rounded Heavy 12",
  text = "RAM",
  valign = "center",
  align = "center",
  widget = wibox.widget.textbox
}

local ram_bar =
  wibox.widget {
  max_value = 100,
  background_color = beautiful.bg_normal,
  color = active_color,
  shape = gears.shape.squircle,
  widget = wibox.widget.progressbar
}

awesome.connect_signal(
  "signal::ram",
  function(used, total)
    local used_ram_percentage = (used / total) * 100
    ram_bar.value = used_ram_percentage
    widget_text:set_text("RAM \n" .. math.floor((used / total) * 100) .. "%")
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
    margins = dpi(30),
    widget = wibox.container.margin
  },
  shape = gears.shape.rounded_rect,
  bg = colors.colorA,
  fg = colors.white,
  forced_height = dpi(185),
  widget = wibox.container.background
}

return ram_meter
