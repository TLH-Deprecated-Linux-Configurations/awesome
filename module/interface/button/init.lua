-- ########################################################################
--
--  Button
--  Description:  Provides the button functions
-- ########################################################################
-- ########################################################################
-- ########################################################################
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local dpi = beautiful.xresources.apply_dpi
-- ########################################################################
-- ########################################################################
-- ########################################################################
--- Create a new button widget
return function(body, callback, bNo_center, leave_callback, no_update)
    local button = wibox.container.background()
    local bIsHovered = false
    button.bg = beautiful.bg_focus
    button.border_color = beautiful.xbackground
    button.border_width = dpi(3)
    button.border_radius = dpi(12)
    button.shape = function(cr, rect_width, rect_height)
        gears.shape.partially_rounded_rect(cr, rect_width, rect_height, true, true, true, true, 12)
    end
    button.forced_height = dpi(40)
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    if type(body) == "string" then
        body = wibox.widget.textbox(body)
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    --- Emulate a hover event
    button.emulate_hover = function()
        bIsHovered = true
        button.bg = beautiful.xcolor7
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    --- Emulate a hover unfocus event
    button.emulate_focus_loss = function()
        bIsHovered = false
        button.bg = beautiful.bg_normal .. "00"
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    button:connect_signal(
        "mouse::enter",
        function()
            button.emulate_hover()
        end
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    button:connect_signal(
        "mouse::leave",
        function()
            button.emulate_focus_loss()
        end
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    if bNo_center then
        button:setup {
            layout = wibox.container.margin,
            body
        }
    else
        button:setup {
            layout = wibox.container.place,
            halign = "center",
            body
        }
    end
    button:buttons(gears.table.join(awful.button({}, 1, callback)))
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    --- Manually update the color pallet used by the button, usually used when you want the button to not follow the theming
    button.update_pallet = function(new_pallet)
        button.color = new_pallet
        if bIsHovered then
            button.emulate_hover()
        else
            button.emulate_focus_loss()
        end
    end

    return button
end
