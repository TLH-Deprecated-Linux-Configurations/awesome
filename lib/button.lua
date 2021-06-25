-- Create a new button widget
--
--
--    local button = module.button(dpi(20))
--
-- ![Button](../images/button.png)
--
-- @author Tom Meyers
-- @copyright 2020 Tom Meyers
-- @tdewidget module.button
-- @supermodule wibox.container.background
---------------------------------------------------------------------------
local wibox = require('wibox')
local rounded = require('lib.widget.rounded')
local beautiful = require('beautiful')
local gears = require('gears')
local signals = require('module.signals')
local dpi = beautiful.xresources.apply_dpi

--- Create a new button widget
-- @tparam widget body The widget to put in the center (usually an icon or text)
-- @tparam function callback The callback function to call when the button is pressed
-- @tparam[opt] table pallet A colorpallet from the theme.mat-colors file
-- @tparam[opt] bool bNo_center Don't center the content
-- @tparam[opt] function enter_callback This is called when the button receives focus
-- @tparam[opt] function leave_callback This is called when the button losses focus
-- @tparam[opt] bool no_update Don't update the color of the button (used in the theme settings)
-- @treturn widget The button widget
-- @staticfct button
-- @usage -- This will create a button that is red
-- local button = module.button(function()
--    print("Clicked")
-- end, require("theme.mat-colors").red)
return function(body, callback, bNo_center, enter_callback, leave_callback, no_update)
    local button = wibox.container.background()
    local color = beautiful.xcolor4
    local bIsHovered = false
    button.bg = beautiful.bg_focus
    button.shape = rounded()
    button.forced_height = dpi(40)

    if type(body) == 'string' then
        body = wibox.widget.textbox(i18n.translate(body))
    end

    --- Emulate a hover event
    -- @staticfct emulate_hover
    -- @usage -- Act as if the mouse hovered over the button
    -- button.emulate_hover()
    button.emulate_hover = function()
        bIsHovered = true
        button.bg = beautiful.xcolor7
    end

    --- Emulate a hover unfocus event
    -- @staticfct emulate_focus_loss
    -- @usage -- Act as if the mouse hovered over the button and then left
    -- button.emulate_focus_loss()
    button.emulate_focus_loss = function()
        bIsHovered = false
        button.bg = beautiful.bg_normal .. '00'
        if leave_callback then
            leave_callback(button)
        end
    end

    button:connect_signal(
        'mouse::enter',
        function()
            button.emulate_hover()
        end
    )
    button:connect_signal(
        'mouse::leave',
        function()
            button.emulate_focus_loss()
        end
    )
    if bNo_center then
        button:setup {
            layout = wibox.container.margin,
            body
        }
    else
        button:setup {
            layout = wibox.container.place,
            halign = 'center',
            body
        }
    end
    button:buttons(gears.table.join(awful.button({}, 1, callback)))

    --- Manually update the color pallet used by the button, usually used when you want the button to not follow the theming
    -- @staticfct update_pallet
    -- @usage -- Update the color pallet of the button
    -- button.update_pallet(require("theme.mat-colors").yellow)
    button.update_pallet = function(new_pallet)
        color = new_pallet
        if bIsHovered then
            button.emulate_hover()
        else
            button.emulate_focus_loss()
        end
    end

    if no_update == nil or no_update == false then
        signals.connect_primary_theme_changed(
            function(theme)
                color = theme
                if bIsHovered then
                    button.emulate_hover()
                else
                    button.emulate_focus_loss()
                end
            end
        )
    end

    return button
end
