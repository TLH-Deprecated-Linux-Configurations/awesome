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
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, beautiful.groups_radius)
  end,
  bg = beautiful.bg_normal,
  forced_width = width,
  forced_height = 70,
  ontop = true,
  border_width = dpi(2),
  border_color = colors.colorA,
  widget = wibox.container.background,
  layout
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
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, beautiful.groups_radius)
  end,
  bg = beautiful.bg_normal,
  forced_width = width,
  forced_height = 70,
  ontop = true,
  border_width = dpi(2),
  border_color = colors.colorA,
  widget = wibox.container.background,
  layout
}

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
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, beautiful.groups_radius)
  end,
  bg = beautiful.bg_normal,
  forced_width = width,
  ontop = true,
  border_width = dpi(2),
  border_color = colors.colorA,
  widget = wibox.container.background,
  layout
}

networkCenter =
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

backdrop_network_center =
  wibox {
  ontop = true,
  visible = false,
  screen = mouse.screen,
  bg = "#00000033",
  type = "splash",
  width = screen_geometry.width,
  height = screen_geometry.height
}

_G.nc_status = false

awesome.connect_signal(
  "network::center:toggle",
  function()
    if networkCenter.visible == false then
      backdrop_network_center.visible = true
      networkCenter.visible = true
    elseif networkCenter.visible == true then
      backdrop_network_center.visible = false
      networkCenter.visible = false
    end
  end
)

awesome.connect_signal(
  "network::center:toggle:off",
  function()
    backdrop_network_center.visible = false

    networkCenter.visible = false
  end
)

networkCenter:setup {
  spacing = dpi(15),
  title,
  status,
  networks_panel,
  layout = wibox.layout.fixed.vertical
}
backdrop_network_center:buttons(
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
