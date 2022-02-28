--  _______         __   __   ___ __              __   __
-- |    |  |.-----.|  |_|__|.'  _|__|.----.---.-.|  |_|__|.-----.-----.
-- |       ||  _  ||   _|  ||   _|  ||  __|  _  ||   _|  ||  _  |     |
-- |__|____||_____||____|__||__| |__||____|___._||____|__||_____|__|__|
--  ______               __
-- |      |.-----.-----.|  |_.-----.----.
-- |   ---||  -__|     ||   _|  -__|   _|
-- |______||_____|__|__||____|_____|__|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --s
--  variable definition
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
          require("widget.notification-center.title-text"),
          require("widget.notification-center.clear-all")
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
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- panel with controls
local notification_panel =
  wibox.widget {
  {
    {
      spacing = dpi(12),
      layout = wibox.layout.flex.vertical,
      format_item(
        {
          layout = wibox.layout.fixed.horizontal,
          spacing = dpi(16),
          require("widget.notification-center.notifications-panel")
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
-- ------------------------------------------------- -- -- ------------------------------------------------- --
-- signal to resize the popup, insuring it is the right size
awesome.connect_signal(
  "notification::center:resize",
  function()
    noc_resize()
  end
)

-- ------------------------------------------------- --
--  toggle signal
_G.noc_status = true

awesome.connect_signal(
  "notifications::center:toggle",
  function()
    noc_toggle()
  end
)
-- ------------------------------------------------- --
--  template for the whole popup (transparent popup)
notificationCenter = function(s)
  -- backdrop
  s.noc_unfocused =
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
  s.notificationCenter =
    wibox(
    {
      x = s.geometry.x + dpi(770),
      y = s.geometry.y,
      visible = false,
      ontop = true,
      screen = s,
      type = "popup",
      height = s.geometry.height - dpi(48),
      width = width,
      bg = "transparent",
      fg = colors.white
    }
  )
  -- ------------------------------------------------- --
  -- resize function
  function noc_resize()
    noc_height = s.geometry.height
    if s.notificationCenter.height == s.geometry.height - dpi(48) then
      s.notificationCenter:geometry {height = s.geometry.height, y = s.geometry.y}
    elseif s.notificationCenter.height == s.geometry.height then
      s.notificationCenter:geometry {height = s.geometry.height - dpi(48), y = s.geometry.y}
    end
  end
  -- ------------------------------------------------- --
  --
  function noc_toggle()
    if mouse.screen.notificationCenter.visible == false then
      awful.screen.connect_for_each_screen(
        function(s)
          s.noc_unfocused.visible = true
        end
      )
      mouse.screen.notificationCenter.visible = true
    elseif mouse.screen.notificationCenter.visible == true then
      awful.screen.connect_for_each_screen(
        function(s)
          s.noc_unfocused.visible = false
        end
      )
      mouse.screen.notificationCenter.visible = false
    end
  end
  -- ------------------------------------------------- --
  -- ------------------------------------------------- --

  -- ------------------------------------------------- --
  -- ------------------------------------------------- --
  -- ------------------------------------------------- --
  --  signal just to turn off the popup for backdrop
  awesome.connect_signal(
    "notifications::center:toggle:off",
    function()
      noc_status = false
      s.noc_unfocused.visible = false
      mouse.screen.notificationCenter.visible = false
    end
  )
  -- ------------------------------------------------- --
  -- ------------------------------------------------- --
  -- ------------------------------------------------- --
  --  setup popup spacing/content
  s.notificationCenter:setup {
    spacing = dpi(15),
    title,
    notification_panel,
    layout = wibox.layout.fixed.vertical
  }
  -- ------------------------------------------------- --
  -- template for backdrop
  s.noc_unfocused:setup {
    nil,
    layout = wibox.layout.align.horizontal
  }
  -- ------------------------------------------------- --
  -- ------------------------------------------------- --
  -- ------------------------------------------------- --
  --  assign button to click to turn off popup & backdrop
  s.noc_unfocused:buttons(
    awful.util.table.join(
      awful.button(
        {},
        1,
        nil,
        function()
          awesome.emit_signal("notifications::center:toggle:off")
        end
      ),
      awful.button(
        {},
        2,
        nil,
        function()
          awesome.emit_signal("notifications::center:toggle:off")
        end
      ),
      awful.button(
        {},
        3,
        nil,
        function()
          awesome.emit_signal("notifications::center:toggle:off")
        end
      )
    )
  )
end

return notificationCenter
