--  _______ _____  _____
-- |   |   |     \|     \
-- |       |  --  |  --  |
-- |___|___|_____/|_____/

--  _______         __
-- |   |   |.-----.|  |_.-----.----.
-- |       ||  -__||   _|  -__|   _|
-- |__|_|__||_____||____|_____|__|

local active_color = {
  type = "linear",
  from = {0, 0},
  to = {200, 50}, -- replace with w,h later
  stops = {{0, colors.color25}, {0.75, colors.color14}}
}
local widget_text =
  wibox.widget {
  font = "SF Pro Rounded Heavy  Regular  12",
  text = "HDD",
  valign = "center",
  align = "center",
  widget = wibox.widget.textbox
}

local disk_bar =
  wibox.widget {
  max_value = 100,
  bg = colors.black,
  color = active_color,
  thickness = dpi(12),
  start_angle = 4.3,
  rounded_edge = true,
  colors = {active_color},
  widget = wibox.container.arcchart
}

awesome.connect_signal(
  "signal::disk",
  function(used, available)
    local total = used + available
    local value = math.floor(available / total * 100)
    disk_bar.value = value

    widget_text:set_text("Disk Free " .. value .. "%")
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
    margins = dpi(15),
    widget = wibox.container.margin
  },
  shape = beautiful.client_shape_rounded_xl,
  fg = colors.white,
  widget = wibox.container.background,
  forced_height = dpi(225)
}

return hdd_meter
