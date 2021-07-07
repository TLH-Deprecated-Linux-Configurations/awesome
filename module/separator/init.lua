--  _______                                __
-- |     __|.-----.-----.---.-.----.---.-.|  |_.-----.----.
-- |__     ||  -__|  _  |  _  |   _|  _  ||   _|  _  |   _|
-- |_______||_____|   __|___._|__| |___._||____|_____|__|
--                |__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local wibox = require("wibox")
-- ########################################################################
-- ########################################################################
-- ########################################################################
--- Create a new separate widget
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
