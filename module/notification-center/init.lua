--  _______         __   __   ___ __              __   __
-- |    |  |.-----.|  |_|__|.'  _|__|.----.---.-.|  |_|__|.-----.-----.
-- |       ||  _  ||   _|  ||   _|  ||  __|  _  ||   _|  ||  _  |     |
-- |__|____||_____||____|__||__| |__||____|___._||____|__||_____|__|__|
--  ______               __
-- |      |.-----.-----.|  |_.-----.----.
-- |   ---||  -__|     ||   _|  -__|   _|
-- |______||_____|__|__||____|_____|__|
-- ------------------------------------------------- --s
--  variable definition
local width = dpi(375)
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
          layout = wibox.layout.align.horizontal,
          spacing = dpi(16),
          require("utils.user-icon"),
          {
            layout = wibox.container.place,
            halign = "center",
            valign = "center",
            require("widget.notification-center.title-text")
          },
          require("widget.notification-center.clear-all")
        }
      )
    },
    margins = dpi(5),
    widget = wibox.container.margin
  },
  shape = beautiful.client_shape_rounded_xl,
  forced_width = width,
  forced_height = dpi(70),
  ontop = true,
  widget = wibox.container.background
}
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
  forced_width = width,
  ontop = true,
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
      x = s.geometry.x + dpi(36),
      y = s.geometry.y + dpi(36),
      visible = false,
      ontop = true,
      screen = s,
      type = "splash",
      height = dpi(300),
      width = width,
      bg = beautiful.bg_normal,
      shape = beautiful.client_shape_rounded_xl,
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
      mouse.screen.notificationCenter.visible = true
    elseif mouse.screen.notificationCenter.visible == true then
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
