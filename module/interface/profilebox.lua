--  ______              ___ __ __             ______
-- |   __ \.----.-----.'  _|__|  |.-----.    |   __ \.-----.--.--.
-- |    __/|   _|  _  |   _|  |  ||  -__|    |   __ <|  _  |_   _|
-- |___|   |__| |_____|__| |__|__||_____|    |______/|_____|__.__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local wibox = require("wibox")
local theme = require("theme.icons")
local beautiful = require("beautiful")
-- ########################################################################
-- ########################################################################
-- ########################################################################

--
return function(picture, diameter, clicked_callback, tooltip_callback)
    local widget = wibox.widget {
        widget = wibox.widget.imagebox,
        shape = beautiful.btn_lg_shape,
        clip_shape = beautiful.btn_lg_shape,
        resize = true,
        forced_width = diameter,
        forced_height = diameter
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    widget:set_image(theme.user)
    widget:connect_signal("button::press", function(_, _, _, button)
        clicked_callback(button)
    end)
    if tooltip_callback ~= nil and type(tooltip_callback) == "function" then
        awful.tooltip {objects = {widget}, timer_function = tooltip_callback}
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    --- Update the image of the profilebox
    -- slider.update("/path/to/a/new/image.png")
    widget.update = function(file) widget:set_image(file) end
    return widget
end
