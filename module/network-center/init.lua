--  _______         __                        __
-- |    |  |.-----.|  |_.--.--.--.-----.----.|  |--.
-- |       ||  -__||   _|  |  |  |  _  |   _||    <
-- |__|____||_____||____|________|_____|__|  |__|__|
--  ______               __
-- |      |.-----.-----.|  |_.-----.----.
-- |   ---||  -__|     ||   _|  -__|   _|
-- |______||_____|__|__||____|_____|__|
-- ------------------------------------------------- --
local width = dpi(410)

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
          require("widget.network-center.title-text")
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

local status =
  wibox.widget {
  {
    {
      spacing = dpi(0),
      layout = wibox.layout.flex.vertical,
      format_item(
        {
          layout = wibox.layout.fixed.horizontal,
          spacing = dpi(16),
          require("widget.network-center.status-icon"),
          require("widget.network-center.status")
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
local networks_panel =
  wibox.widget {
  {
    {
      spacing = dpi(0),
      layout = wibox.layout.flex.vertical,
      format_item(
        {
          layout = wibox.layout.fixed.horizontal,
          spacing = dpi(16),
          require("widget.network-center.networks-panel")
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
-- connect signal for resize
awesome.connect_signal(
  "nc:resize",
  function()
    nc_resize()
  end
)
-- ------------------------------------------------- --
awesome.connect_signal(
  "network::center:toggle",
  function()
    nc_toggle()
  end
)

local networkCenter = function(s)
  -- backdrop
  s.nc_unfocused =
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
  s.networkCenter =
    wibox(
    {
      x = s.geometry.width + dpi(8),
      y = s.geometry.y,
      visible = false,
      ontop = true,
      screen = s,
      type = "splash",
      height = s.geometry.height - dpi(48),
      width = width,
      bg = "transparent",
      fg = colors.white
    }
  )
  -- ------------------------------------------------- --
  -- resize function
  function nc_resize()
    nc_height = s.geometry.height
    if s.networkCenter.height == s.geometry.height - dpi(48) then
      s.networkCenter:geometry {height = s.geometry.height, y = s.geometry.y}
    elseif s.networkCenter.height == s.geometry.height then
      s.networkCenter:geometry {height = s.geometry.height - dpi(48), y = s.geometry.y}
    end
  end
  -- ------------------------------------------------- --
  function nc_toggle()
    if mouse.screen.networkCenter.visible == false then
      awful.screen.connect_for_each_screen(
        function(s)
          s.nc_unfocused.visible = true
        end
      )
      mouse.screen.networkCenter.visible = true
    elseif mouse.screen.networkCenter.visible == true then
      awful.screen.connect_for_each_screen(
        function(s)
          s.nc_unfocused.visible = false
        end
      )
      mouse.screen.networkCenter.visible = false
    end
  end

  -- ------------------------------------------------- --
  s.networkCenter:setup {
    {
      spacing = dpi(15),
      title,
      status,
      networks_panel,
      layout = wibox.layout.fixed.vertical
    },
    layout = wibox.layout.fixed.horizontal
  }
  -- ------------------------------------------------- --
  s.nc_unfocused:setup {
    nil,
    layout = wibox.layout.align.horizontal
  }
  -- ------------------------------------------------- --
  s.nc_unfocused:buttons(
    awful.util.table.join(
      awful.button(
        {},
        1,
        nil,
        function()
          awesome.emit_signal("network::center:toggle:off")
        end
      ),
      awful.button(
        {},
        2,
        nil,
        function()
          awesome.emit_signal("network::center:toggle:off")
        end
      ),
      awful.button(
        {},
        3,
        nil,
        function()
          awesome.emit_signal("network::center:toggle:off")
        end
      )
    )
  )

  -- ------------------------------------------------- --
  awesome.connect_signal(
    "network::center:toggle:off",
    function()
      s.nc_unfocused.visible = false

      mouse.screen.networkCenter.visible = false
    end
  )
end
return networkCenter
