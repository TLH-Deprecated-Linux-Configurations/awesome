--  _______ __ __     __
-- |     __|  |__|.--|  |.-----.----.
-- |__     |  |  ||  _  ||  -__|   _|
-- |_______|__|__||_____||_____|__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local wibox = require('wibox')
local beautiful = require('beautiful')
local gears = require('gears')

local dpi = beautiful.xresources.apply_dpi
-- ########################################################################
-- ########################################################################
-- ########################################################################
--- Create a slider widget
-- local slider = module.interface.slider(0, 10, 0.05, 5, function(value)
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
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- set the initial value
    widget:set_value(default_value * step_size)

    widget:connect_signal(
        'property::value',
        function()
            local value = widget.value / step_size
            callback(value)
        end
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    --- Update the value of the slider
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
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    return widget
end
