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
  widget = wibox.container.background,
  layout
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
--  template for the whole popup (transparent popup)
notificationCenter =
  wibox(
  {
    x = screen_geometry.width - width - dpi(8),
    y = screen_geometry.y,
    visible = false,
    ontop = true,
    screen = mouse.screen,
    type = "popup",
    height = screen_geometry.height - dpi(48),
    width = width,
    bg = "transparent",
    fg = beautiful.fg_normal
  }
)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- backdrop that makes focusing on the popup easier/possible
backdrop_notification_center =
  wibox {
  ontop = true,
  visible = false,
  screen = mouse.screen,
  bg = "#00000033",
  type = "splash",
  width = screen_geometry.width,
  height = screen_geometry.height
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- signal to resize the popup, insuring it is the right size
awesome.connect_signal(
  "nc:resize",
  function()
    nc_height = screen_geometry.height
    if notificationCenter.height == screen_geometry.height - dpi(48) then
      notificationCenter:geometry {height = screen_geometry.height, y = screen_geometry.y + dpi(8)}
      backdrop_notification_center:geometry {height = screen_geometry.height, y = screen_geometry.y}
    elseif notificationCenter.height == screen_geometry.height then
      notificationCenter:geometry {height = screen_geometry.height - dpi(48), y = screen_geometry.y}
      backdrop_notification_center:geometry {height = screen_geometry.height, y = screen_geometry.y}
    end
  end
)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
--  toggle signal
_G.nc_status = false

awesome.connect_signal(
  "notifications::center:toggle",
  function()
    if notificationCenter.visible == false then
      nc_status = true
      backdrop_notification_center.visible = true
      notificationCenter.visible = true
    elseif notificationCenter.visible == true then
      nc_status = false
      backdrop_notification_center.visible = false
      notificationCenter.visible = false
    end
  end
)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
--  signal just to turn off the popup for backdrop
awesome.connect_signal(
  "notifications::center:toggle:off",
  function()
    nc_status = false
    backdrop_notification_center.visible = false
    notificationCenter.visible = false
  end
)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
--  setup popup spacing/content
notificationCenter:setup {
  spacing = dpi(15),
  title,
  notification_panel,
  layout = wibox.layout.fixed.vertical
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
--  assign button to click to turn off popup & backdrop
backdrop_notification_center:buttons(
  awful.util.table.join(
    awful.button(
      {},
      1,
      nil,
      function()
        awesome.emit_signal("notifications::center:toggle:off")
      end
    )
  )
)
