--  _______         __ __
-- |    ___|.--.--.|__|  |_
-- |    ___||_   _||  |   _|
-- |_______||__.__||__|____|

--  _______
-- |     __|.----.----.-----.-----.-----.
-- |__     ||  __|   _|  -__|  -__|     |
-- |_______||____|__| |_____|_____|__|__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Assign the directory to pull images for icons from
--
local config_dir = filesystem.get_configuration_dir()
local widget_icon_dir = config_dir .. 'configuration/user-profile/'
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Create User Name Display Headline
--
local profile_name =
    wibox.widget {
    markup = 'user@hostname',
    font = beautiful.exit_screen_font,
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Assign the User Image
--
local profile_imagebox =
    wibox.widget {
    image = widget_icon_dir .. 'user.png',
    resize = true,
    forced_height = dpi(140),
    clip_shape = gears.shape.square,
    widget = wibox.widget.imagebox
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Update the picture in the unlikely event its changed
--
local update_profile_pic = function()
    awful.spawn.easy_async_with_shell(
        apps.utils.update_profile,
        function(stdout)
            stdout = stdout:gsub('%\n', '')
            if not stdout:match('default') then
                profile_imagebox:set_image(stdout)
            else
                profile_imagebox:set_image(widget_icon_dir .. 'user.png')
            end
            profile_imagebox:emit_signal('widget::redraw_needed')
        end
    )
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Run update picture for good measure
--
update_profile_pic()
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Update user name in the even more unlikely even tit changed
--
local update_user_name = function()
    awful.spawn.easy_async_with_shell(
        [[
		fullname="$(getent passwd `whoami` | cut -d ':' -f 5 | cut -d ',' -f 1 | tr -d "\n")"
		if [ -z "$fullname" ];
		then
				printf "$(whoami)@$(hostname)"
		else
			printf "$fullname"
		fi
		]],
        function(stdout)
            stdout = stdout:gsub('%\n', '')
            local first_name = stdout:match('(.*)@') or stdout:match('(.-)%s')
            first_name = first_name:sub(1, 1):upper() .. first_name:sub(2)
            profile_name:set_markup(stdout)
            profile_name:emit_signal('widget::redraw_needed')
        end
    )
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Run the user name function for good measure
--
update_user_name()
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Create button widget text box template
--
local build_power_button = function(name, icon, callback)
    local power_button_label =
        wibox.widget {
        text = name,
        font = beautiful.exit_screen_font,
        align = 'center',
        valign = 'center',
        widget = wibox.widget.textbox
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- General templating for the buttons
    --
    local power_button =
        wibox.widget {
        {
            {
                {
                    {
                        image = icon,
                        widget = wibox.widget.imagebox
                    },
                    margins = dpi(2),
                    widget = wibox.container.margin
                },
                bg = beautiful.groups_bg,
                widget = wibox.container.background
            },
            shape = gears.shape.rounded_rect,
            forced_width = dpi(216),
            forced_height = dpi(216),
            widget = clickable_container
        },
        left = dpi(24),
        right = dpi(24),
        widget = wibox.container.margin
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Templating for the buttons as members of a group
    local exit_screen_item =
        wibox.widget {
        layout = wibox.layout.fixed.vertical,
        spacing = dpi(15),
        power_button,
        power_button_label
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- signal indicating button press is released
    exit_screen_item:connect_signal(
        'button::release',
        function()
            callback()
        end
    )
    return exit_screen_item
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Suspend Command
local suspend_command = function()
    awesome.emit_signal('module::exit_screen:hide')
    awful.spawn.with_shell(apps.default.lock .. ' & loginctl suspend')
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local logout_command = function()
    awesome.quit()
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local lock_command = function()
    awesome.emit_signal('module::exit_screen:hide')
    awful.spawn.with_shell(apps.default.lock)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local poweroff_command = function()
    awful.spawn.with_shell('poweroff')
    awesome.emit_signal('module::exit_screen:hide')
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local reboot_command = function()
    awful.spawn.with_shell('reboot')
    awesome.emit_signal('module::exit_screen:hide')
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local poweroff = build_power_button('Shutdown', icons.power, poweroff_command)
local reboot = build_power_button('Restart', icons.restart, reboot_command)
local suspend = build_power_button('Sleep', icons.sleep, suspend_command)
local logout = build_power_button('Logout', icons.logout, logout_command)
local lock = build_power_button('Lock', icons.lock, lock_command)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local create_exit_screen = function(s)
    s.exit_screen =
        wibox {
        screen = s,
        type = 'splash',
        visible = false,
        ontop = true,
        bg = beautiful.exit_screen_bg,
        fg = beautiful.fg_normal,
        height = s.geometry.height,
        width = s.geometry.width,
        x = s.geometry.x,
        y = s.geometry.y
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    s.exit_screen:buttons(
        gears.table.join(
            awful.button(
                {},
                2,
                function()
                    awesome.emit_signal('module::exit_screen:hide')
                end
            ),
            awful.button(
                {},
                3,
                function()
                    awesome.emit_signal('module::exit_screen:hide')
                end
            )
        )
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    s.exit_screen:setup {
        layout = wibox.layout.align.vertical,
        expand = 'none',
        nil,
        {
            layout = wibox.layout.align.vertical,
            {
                nil,
                {
                    layout = wibox.layout.fixed.vertical,
                    spacing = dpi(5),
                    {
                        layout = wibox.layout.align.vertical,
                        expand = 'none',
                        nil,
                        {
                            layout = wibox.layout.align.horizontal,
                            expand = 'none',
                            nil,
                            profile_imagebox,
                            nil
                        },
                        nil
                    },
                    profile_name
                },
                nil,
                expand = 'none',
                layout = wibox.layout.align.horizontal
            },
            {
                layout = wibox.layout.align.horizontal,
                expand = 'none',
                nil,
                {
                    widget = wibox.container.margin,
                    margins = dpi(5)
                },
                nil
            },
            {
                layout = wibox.layout.align.horizontal,
                expand = 'none',
                nil,
                {
                    {
                        {
                            poweroff,
                            reboot,
                            suspend,
                            logout,
                            lock,
                            layout = wibox.layout.fixed.horizontal
                        },
                        spacing = dpi(30),
                        layout = wibox.layout.fixed.vertical
                    },
                    widget = wibox.container.margin,
                    margins = dpi(5)
                },
                nil
            }
        },
        nil
    }
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
screen.connect_signal(
    'request::desktop_decoration',
    function(s)
        create_exit_screen(s)
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
screen.connect_signal(
    'removed',
    function(s)
        create_exit_screen(s)
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local exit_screen_grabber =
    awful.keygrabber {
    auto_start = true,
    stop_event = 'release',
    keypressed_callback = function(self, mod, key, command)
        if key == 's' then
            suspend_command()
        elseif key == 'e' then
            logout_command()
        elseif key == 'l' then
            lock_command()
        elseif key == 'p' then
            poweroff_command()
        elseif key == 'r' then
            reboot_command()
        elseif key == 'Escape' or key == 'q' or key == 'x' then
            awesome.emit_signal('module::exit_screen:hide')
        end
    end
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
awesome.connect_signal(
    'module::exit_screen:show',
    function()
        for s in screen do
            s.exit_screen.visible = false
        end
        awful.screen.focused().exit_screen.visible = true
        exit_screen_grabber:start()
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
awesome.connect_signal(
    'module::exit_screen:hide',
    function()
        exit_screen_grabber:stop()
        for s in screen do
            s.exit_screen.visible = false
        end
    end
)
