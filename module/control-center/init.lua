--DEPENDENCIES
--pamixer
--lm_sensors
--free
--upower

local dials =
  wibox.widget {
  {
    {
      spacing = dpi(0),
      layout = wibox.layout.flex.horizontal,
      format_item(
        {
          layout = wibox.layout.fixed.vertical,
          spacing = dpi(10),
          require("widget.control-center.ram-meter"),
          require("widget.control-center.cpu-meter")
        }
      ),
      format_item(
        {
          layout = wibox.layout.fixed.vertical,
          spacing = dpi(10),
          require("widget.control-center.hdd-meter"),
          require("widget.control-center.battery-meter")
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
  forced_height = 400,
  border_width = dpi(2),
  border_color = colors.colorA,
  widget = wibox.container.background
}

local sliders =
  wibox.widget {
  {
    {
      spacing = dpi(0),
      layout = wibox.layout.flex.horizontal,
      format_item(
        {
          layout = wibox.layout.fixed.vertical,
          spacing = dpi(10),
          require("widget.control-center.volume-slider"),
          require("widget.control-center.brightness-slider")
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
  forced_height = 190,
  border_width = dpi(2),
  border_color = colors.colorA,
  widget = wibox.container.background
}

local buttons =
  wibox.widget {
  {
    {
      spacing = dpi(0),
      layout = wibox.layout.flex.vertical,
      format_item(
        {
          layout = wibox.layout.fixed.horizontal,
          spacing = dpi(16),
          require("widget.control-center.bar-button"),
          require("widget.control-center.dropbox-toggle"),
          require("widget.control-center.do-not-disturb"),
          require("widget.control-center.screen-capture"),
          require("widget.control-center.mute-button"),
          require("widget.control-center.restart-awesome")
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
          require("widget.control-center.title-text")
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
-- ------------------------------------------------- --
-- ------------------------------------------------- --
backdrop_control_center =
  wibox {
  ontop = true,
  visible = false,
  screen = mouse.screen,
  bg = "#00000033",
  type = "splash",
  width = screen_geometry.width,
  height = screen_geometry.height
}

awesome.connect_signal(
  "cc:toggle",
  function()
    cc_toggle()
  end
)
awesome.connect_signal(
  "cc:toggle:off",
  function()
    backdrop_control_center.visible = false
    mouse.screen.controlCenter.visible = false
  end
)

awesome.connect_signal(
  "cc:resize",
  function()
    cc_resize()
  end
)

local controlCenter = function(s)
  s.controlCenter =
    wibox(
    {
      x = s.geometry.x + dpi(8),
      y = s.geometry.y,
      visible = false,
      ontop = true,
      type = "splash",
      height = s.geometry.height - dpi(48),
      width = dpi(400),
      bg = "transparent",
      fg = colors.white
    }
  )

  function cc_resize()
    cc_height = s.geometry.height
    if s.controlCenter.height == s.geometry.height - dpi(48) then
      s.controlCenter:geometry {height = s.geometry.height, y = s.geometry.y}
    elseif s.controlCenter.height == s.geometry.height then
      s.controlCenter:geometry {height = s.geometry.height - dpi(48), y = s.geometry.y}
    end
  end

  function cc_toggle()
    if mouse.screen.controlCenter.visible == false then
      backdrop_control_center.visible = true
      mouse.screen.controlCenter.visible = true
    elseif mouse.screen.controlCenter.visible == true then
      backdrop_control_center.visible = false
      mouse.screen.controlCenter.visible = false
    end
  end

  s.controlCenter:setup {
    {
      spacing = dpi(15),
      title,
      buttons,
      dials,
      sliders,
      layout = wibox.layout.fixed.vertical
    },
    layout = wibox.layout.fixed.horizontal
  }
end

backdrop_control_center:buttons(
  awful.util.table.join(
    awful.button(
      {},
      1,
      nil,
      function()
        awesome.emit_signal("cc:toggle:off")
      end
    )
  )
)

return controlCenter
