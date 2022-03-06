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
local width = dpi(410)
-- ------------------------------------------------- --
-- title section
local title =
  wibox.widget {
  {
    {
      spacing = dpi(0),
      layout = wibox.layout.flex.vertical,
      format_item(
        {
          layout = wibox.layout.fixed.horizontal,
          spacing = dpi(16),
          require("widget.user-icon"),
          require("widget.bluetooth-center.title-text")
        }
      )
    },
    margins = dpi(5),
    widget = wibox.container.margin
  },
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, beautiful.groups_radius)
  end,
  bg = beautiful.bg_normal,
  forced_width = width,
  forced_height = 70,
  ontop = true,
  border_width = dpi(2),
  border_color = colors.colorA,
  widget = wibox.container.background
}
-- ------------------------------------------------- --
-- button section
local buttons =
  wibox.widget {
  {
    {
      spacing = dpi(0),
      layout = wibox.layout.flex.vertical,
      format_item(
        {
          layout = wibox.layout.flex.horizontal,
          max_widget_size = dpi(55),
          spacing = dpi(115),
          require("widget.bluetooth-center.power-button"),
          require("widget.bluetooth-center.devices-button"),
          require("widget.bluetooth-center.search-button")
        }
      )
    },
    margins = dpi(5),
    widget = wibox.container.margin
  },
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, beautiful.groups_radius)
  end,
  bg = beautiful.bg_normal,
  forced_width = 400,
  forced_height = 70,
  border_width = dpi(2),
  border_color = colors.colorA,
  widget = wibox.container.background
}
-- ------------------------------------------------- --
-- devices section
local devices_text =
  wibox.widget {
  {
    {
      spacing = dpi(0),
      layout = wibox.layout.flex.vertical,
      format_item(
        {
          layout = wibox.layout.fixed.horizontal,
          spacing = dpi(16),
          require("widget.bluetooth-center.devices-text")
        }
      )
    },
    margins = dpi(5),
    widget = wibox.container.margin
  },
  shape = beautiful.client_shape_rounded_xl,
  bg = beautiful.bg_normal,
  forced_width = width,
  forced_height = 70,
  ontop = true,
  border_width = dpi(2),
  border_color = colors.colorA,
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
          spacing = dpi(16),
          require("widget.bluetooth-center.devices-panel")
        }
      )
    },
    margins = dpi(5),
    widget = wibox.container.margin
  },
  shape = beautiful.client_shape_rounded_xl,
  bg = beautiful.bg_normal,
  forced_width = width,
  ontop = true,
  border_width = dpi(2),
  border_color = colors.colorA,
  widget = wibox.container.background
}
-- ------------------------------------------------- --
-- toggle signal
awesome.connect_signal(
  "bluetooth::center:toggle",
  function()
    bc_toggle()
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
      type = "popup",
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
      x = screen_geometry.width - width - dpi(8),
      y = screen_geometry.y,
      visible = false,
      ontop = true,
      screen = mouse.screen,
      type = "splash",
      height = screen_geometry.height - dpi(48),
      width = width,
      bg = "transparent",
      fg = colors.white
    }
  )
  -- ------------------------------------------------- --
  -- resize function
  function bc_resize()
    bc_height = s.geometry.height
    if s.bluetoothCenter.height == s.geometry.height - dpi(48) then
      s.bluetoothCenter:geometry {height = s.geometry.height, y = s.geometry.y}
    elseif s.bluetoothCenter.height == s.geometry.height then
      s.bluetoothCenter:geometry {height = s.geometry.height - dpi(48), y = s.geometry.y}
    end
  end
  -- ------------------------------------------------- --
  function bc_toggle()
    if mouse.screen.bluetoothCenter.visible == false then
      awful.screen.connect_for_each_screen(
        function(s)
          s.bc_unfocused.visible = true
        end
      )
      mouse.screen.bluetoothCenter.visible = true
    elseif mouse.screen.bluetoothCenter.visible == true then
      awful.screen.connect_for_each_screen(
        function(s)
          s.bc_unfocused.visible = false
        end
      )
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
      buttons,
      devices_text,
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
