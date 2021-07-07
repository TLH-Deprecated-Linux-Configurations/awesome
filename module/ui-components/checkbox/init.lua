--  ______ __                __     __
-- |      |  |--.-----.----.|  |--.|  |--.-----.--.--.
-- |   ---|     |  -__|  __||    < |  _  |  _  |_   _|
-- |______|__|__|_____|____||__|__||_____|_____|__.__|

-- ########################################################################
-- ########################################################################
-- ########################################################################
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local signals = require("module.settings.signals")
local dpi = beautiful.xresources.apply_dpi
-- ########################################################################
-- ########################################################################
-- ########################################################################
local theme = beautiful.xcolor4

--- Create a new checkbox widget
-- @tparam number size The height of the checkbox
-- @treturn widget The checkbox widget
-- @staticfct checkbox
-- @usage -- This will create a checkbox that is 20 pixels high
-- -- checkbox that is 20 pixels high
-- local checkbox = module.checkbox(dpi(20))
return function(checked, callback, size)
    local checkbox =
        wibox.widget {
        checked = checked,
        color = theme.hue_700,
        paddings = dpi(2),
        check_border_color = theme.hue_600,
        check_color = theme.hue_600,
        check_border_width = dpi(2),
        shape = gears.shape.circle,
        forced_height = size or dpi(20),
        widget = wibox.widget.checkbox
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    signals.connect_primary_theme_changed(
        function(new_theme)
            theme = new_theme
            checkbox.check_border_color = theme.hue_600
            checkbox.check_color = theme.hue_600
            checkbox.color = theme.hue_700
        end
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    checkbox:connect_signal(
        "button::press",
        function(_, _, _, button)
            if not (button == 1) then
                return
            end
            print("Pressed checkbox")
            checkbox.checked = not checkbox.checked
            callback(checkbox.checked or false)
        end
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    checkbox:connect_signal(
        "mouse::enter",
        function()
            if checkbox.checked then
                checkbox.check_color = theme.hue_700
            end
        end
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    checkbox:connect_signal(
        "mouse::leave",
        function()
            if checkbox.checked then
                checkbox.check_color = theme.hue_600
            end
        end
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    --- Update the checked state of the checkbox
    -- @staticfct update
    -- @usage -- Set the checkbox to 'true'
    -- checkbox.update(true)
    checkbox.update = function(new_checked)
        checkbox.checked = new_checked
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    return checkbox
end
