--  __           __   __
-- |  |--.--.--.|  |_|  |_.-----.-----.
-- |  _  |  |  ||   _|   _|  _  |     |
-- |_____|_____||____|____|_____|__|__|

-- ########################################################################
-- ########################################################################
-- ########################################################################
local wibox = require("wibox")
local rounded = require("lib.widget.rounded")
local beautiful = require("beautiful")
local gears = require("gears")
local signals = require("module.signals")
local dpi = beautiful.xresources.apply_dpi
-- ########################################################################
-- ########################################################################
-- ########################################################################
--- Create a new button widget
return function(body, callback, bNo_center, leave_callback, no_update)
    local button = wibox.container.background()
    local bIsHovered = false
    button.bg = beautiful.bg_focus
    button.shape = rounded()
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
