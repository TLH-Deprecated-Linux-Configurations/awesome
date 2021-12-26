--  _______                  __
-- |    ___|.--------.-----.|  |_.--.--.
-- |    ___||        |  _  ||   _|  |  |
-- |_______||__|__|__|   __||____|___  |
--                   |__|        |_____|
--  _______         __   __   ___ __   ___ __              __   __
-- |    |  |.-----.|  |_|__|.'  _|__|.'  _|__|.----.---.-.|  |_|__|.-----.-----.
-- |       ||  _  ||   _|  ||   _|  ||   _|  ||  __|  _  ||   _|  ||  _  |     |
-- |__|____||_____||____|__||__| |__||__| |__||____|___._||____|__||_____|__|__|
--  ______
-- |   __ \.-----.--.--.
-- |   __ <|  _  |_   _|
-- |______/|_____|__.__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Set icon directory
--
local config_dir = require("gears").filesystem.get_configuration_dir()
local widget_icon_dir = config_dir .. "layout/bottom-panel/widget/info-center/widget/notif-center/icons/"
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Widget Template
local empty_notifbox =
    wibox.widget {
    {
        layout = wibox.layout.fixed.vertical,
        spacing = dpi(5),
        {
            expand = "none",
            layout = wibox.layout.align.horizontal,
            nil,
            {
                image = widget_icon_dir .. "empty-notification" .. ".svg",
                resize = true,
                forced_height = dpi(35),
                forced_width = dpi(35),
                widget = wibox.widget.imagebox
            },
            nil
        },
        -- ########################################################################
        -- Message
        {
            -- ########################################################################
            -- Heading
            text = "All Cleared",
            font = "SFMono Nerd Font Mono Heavy  14",
            align = "center",
            valign = "center",
            widget = wibox.widget.textbox
        },
        {
            -- ########################################################################
            -- Body

            text = "There are no notifications for you to review at this time.",
            font = "SFMono Nerd Font Mono Heavy  10",
            align = "center",
            valign = "center",
            widget = wibox.widget.textbox
        }
    },
    margins = dpi(20),
    widget = wibox.container.margin
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Creates separator for the empty message
local separator_for_empty_msg =
    wibox.widget {
    orientation = "vertical",
    opacity = 0.1,
    widget = wibox.widget.separator
}

-- Make empty_notifbox center
local centered_empty_notifbox =
    wibox.widget {
    layout = wibox.layout.align.vertical,
    forced_height = dpi(250),
    expand = "none",
    separator_for_empty_msg,
    empty_notifbox,
    separator_for_empty_msg
}

return centered_empty_notifbox
