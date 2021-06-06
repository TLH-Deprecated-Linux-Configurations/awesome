--  _______        __   __
-- |   _   |.----.|  |_|__|.-----.-----.
-- |       ||  __||   _|  ||  _  |     |
-- |___|___||____||____|__||_____|__|__|

--  ______ __               __                __   __
-- |   __ \  |.--.--.-----.|  |_.-----.-----.|  |_|  |--.
-- |   __ <  ||  |  |  -__||   _|  _  |  _  ||   _|     |
-- |______/__||_____|_____||____|_____|_____||____|__|__|
-- ########################################################################
-- Initialization #########################################################
-- ########################################################################
local wibox = require("wibox")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi
local mat_list_item = require("widget.material.list-item")
local signals = require("lib.signals")
local checkbox = require("lib.checkbox")

-- ########################################################################
-- Functionality ##########################################################
-- ########################################################################
local action_status = false

-- Power on Commands
local power_on_cmd =
  [[
rfkill unblock bluetooth
echo 'power on' | bluetoothctl
notify-send 'Initializing bluetooth Service...'
]]

-- Power off Commands
local power_off_cmd =
  [[
echo 'power off' | bluetoothctl
rfkill block bluetooth
notify-send 'Bluetooth device disabled'
]]

local update_action = function()
  if action_status then
    awful.spawn.easy_async_with_shell(
      power_on_cmd,
      function(_)
      end,
      false
    )
  else
    awful.spawn.easy_async_with_shell(
      power_off_cmd,
      function(_)
      end,
      false
    )
  end
end

-- Button
local widget_button =
  checkbox(
  action_status,
  function(checked)
    action_status = checked
    update_action()
  end
)
-- ########################################################################
-- Tooltip ################################################################
-- ########################################################################

awful.tooltip {
  objects = {widget_button},
  mode = "outside",
  align = "right",
  timer_function = function()
    if action_status == true then
      return i18n.translate("Bluetooth Enabled")
    else
      return i18n.translate("Bluetooth Disabled")
    end
  end,
  preferred_positions = {"right", "left", "top", "bottom"}
}


-- ########################################################################
--- Status Checker ########################################################
-- ########################################################################
signals.connect_bluetooth_status(
  function(status)
    action_status = status
    widget_button.update(status)
  end
)
-- ########################################################################
-- Action Name ############################################################
-- ########################################################################

local action_name =
  wibox.widget {
  text = i18n.translate("Bluetooth Connection"),
  font = "SFNS Display 11",
  align = "left",
  widget = wibox.widget.textbox
}

local content =
  wibox.widget {
  action_name,
  wibox.container.margin(widget_button, 0, 0, dpi(5), dpi(5)),
  bg = "#ffffff20",
  shape = gears.shape.rect,
  widget = wibox.container.background(),
  layout = wibox.layout.ratio.horizontal
}
content:set_ratio(1, .85)

-- ########################################################################
-- Wrapping ###############################################################
-- ########################################################################
local action_widget =
  wibox.widget {
  wibox.widget {
    content,
    widget = mat_list_item
  },
  layout = wibox.layout.fixed.vertical
}


-- ########################################################################
-- Return widget ##########################################################
-- ########################################################################
return action_widget
