-- Create a new separate widget
--
-- Useful when you want to separate widgets from eachother
--
--    -- separate that is 20 pixels high
--    local separate = lib.separate(dpi(20))
--
--
-- @author Tom Meyers
-- @copyright 2020 Tom Meyers
-- @tdewidget lib.separator
-- @supermodule wibox.widget.separator
---------------------------------------------------------------------------

local wibox = require("wibox")

--- Create a new separate widget
-- @tparam[opt] number size The height of the separate
-- @tparam[opt] string orientation In which way it the separate oriented (horizontal or vertical)
-- @tparam[opt] number opacity How visible is the separate (Between 0 and 1)
-- @treturn widget The separate widget
-- @staticfct separate
-- @usage -- This will create a separate that is 20 pixels high
-- -- separate that is 20 pixels high
-- local separate = lib.separate(dpi(20))
return function(height, orientation, opacity)
    height = height or 20
    orientation = orientation or "horizontal"
    opacity = opacity or 1
    return wibox.widget {
        orientation = orientation,
        opacity = opacity,
        widget = wibox.widget.separator,
        forced_height = height
    }
end
