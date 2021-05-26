local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local icons = require("theme.icons")
local dpi = beautiful.xresources.apply_dpi
local clickable_container = require("widget.clickable-container")
local task_list = require("widget.task-list")
local tag_list = require("widget.tag-list")
local hardware = require("lib-tde.hardware-check")
local clock = require("widget.clock")

local bottom_panel = function(s)
  local function show_widget_or_default(widget, show, require_is_function)
    if show and require_is_function then
      return require(widget)()
    elseif show then
      return require(widget)
    end
    return wibox.widget.base.empty_widget()
  end

  local offsetx = 0
  local panel =
    awful.wibar(
    {
      ontop = true,
      screen = s,
      position = "bottom",
      height = dpi(35), -- 48
      width = s.geometry.width - offsetx,
      x = s.geometry.x + offsetx,
      y = s.geometry.y,
      stretch = false,
      bg = beautiful.background.hue_800,
      fg = beautiful.fg_normal,
      struts = {
        bottom = dpi(36) -- 48
      }
    }
  )
  panel:struts {
    bottom = dpi(38)
  }

  panel:connect_signal(
    "mouse::enter",
    function()
      local w = mouse.current_wibox
      if w then
        w.cursor = "left_ptr"
      end
    end
  )

  local build_widget = function(widget)
    return wibox.widget {
      {
        widget,
        border_width = dpi(1),
        border_color = beautiful.xcolor0,
        bg = beautiful.xcolor0 .. "99",
        shape = function(cr, w, h)
          gears.shape.rounded_rect(cr, w, h, dpi(6))
        end,
        widget = wibox.container.background
      },
      top = dpi(0),
      bottom = dpi(0),
      widget = wibox.container.margin
    }
  end

  s.systray =
    wibox.widget {
    {
      base_size = dpi(20),
      horizontal = true,
      screen = "primary",
      widget = wibox.widget.systray
    },
    visible = false,
    bottom = dpi(10),
    widget = wibox.container.margin
  }

  s.control_center_toggle = build_widget(require("widget.control-center"))

  s.screen_rec = build_widget(require("widget.screen-recorder")())
  s.bluetooth = build_widget(show_widget_or_default("widget.bluetooth", hardware.hasBluetooth()))
  s.network = build_widget(show_widget_or_default("widget.wifi", hardware.hasWifi()))
  local layout_box = build_widget(require("widget.layoutbox")(s))
  s.battery = build_widget(show_widget_or_default("widget.battery", hardware.hasBattery(), true))
  s.notification_center = build_widget(require("widget.notification-center"))
s.about = build_widget(require("widget.about"))
s.mytextclock = build_widget(require("widget.clock"))
  panel:setup {
    {
      layout = wibox.layout.align.horizontal,
      expand = "none",
      position = "bottom",
      {
        layout = wibox.layout.align.horizontal,
        spacing = dpi(2),
        tag_list(s),
        task_list(s)
      },
      nil,
      {
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(5),
        {
          s.systray,
          margins = dpi(5),
          widget = wibox.container.margin
        },
        s.about,
        s.screen_rec,
        s.network,
        s.notification_center,
        s.control_center_toggle,
        s.bluetooth,
        s.battery,
       
        layout_box,
        s.mytextclock,
        --clock,
      }
    },
    left = dpi(5),
    right = dpi(5),
    widget = wibox.container.margin
  }

  return panel
end

return bottom_panel
