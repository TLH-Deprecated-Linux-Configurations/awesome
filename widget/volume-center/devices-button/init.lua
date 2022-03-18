--  _____               __
-- |     \.-----.--.--.|__|.----.-----.-----.
-- |  --  |  -__|  |  ||  ||  __|  -__|__ --|
-- |_____/|_____|\___/ |__||____|_____|_____|

--  ______         __   __
-- |   __ \.--.--.|  |_|  |_.-----.-----.
-- |   __ <|  |  ||   _|   _|  _  |     |
-- |______/|_____||____|____|_____|__|__|
-- ------------------------------------------------- --

local widget_icon =
  wibox.widget {
  layout = wibox.layout.align.vertical,
  expand = "none",
  nil,
  {
    id = "icon",
    image = icons.devices,
    resize = true,
    widget = wibox.widget.imagebox
  },
  nil
}

local widget =
  wibox.widget {
  {
    {
      {
        widget_icon,
        layout = wibox.layout.fixed.horizontal
      },
      margins = dpi(15),
      widget = wibox.container.margin
    },
    forced_height = dpi(50),
    widget = clickable_container
  },
  shape = beautiful.client_shape_rounded_small,
  bg = colors.colorA,
  widget = wibox.container.background
}

widget:connect_signal(
  "mouse::enter",
  function()
    widget.bg = colors.color3
  end
)

widget:connect_signal(
  "mouse::leave",
  function()
    widget.bg = colors.colorA
  end
)

widget:buttons(
  gears.table.join(
    awful.button(
      {},
      1,
      nil,
      function()
        awesome.emit_signal("volume::devices:refreshPanel")
      end
    )
  )
)

return widget
