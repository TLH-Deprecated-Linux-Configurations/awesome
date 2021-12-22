--  _______ __              __
-- |   _   |__|.----.-----.|  |.---.-.-----.-----.
-- |       |  ||   _|  _  ||  ||  _  |     |  -__|
-- |___|___|__||__| |   __||__||___._|__|__|_____|
--                  |__|
--  _______           __
-- |   |   |.-----.--|  |.-----.
-- |       ||  _  |  _  ||  -__|
-- |__|_|__||_____|_____||_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local config_dir = gears.filesystem.get_configuration_dir()
local widget_dir = config_dir .. "widget/airplane-mode/"
local widget_icon_dir = widget_dir .. "icons/"
local icons = require("theme.icons")
local ap_state = false
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Provide text to the widget
--
local action_name =
    wibox.widget {
    text = "Airplane Mode",
    font = "SFMono Nerd Font Mono Heavy  10",
    align = "left",
    widget = wibox.widget.textbox
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Provide the widget state with text
local action_status =
    wibox.widget {
    text = "Off",
    font = "SFMono Nerd Font Mono Heavy  10",
    align = "left",
    widget = wibox.widget.textbox
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local action_info =
    wibox.widget {
    layout = wibox.layout.fixed.vertical,
    action_name,
    action_status
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local button_widget =
    wibox.widget {
    {
        id = "icon",
        image = widget_icon_dir .. "airplane-mode-off.svg",
        widget = wibox.widget.imagebox,
        resize = true
    },
    layout = wibox.layout.align.horizontal
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- provide the template for the button
--
local widget_button =
    wibox.widget {
    {
        {
            button_widget,
            margins = dpi(15),
            forced_height = dpi(48),
            forced_width = dpi(48),
            widget = wibox.container.margin
        },
        widget = clickable_container
    },
    bg = beautiful.groups_bg,
    shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 4)
    end,
    widget = wibox.container.background
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- update the state of the widget, its icon and system
local update_widget = function()
    if ap_state then
        action_status:set_text("On")
        widget_button.bg = beautiful.accent
        button_widget.icon:set_image(widget_icon_dir .. "airplane-mode.svg")
    else
        action_status:set_text("Off")
        widget_button.bg = beautiful.groups_bg
        button_widget.icon:set_image(widget_icon_dir .. "airplane-mode-off.svg")
    end
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Detemine the current state of the mode
--

local check_airplane_mode_state = function()
    local cmd = "cat " .. widget_dir .. "airplane_mode"
    awful.spawn.easy_async_with_shell(
        cmd,
        function(stdout)
            local status = stdout

            if status:match("true") then
                ap_state = true
            elseif status:match("false") then
                ap_state = false
            else
                ap_state = false
                awful.spawn.easy_async_with_shell(
                    'echo "false" > ' .. widget_dir .. "airplane_mode",
                    function(stdout)
                    end
                )
            end
            update_widget()
        end
    )
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- check the state at the onset
--
check_airplane_mode_state()
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- BASH for when the mode is turned back off
local ap_off_cmd =
    [[
	
	rfkill unblock wlan

	# Create an AwesomeWM Notification
	awesome-client "
	naughty = require('naughty')
	naughty.notification({
		app_name = 'Network Manager',
		title = '<b>Airplane mode disabled!</b>',
		message = 'Initializing network devices',
		icon = ']] ..
    widget_icon_dir ..
        "airplane-mode-off" .. ".svg" .. [['
	})
	"
	]] .. "echo false > " .. widget_dir .. "airplane_mode" .. [[
]]
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- BASH for when the mode is turned on
--
local ap_on_cmd =
    [[

	rfkill block wlan

	# Create an AwesomeWM Notification
	awesome-client "
	naughty = require('naughty')
	naughty.notification({
		app_name = 'Network Manager',
		title = '<b>Airplane mode enabled!</b>',
		message = 'Disabling radio devices',
		icon = ']] ..
    widget_icon_dir ..
        "airplane-mode" .. ".svg" .. [['
	})
	"
	]] .. "echo true > " .. widget_dir .. "airplane_mode" .. [[
]]
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Create functionality for button\
--
local toggle_action = function()
    if ap_state then
        awful.spawn.easy_async_with_shell(
            ap_off_cmd,
            function(stdout)
                ap_state = false
                update_widget()
            end
        )
    else
        awful.spawn.easy_async_with_shell(
            ap_on_cmd,
            function(stdout)
                ap_state = true
                update_widget()
            end
        )
    end
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Assign the button its functionality
--

widget_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                toggle_action()
            end
        )
    )
)
action_info:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                toggle_action()
            end
        )
    )
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local action_widget =
    wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    spacing = dpi(10),
    widget_button,
    {
        layout = wibox.layout.align.vertical,
        expand = "none",
        nil,
        action_info,
        nil
    }
}

return action_widget
