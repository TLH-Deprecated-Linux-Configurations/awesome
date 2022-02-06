--  ______ __
-- |   __ \  |.--.--.----.
-- |   __ <  ||  |  |   _|
-- |______/__||_____|__|
--  _______                     __
-- |_     _|.-----.-----.-----.|  |.-----.
--   |   |  |  _  |  _  |  _  ||  ||  -__|
--   |___|  |_____|___  |___  ||__||_____|
--                |_____|_____|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local config_dir = gears.filesystem.get_configuration_dir()
local widget_dir = config_dir .. 'layout/bottom-panel/widget/control-center/widget/blur-toggle/'
local widget_icon_dir = widget_dir .. 'icons/'
local icons = require('theme.icons')
local blur_status = true
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local action_name =
    wibox.widget {
    text = 'Blur Effects',
    font = 'Nineteen Ninety Seven Regular  10',
    align = 'left',
    widget = wibox.widget.textbox
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local action_status =
    wibox.widget {
    text = 'Off',
    font = 'Nineteen Ninety Seven Regular  10',
    align = 'left',
    widget = wibox.widget.textbox
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local action_info =
    wibox.widget {
    layout = wibox.layout.fixed.vertical,
    action_name,
    action_status
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local button_widget =
    wibox.widget {
    {
        id = 'icon',
        image = icons.effects,
        widget = wibox.widget.imagebox,
        resize = true
    },
    layout = wibox.layout.align.horizontal
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local widget_button =
    wibox.widget {
    {
        {
            button_widget,
            margins = dpi(15),
            forced_height = dpi(64),
            forced_width = dpi(64),
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
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local update_widget = function()
    if blur_status then
        action_status:set_text('On')
        widget_button.bg = beautiful.accent
        button_widget.icon:set_image(icons.effects)
    else
        action_status:set_text('Off')
        widget_button.bg = beautiful.groups_bg
        button_widget.icon:set_image(widget_icon_dir .. 'effects-off.svg')
    end
end
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local check_blur_status = function()
    awful.spawn.easy_async_with_shell(
        [[bash -c "
		grep -F 'method = \"none\";' $HOME/.config/picom.conf | tr -d '[\"\;\=\ ]'
		"]],
        function(stdout, stderr)
            if stdout:match('methodnone') then
                blur_status = false
            else
                blur_status = true
            end
            update_widget()
        end
    )
end
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
check_blur_status()
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local toggle_blur = function(togglemode)
    local toggle_blur_script =
        [[bash -c "
	# Check picom if it's not running then start it
	if [ -z $(pgrep picom) ]; then
		picom -b --experimental-backends --dbus --config $HOME/.config/picom.conf
	fi

	case ]] ..
        togglemode ..
            [[ in
		'enable')
		sed -i -e 's/method = \"none\"/method = \"dual_kawase\"/g' \"]] ..
                [[$HOME/.config/picom.conf\"
		;;
		'disable')
		sed -i -e 's/method = \"dual_kawase\"/method = \"none\"/g' \"]] ..
                    [[$HOME/.config/picom.conf\"
		;;
	esac
	"]]

    awful.spawn.with_shell(toggle_blur_script)
end
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local toggle_blur_fx = function()
    local state = nil
    if blur_status then
        blur_status = false
        state = 'disable'
    else
        blur_status = true
        state = 'enable'
    end
    toggle_blur(state)
    update_widget()
end
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
widget_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                toggle_blur_fx()
            end
        )
    )
)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
action_info:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                toggle_blur_fx()
            end
        )
    )
)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local action_widget =
    wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    spacing = dpi(10),
    widget_button,
    {
        layout = wibox.layout.align.vertical,
        expand = 'none',
        nil,
        action_info,
        nil
    }
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
awesome.connect_signal(
    'widget::blur:toggle',
    function()
        toggle_blur_fx()
    end
)

return action_widget
