--  ______ __               __                __   __
-- |   __ \  |.--.--.-----.|  |_.-----.-----.|  |_|  |--.
-- |   __ <  ||  |  |  -__||   _|  _  |  _  ||   _|     |
-- |______/__||_____|_____||____|_____|_____||____|__|__|
--  ______               __
-- |      |.-----.-----.|  |_.-----.----.
-- |   ---||  -__|     ||   _|  -__|   _|
-- |______||_____|__|__||____|_____|__|
-- ------------------------------------------------- --
-- Variable assignment
local width = dpi(375)
-- ------------------------------------------------- --
-- title text
local title =
  wibox.widget {
  {
    {
      spacing = dpi(0),
      layout = wibox.layout.fixed.vertical,
      format_item(
        {
          layout = wibox.layout.align.horizontal,
          spacing = dpi(16),
          require("widget.control-center.bluetoothpower-button"),
          {
            layout = wibox.container.place,
            halign = "center",
            valign = "center",
            require("widget.control-center.bluetoothtitle-text")
          },
          require("widget.control-center.bluetoothsearch-button")
        }
      )
    },
    margins = dpi(5),
    widget = wibox.container.margin
  },
  shape = beautiful.client_shape_rounded_medium,
  forced_width = width,
  ontop = true,
  border_width = dpi(0),
  border_color = colors.black,
  widget = wibox.container.background
}

-- ------------------------------------------------- --
-- panel for interacting with devices
local devices_panel =
  wibox.widget {
  {
    {
      spacing = dpi(0),
      layout = wibox.layout.flex.vertical,
      format_item(
        {
          layout = wibox.layout.fixed.horizontal,
          spacing = dpi(6),
          require("widget.control-center.bluetoothdevices-panel")
        }
      )
    },
    margins = dpi(5),
    widget = wibox.container.margin
  },
  shape = beautiful.client_shape_rounded_medium,
  bg = beautiful.bg_focus,
  forced_width = width,
  ontop = true,
  border_width = dpi(2),
  border_color = colors.black,
  widget = wibox.container.background
}

-- ------------------------------------------------- --
-- Bluetooth Center template widget

-- ------------------------------------------------- --
local bluetoothCenter =
  wibox(
  {
    visible = false,
    ontop = true,
    type = "splash",
    bg = beautiful.bg_normal,
    shape = beautiful.client_shape_rounded_lg,
    fg = colors.white
  }
)

-- ------------------------------------------------- --
function bc_toggle()
  awesome.emit_signal("bluetooth::power:refresh")
  awesome.emit_signal("bluetooth::devices:refreshPanel")
  if mouse.screen.bluetoothCenter.visible == false then
    mouse.screen.bluetoothCenter.visible = true
  elseif mouse.screen.bluetoothCenter.visible == true then
    mouse.screen.bluetoothCenter.visible = false
  end
end

-- ------------------------------------------------- --
-- putting it all together
bluetoothCenter:setup {
  wibox.widget {
    spacing = dpi(15),
    title,
    devices_panel,
    layout = wibox.layout.fixed.vertical
  },
  layout = wibox.layout.fixed.horizontal
}

return bluetoothCenter
