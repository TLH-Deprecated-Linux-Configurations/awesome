
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local gap = 1

local mat_list_item = require("widget.material.list-item")

local barColor = beautiful.bg_modal
local wifibutton = require("widget.action-center.wifi-button")
local bluebutton = require("widget.action-center.bluetooth-button")
local comptonbutton = require("widget.action-center.compositor-button")
local comptonBackendbutton = require("widget.action-center.compositor-backend-button")
-- ########################################################################
-- ########################################################################
-- ########################################################################
local widget =
  wibox.widget {
  spacing = gap,
  -- Wireless Connection
  wibox.widget {
    wibox.widget {
      wifibutton,
      bg = barColor,
      shape = function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, true, true, false, false, 12)
      end,
      widget = wibox.container.background
    },
    widget = mat_list_item
  },
  -- ########################################################################
-- ########################################################################
-- ########################################################################
  -- Bluetooth Connection
  wibox.widget {
    wibox.widget {
      bluebutton,
      bg = barColor,
      shape = function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, false, false, false, false, 12)
      end,
      widget = wibox.container.background
    },
    widget = mat_list_item
  },
-- ########################################################################
-- ########################################################################
-- ########################################################################
  -- Compositor Toggle
  wibox.widget {
    wibox.widget {
      comptonbutton,
      bg = barColor,
      shape = function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, false, false, false, false, 12)
      end,
      widget = wibox.container.background
    },
    widget = mat_list_item
  },
  -- ########################################################################
-- ########################################################################
-- ########################################################################
  -- Compositor Backend Toggle
  layout = wibox.layout.fixed.vertical,
  wibox.widget {
    wibox.widget {
      comptonBackendbutton,
      bg = barColor,
      shape = function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, false, false, true, true, 12)
      end,
      widget = wibox.container.background
    },
    widget = mat_list_item
  }
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
return wibox.container.margin(widget, 0, 0, dpi(20), dpi(20))
