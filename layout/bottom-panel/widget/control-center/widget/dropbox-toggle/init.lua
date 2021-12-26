--  _____                    __
-- |     \.----.-----.-----.|  |--.-----.--.--.
-- |  --  |   _|  _  |  _  ||  _  |  _  |_   _|
-- |_____/|__| |_____|   __||_____|_____|__.__|
--                   |__|
--  _______                     __
-- |_     _|.-----.-----.-----.|  |.-----.
--   |   |  |  _  |  _  |  _  ||  ||  -__|
--   |___|  |_____|___  |___  ||__||_____|
--                |_____|_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local clickable_container = require("widget.clickable-container")
local config_dir = gears.filesystem.get_configuration_dir()
local widget_dir = config_dir .. "layout/bottom-panel/widget/control-center/widget/dropbox-toggle/"
local widget_icon_dir = widget_dir .. "icons/"
local icons = require("theme.icons")
local device_state = false
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Icons
--
local dropbox_status_blank = widget_icon_dir .. "dropboxstatus-blank.png"
local dropbox_status_busy2 = widget_icon_dir .. "dropboxstatus-busy2.png"
local dropbox_status_busy1 = widget_icon_dir .. "dropboxstatus-busy1.png"
local dropbox_status_idle = widget_icon_dir .. "dropboxstatus-idle.png"
local dropbox_status_logo = widget_icon_dir .. "dropboxstatus-logo.png"
local dropbox_status_x = widget_icon_dir .. "dropboxstatus-x.png"
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Text for toggle button
--
local action_name =
    wibox.widget {
    text = "Dropbox",
    font = "SFMono Nerd Font Mono Heavy  10",
    align = "left",
    widget = wibox.widget.textbox
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- text for dropbox status (on of off)
--
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
-- Title and status in box
--
local action_info =
    wibox.widget {
    layout = wibox.layout.fixed.vertical,
    action_name,
    action_status
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- button template 
local button_widget =
    wibox.widget {
    {
        id = "icon",
        image = widget_icon_dir .. "dropboxstatus-logo.png",
        widget = wibox.widget.imagebox,
        resize = true
    },
    layout = wibox.layout.align.horizontal
}

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- button template wrapper for sizing etc
--
local widget_button =
    wibox.widget {
    {
        {
            button_widget,
            margins = dpi(12),
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
-- update the widget
--
local update_widget = function()
    if device_state then
        action_status:set_text("On")
        widget_button.bg = beautiful.accent
        button_widget.icon:set_image(widget_icon_dir .. "dropboxstatus-logo.png")
    else
        action_status:set_text("Off")
        widget_button.bg = beautiful.groups_bg
        button_widget.icon:set_image(widget_icon_dir .. "dropboxstatus-x.svg")
    end
end

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- checks state of the widget 
--
local check_device_state = function()
    awful.spawn.easy_async_with_shell(
        "dropbox running",
        function(stdout)
            if stdout:match("*") then
                device_state = false
            else
                device_state = true
            end

            update_widget()
        end
    )
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- provides on command
check_device_state()
local power_on_cmd =
    [[
dropbox start &
	sleep 1
	# Create an AwesomeWM Notification
	awesome-client "
	naughty = require('naughty')
	naughty.notification({
		app_name = 'Dropbox - Powering On',
		title = 'System Notification',
		message = 'Initializing Dropbox...',
		icon = ']] ..
    widget_icon_dir .. "dropboxstatus-logo" .. ".png" 
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- power off command
--
local power_off_cmd =
    [[
dropbox stop
sleep 1
	# Create an AwesomeWM Notification
	awesome-client "
	naughty = require('naughty')
	naughty.notification({
		app_name = 'Dropbox - Powering Off',
		title = 'System Notification',
		message = 'The dropbox daemon has been disabled.',
		icon = ']] ..
    widget_icon_dir .. "dropboxstatus-x" .. ".png" .. [['
	})
	"
]]
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Toggles the command between on & off + vice versa
local toggle_action = function()
    if device_state then
        awful.spawn.easy_async_with_shell(
            power_off_cmd,
            function(stdout)
                device_state = false
                update_widget()
            end
        )
    else
        awful.spawn.easy_async_with_shell(
            power_on_cmd,
            function(stdout)
                device_state = true
                update_widget()
            end
        )
    end
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- provides buttons
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
-- determine state by watching command
--
watch(
    "dropbox status &",
    5,
    function(_, stdout)
        check_device_state()
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- final wrapper around button/command
--
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
