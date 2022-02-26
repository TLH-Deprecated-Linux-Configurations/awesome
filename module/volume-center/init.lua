--  ___ ___         __
-- |   |   |.-----.|  |.--.--.--------.-----.
-- |   |   ||  _  ||  ||  |  |        |  -__|
--  \_____/ |_____||__||_____|__|__|__|_____|
--  ______               __
-- |      |.-----.-----.|  |_.-----.----.
-- |   ---||  -__|     ||   _|  -__|   _|
-- |______||_____|__|__||____|_____|__|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
--  assign variables
local width = dpi(410)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- title text
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
          require("widget.volume-center.title-text")
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
-- ------------------------------------------------- --
-- ------------------------------------------------- --
--  volume slider functionality
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
          require("widget.volume-center.volume-slider")
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
  forced_height = 75,
  border_width = dpi(2),
  border_color = colors.colorA,
  widget = wibox.container.background
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- text for the audio device scanning feature
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
          require("widget.volume-center.devices-text")
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
--  whole panel for audio devices scan
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
          require("widget.volume-center.devices-panel")
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
  widget = wibox.container.background
}

awesome.connect_signal(
  "volume::center:toggle",
  function()
    vc_toggle()
  end
)

-- ------------------------------------------------- --
-- whole popup template
local volumeCenter = function(s)
  -- backdrop
  s.vc_unfocused =
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

  s.volumeCenter =
    wibox(
    {
      x = screen_geometry.width - width - dpi(8),
      y = screen_geometry.y,
      visible = false,
      ontop = true,
      screen = s,
      type = "popup",
      height = screen_geometry.height - dpi(48),
      width = width,
      bg = "transparent",
      fg = colors.white
    }
  )
  -- ------------------------------------------------- --
  -- resize function
  function vc_resize()
    vc_height = s.geometry.height
    if s.volumeCenter.height == s.geometry.height - dpi(48) then
      s.volumeCenter:geometry {height = s.geometry.height, y = s.geometry.y}
    elseif s.volumeCenter.height == s.geometry.height then
      s.volumeCenter:geometry {height = s.geometry.height - dpi(48), y = s.geometry.y}
    end
  end
  -- ------------------------------------------------- --
  function vc_toggle()
    if mouse.screen.volumeCenter.visible == false then
      awful.screen.connect_for_each_screen(
        function(s)
          s.vc_unfocused.visible = true
        end
      )
      mouse.screen.volumeCenter.visible = true
    elseif mouse.screen.volumeCenter.visible == true then
      awful.screen.connect_for_each_screen(
        function(s)
          s.vc_unfocused.visible = false
        end
      )
      mouse.screen.volumeCenter.visible = false
    end
  end

  awesome.connect_signal(
    "volume::center:toggle:off",
    function()
      s.vc_unfocused.visible = false
      s.volumeCenter.visible = false
    end
  )

  s.volumeCenter:setup {
    spacing = dpi(15),
    title,
    sliders,
    devices_text,
    devices_panel,
    layout = wibox.layout.fixed.vertical
  }
  -- ------------------------------------------------- --
  -- template for backdrop
  s.vc_unfocused:setup {
    nil,
    layout = wibox.layout.align.horizontal
  }
  s.vc_unfocused:buttons(
    awful.util.table.join(
      awful.button(
        {},
        1,
        nil,
        function()
          awesome.emit_signal("volume::center:toggle:off")
        end
      ),
      awful.button(
        {},
        2,
        nil,
        function()
          awesome.emit_signal("volume::center:toggle:off")
        end
      ),
      awful.button(
        {},
        3,
        nil,
        function()
          awesome.emit_signal("volume::center:toggle:off")
        end
      )
    )
  )
end
return volumeCenter
