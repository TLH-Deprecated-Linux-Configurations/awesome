local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local colors = require("themes").colors
local dpi = require("beautiful").xresources.apply_dpi
local screen_geometry = require("awful").screen.focused().geometry
local format_item = require("utils.format_item")

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
  -- layout
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
  widget = wibox.container.background,
  layout
}

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

bluetoothCenter =
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
backdrop_bluetooth_center =
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
  "bluetooth::center:toggle",
  function()
    if bluetoothCenter.visible == false then
      backdrop_bluetooth_center.visible = true
      bluetoothCenter.visible = true
    elseif bluetoothCenter.visible == true then
      backdrop_bluetooth_center.visible = false
      bluetoothCenter.visible = false
    end
  end
)

awesome.connect_signal(
  "bluetooth::center:toggle:off",
  function()
    backdrop_bluetooth_center.visible = false
    bluetoothCenter.visible = false
  end
)

local widget =
  wibox.widget {
  spacing = dpi(15),
  title,
  buttons,
  devices_text,
  devices_panel,
  layout = wibox.layout.fixed.vertical
}

bluetoothCenter:set_widget(widget)
--bluetoothCenter:geometry({height = 400})
backdrop_bluetooth_center:buttons(
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
