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
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- whole popup template
volumeCenter =
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
    fg = colors.white
  }
)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
backdrop_volume_center =
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
  "volume::center:toggle",
  function()
    if volumeCenter.visible == false then
      backdrop_volume_center.visible = true
      volumeCenter.visible = true
    elseif volumeCenter.visible == true then
      backdrop_volume_center.visible = false
      volumeCenter.visible = false
    end
  end
)

awesome.connect_signal(
  "volume::center:toggle:off",
  function()
    backdrop_volume_center.visible = false
    volumeCenter.visible = false
  end
)

volumeCenter:setup {
  spacing = dpi(15),
  title,
  sliders,
  devices_text,
  devices_panel,
  layout = wibox.layout.fixed.vertical
}
backdrop_volume_center:buttons(
  awful.util.table.join(
    awful.button(
      {},
      1,
      nil,
      function()
        awesome.emit_signal("volume::center:toggle:off")
      end
    )
  )
)
