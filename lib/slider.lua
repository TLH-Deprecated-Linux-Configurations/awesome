-- Create a new slider widget
--
-- Useful when you to get the user to input a range of numbers
--
--    -- A slider between 0 and 10 with increments of 0.05, the default value is 5 and a callback function each time the value is updated
--    local slider = lib.slider(0, 10, 0.05, 5, function(value)
--         print("Updated slider value to: " .. value)
--    end)
--
--   slider:set_value(8)
--
-- ![slider](../images/slider.png)
--
-- @author Tom Meyers
-- @copyright 2020 Tom Meyers
-- @tdewidget lib.slider
-- @supermodule wibox.widget.slider
---------------------------------------------------------------------------

local wibox = require('wibox')
local beautiful = require('beautiful')
local gears = require('gears')

local dpi = beautiful.xresources.apply_dpi

--- Create a slider widget
-- @tparam number min The lowest possible value for the slider
-- @tparam number max The highest possible value for the slider
-- @tparam number increment How much should one step increase the slider
-- @tparam number default_value To what value do we need to set the slider to initially
-- @tparam function callback A callback that gets triggered every time the value change_focus
-- @tparam[opt] function tooltip_callback A function that gets called each time a you want to show some information
-- @treturn widget The slider widget
-- @staticfct slider
-- @usage -- This will create the content in hallo.txt to var=value
-- -- A slider between 0 and 10 with increments of 0.05, the default value is 5 and a callback function each time the value is updated
-- local slider = lib.slider(0, 10, 0.05, 5, function(value)
--      print("Updated slider value to: " .. value)
-- end)
return function(min, max, increment, default_value, callback, tooltip_callback)
    local step_size = 1 / increment

    local widget = wibox.widget.slider()
    widget.bar_shape = function(c, w, h)
        gears.shape.rounded_rect(c, w, h, dpi(30) / 2)
    end
    widget.bar_height = dpi(30)
    widget.bar_color = beautiful.xcolor0
    widget.bar_active_color = beautiful.xcolor7
    widget.handle_shape = gears.shape.circle
    widget.handle_width = dpi(35)
    widget.handle_color = beautiful.xcolor15
    widget.handle_border_width = 1
    widget.handle_border_color = '#00000012'
    widget.minimum = min * step_size
    widget.maximum = max * step_size

    -- set the initial value
    widget:set_value(default_value * step_size)

    widget:connect_signal(
        'property::value',
        function()
            local value = widget.value / step_size
            callback(value)
        end
    )

    --- Update the value of the slider
    -- @tparam number value The new numerical value of the slider
    -- @staticfct slider.update
    -- @usage -- This will set the value of the slider to 8.5
    -- slider.update(8.5)
    widget.update = function(value)
        widget:set_value(value * step_size)
    end

    if tooltip_callback ~= nil and type(tooltip_callback) == 'function' then
        awful.tooltip {
            objects = {widget},
            timer_function = tooltip_callback
        }
    end

    return widget
end
