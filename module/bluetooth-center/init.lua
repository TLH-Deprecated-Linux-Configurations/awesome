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
          require("widget.bluetooth-center.power-button"),
          {
            layout = wibox.container.place,
            halign = "center",
            valign = "center",
            require("widget.bluetooth-center.title-text")
          },
          require("widget.bluetooth-center.search-button")
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
          require("widget.bluetooth-center.devices-panel")
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
-- toggle signal
awesome.connect_signal(
  "bluetooth::center:toggle",
  function()
    bc_toggle()
    awesome.emit_signal("bluetooth::power:refresh")
    awesome.emit_signal("bluetooth::devices:refreshPanel")
  end
)
-- ------------------------------------------------- --
-- Bluetooth Center template widget
bluetoothCenter = function(s)
  -- backdrop
  s.bc_unfocused =
    wibox(
    {
      x = s.geometry.x,
      y = s.geometry.y,
      visible = false,
      screen = s,
      ontop = true,
      type = "splash",
      height = s.geometry.height,
      width = s.geometry.width,
      bg = colors.alpha(colors.blacker, "aa"),
      fg = colors.white
    }
  )
  -- ------------------------------------------------- --
  s.bluetoothCenter =
    wibox(
    {
      y = s.geometry.y + dpi(500),
      x = s.geometry.x + dpi(36),
      visible = false,
      ontop = true,
      screen = mouse.screen,
      type = "splash",
      height = dpi(400),
      width = width,
      bg = beautiful.bg_normal,
      shape = beautiful.client_shape_rounded_lg,
      fg = colors.white
    }
  )

  -- ------------------------------------------------- --
  function bc_toggle()
    if mouse.screen.bluetoothCenter.visible == false then
      mouse.screen.bluetoothCenter.visible = true
    elseif mouse.screen.bluetoothCenter.visible == true then
      mouse.screen.bluetoothCenter.visible = false
    end
  end

  -- ------------------------------------------------- --
  -- off signal
  awesome.connect_signal(
    "bluetooth::center:toggle:off",
    function()
      s.bc_unfocused.visible = false
      mouse.screen.bluetoothCenter.visible = false
    end
  )
  -- ------------------------------------------------- --
  -- putting it all together
  s.bluetoothCenter:setup {
    wibox.widget {
      spacing = dpi(15),
      title,
      devices_panel,
      layout = wibox.layout.fixed.vertical
    },
    layout = wibox.layout.fixed.horizontal
  }
  -- ------------------------------------------------- --
  s.bc_unfocused:setup {
    nil,
    layout = wibox.layout.align.horizontal
  }

  -- ------------------------------------------------- --
  -- provide button binding to kill bluetooth center if backdrop is pressed
  s.bc_unfocused:buttons(
    awful.util.table.join(
      awful.button(
        {},
        1,
        nil,
        function()
          awesome.emit_signal("bluetooth::center:toggle:off")
        end
      )
    )
  )
end
return bluetoothCenter
