--  ______
-- |   __ \.-----.--.--.--.-----.----.
-- |    __/|  _  |  |  |  |  -__|   _|
-- |___|   |_____|________|_____|__|

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
    image = icons.bluetooth_off,
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

local power_status = false

widget:connect_signal(
  "mouse::enter",
  function()
    if power_status == false then
      widget_icon.icon:set_image(icons.bluetooth_on)
      widget.bg = colors.color8
    elseif power_status == true then
      widget_icon.icon:set_image(icons.bluetooth_off)
      widget.bg = colors.colorA
    end
  end
)

widget:connect_signal(
  "mouse::leave",
  function()
    if power_status == false then
      widget_icon.icon:set_image(icons.bluetooth_off)
      widget.bg = colors.colorA
    elseif power_status == true then
      widget_icon.icon:set_image(icons.bluetooth_on)
      widget.bg = colors.color8
    end
  end
)

awesome.connect_signal(
  "bluetooth::power:toggle",
  function()
    if power_status == false then
      power_status = true
      awful.spawn.with_shell("bluetoothctl power on")
      widget_icon.icon:set_image(icons.bluetooth_on)
      widget.bg = colors.color8
    elseif power_status == true then
      power_status = false
      awful.spawn.with_shell("bluetoothctl power off")
      widget_icon.icon:set_image(icons.bluetooth_off)
      widget.bg = colors.colorA
    end
  end
)

awesome.connect_signal(
  "bluetooth::power:refresh",
  function()
    awful.spawn.easy_async_with_shell(
      [[bash -c "bluetoothctl show | sed -n '5p'"]],
      function(stdout)
        stdout = stdout:match("[%w:]+", 10)
        if stdout == "yes" then
          power_status = true
          widget_icon.icon:set_image(icons.bluetooth_on)
          widget.bg = colors.color8
        elseif stdout == "no" then
          power_status = false
          widget_icon.icon:set_image(icons.bluetooth_off)
          widget.bg = colors.colorA
        end
      end
    )
  end
)

widget:buttons(
  gears.table.join(
    awful.button(
      {},
      1,
      nil,
      function()
        awesome.emit_signal("bluetooth::power:toggle")
      end
    )
  )
)

return widget
