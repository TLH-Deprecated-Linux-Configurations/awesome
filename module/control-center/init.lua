--  ______               __               __
-- |      |.-----.-----.|  |_.----.-----.|  |
-- |   ---||  _  |     ||   _|   _|  _  ||  |
-- |______||_____|__|__||____|__| |_____||__|
--  ______               __
-- |      |.-----.-----.|  |_.-----.----.
-- |   ---||  -__|     ||   _|  -__|   _|
-- |______||_____|__|__||____|_____|__|
-- ------------------------------------------------- --
-- meter widgets
local dials =
  wibox.widget {
  {
    {
      spacing = dpi(5),
      layout = wibox.layout.flex.horizontal,
      format_item(
        {
          layout = wibox.layout.fixed.vertical,
          spacing = dpi(5),
          require("widget.control-center.ram-meter"),
          require("widget.control-center.cpu-meter")
        }
      ),
      format_item(
        {
          layout = wibox.layout.fixed.vertical,
          spacing = dpi(5),
          require("widget.control-center.hdd-meter"),
          require("widget.control-center.temp-meter")
        }
      )
    },
    margins = dpi(5),
    widget = wibox.container.margin
  },
  shape = beautiful.client_shape_rounded_xl,
  bg = beautiful.bg_normal,
  forced_width = dpi(475),
  forced_height = dpi(450),
  border_width = dpi(2),
  border_color = colors.colorA,
  widget = wibox.container.background
}
-- ------------------------------------------------- --
-- slider widgets
local sliders =
  wibox.widget {
  {
    {
      spacing = dpi(5),
      layout = wibox.layout.flex.horizontal,
      format_item(
        {
          layout = wibox.layout.flex.vertical,
          spacing = dpi(5),
          require("widget.control-center.volume-slider"),
          require("widget.control-center.brightness-slider")
        }
      )
    },
    margins = dpi(2),
    widget = wibox.container.margin
  },
  shape = beautiful.client_shape_rounded_xl,
  bg = beautiful.bg_normal,
  forced_width = dpi(475),
  forced_height = dpi(230),
  border_width = dpi(2),
  border_color = colors.colorA,
  widget = wibox.container.background
}
-- ------------------------------------------------- --
-- panel buttons section
local buttons =
  wibox.widget {
  {
    {
      spacing = dpi(0),
      layout = wibox.layout.flex.vertical,
      {
        format_item(
          {
            layout = wibox.layout.flex.horizontal,
            spacing = dpi(16),
            require("widget.control-center.bar-button"),
            require("widget.control-center.dropbox-toggle"),
            require("widget.control-center.do-not-disturb"),
            require("widget.control-center.screen-capture"),
            require("widget.control-center.mute-button"),
            require("widget.control-center.restart-awesome")
          }
        ),
        bg = colors.colorA,
        widget = wibox.container.background
      }
    },
    margins = dpi(8),
    widget = wibox.container.margin
  },
  shape = beautiful.client_shape_rounded_xl,
  bg = beautiful.bg_normal,
  forced_width = dpi(475),
  forced_height = dpi(120),
  border_width = dpi(2),
  border_color = colors.colorA,
  widget = wibox.container.background
}
-- ------------------------------------------------- --
-- title of the center
local title =
  wibox.widget {
  {
    {
      spacing = dpi(0),
      layout = wibox.layout.fixed.vertical,
      format_item(
        {
          layout = wibox.layout.align.horizontal,
          spacing = dpi(30),
          require("widget.user-icon"),
          {
            layout = wibox.container.place,
            halign = "center",
            valign = "center",
            require("widget.control-center.title-text")
          },
          require("widget.user-icon")
        }
      )
    },
    margins = dpi(5),
    widget = wibox.container.margin
  },
  shape = beautiful.client_shape_rounded_xl,
  bg = beautiful.bg_normal,
  forced_width = dpi(475),
  forced_height = dpi(70),
  border_width = dpi(2),
  border_color = colors.colorA,
  widget = wibox.container.background
}
-- ------------------------------------------------- --
-- connect signal for toggle
awesome.connect_signal(
  "cc:toggle",
  function()
    cc_toggle()
  end
)
-- ------------------------------------------------- --
-- connect signal for resize
awesome.connect_signal(
  "cc:resize",
  function()
    cc_resize()
  end
)
-- ------------------------------------------------- --
-- control center function
local controlCenter = function(s)
  -- backdrop
  s.cc_unfocused =
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
      bg = colors.alpha(colors.blacker, "88"),
      fg = colors.white
    }
  )
  -- ------------------------------------------------- --
  -- template
  s.controlCenter =
    wibox(
    {
      position = "center",
      y = s.geometry.y,
      x = s.geometry.x + dpi(750),
      screen = s,
      visible = false,
      ontop = true,
      type = "popup",
      height = s.geometry.height - dpi(48),
      width = dpi(450),
      bg = "transparent",
      fg = colors.white
    }
  )
  -- ------------------------------------------------- --
  -- resize function
  function cc_resize()
    cc_height = s.geometry.height
    if s.controlCenter.height == s.geometry.height - dpi(48) then
      s.controlCenter:geometry {height = s.geometry.height, y = s.geometry.y}
    elseif s.controlCenter.height == s.geometry.height then
      s.controlCenter:geometry {height = s.geometry.height - dpi(48), y = s.geometry.y}
    end
  end
  -- ------------------------------------------------- --
  --
  function cc_toggle()
    if mouse.screen.controlCenter.visible == false then
      awful.screen.connect_for_each_screen(
        function(s)
          s.cc_unfocused.visible = true
        end
      )
      mouse.screen.controlCenter.visible = true
    elseif mouse.screen.controlCenter.visible == true then
      awful.screen.connect_for_each_screen(
        function(s)
          s.cc_unfocused.visible = false
        end
      )
      mouse.screen.controlCenter.visible = false
    end
  end
  -- ------------------------------------------------- --
  -- template for control center
  s.controlCenter:setup {
    {
      spacing = dpi(15),
      buttons,
      dials,
      sliders,
      layout = wibox.layout.fixed.vertical
    },
    layout = wibox.layout.fixed.horizontal
  }
  -- ------------------------------------------------- --
  -- template for backdrop
  s.cc_unfocused:setup {
    nil,
    layout = wibox.layout.align.horizontal
  }
  -- ------------------------------------------------- --
  -- if mouse clicked on backdrop, turns center OFF
  s.cc_unfocused:buttons(
    awful.util.table.join(
      awful.button(
        {},
        1,
        nil,
        function()
          awesome.emit_signal("cc:toggle:off")
        end
      ),
      awful.button(
        {},
        2,
        nil,
        function()
          awesome.emit_signal("cc:toggle:off")
        end
      ),
      awful.button(
        {},
        3,
        nil,
        function()
          awesome.emit_signal("cc:toggle:off")
        end
      )
    )
  )

  awesome.connect_signal(
    "cc:toggle:off",
    function()
      s.cc_unfocused.visible = false
      mouse.screen.controlCenter.visible = false
      awesome.emit_signal("notifications::center:toggle:off")
      awesome.emit_signal("bluetooth::center:toggle:off")
      awesome.emit_signal("date:toggle:off")
    end
  )
end

return controlCenter
