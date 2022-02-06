--  _______
-- |   |   |.-----.-----.----.
-- |   |   ||__ --|  -__|   _|
-- |_______||_____|_____|__|

--  ______              ___ __ __
-- |   __ \.----.-----.'  _|__|  |.-----.
-- |    __/|   _|  _  |   _|  |  ||  -__|
-- |___|   |__| |_____|__| |__|__||_____|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local clickable_container = require('module.clickable-container')
local config_dir = gears.filesystem.get_configuration_dir()
local widget_icon_dir = config_dir .. 'configuration/user-profile/'
local user_icon_dir = '/var/lib/AccountsService/icons/'
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
title_table = {
    'Heads Up!',
    'Listen Here!',
    'Take Heed!'
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
message_table = {
    'Stop screwing things up, go walk the dog or something!',
    'There can only be one cow level',
    'Remember the words of the propher Richard Stallman: Free as in freedom, not free as in beer.',
    'At least you are not as ugly as Bill Gates.',
    'When it rains, it pours.',
    'The dead know only one thing, its better to be alive'
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local create_profile = function()
    local profile_imagebox =
        wibox.widget {
        {
            id = 'icon',
            image = widget_icon_dir .. 'user.png',
            widget = wibox.widget.imagebox,
            resize = true,
            forced_height = dpi(28),
            clip_shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, beautiful.groups_radius)
            end
        },
        layout = wibox.layout.align.horizontal
    }

    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    local profile_name =
        wibox.widget {
        font = 'Nineteen Ninety Seven Regular  10',
        markup = 'User',
        align = 'left',
        valign = 'center',
        widget = wibox.widget.textbox
    }
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    local update_profile_image = function()
        awful.spawn.easy_async_with_shell(
            apps.utils.update_profile,
            function(stdout)
                stdout = stdout:gsub('%\n', '')
                if not stdout:match('default') then
                    profile_imagebox.icon:set_image(stdout)
                else
                    profile_imagebox.icon:set_image(widget_icon_dir .. 'user.png')
                end
            end
        )
    end
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    update_profile_image()

    awful.spawn.easy_async_with_shell(
        [[
		sh -c '
		fullname="$(getent passwd `whoami` | cut -d ':' -f 5 | cut -d ',' -f 1 | tr -d "\n")"
		if [ -z "$fullname" ];
		then
			printf "$(whoami)@$(hostname)"
		else
			printf "$fullname"
		fi
		'
		]],
        function(stdout)
            local stdout = stdout:gsub('%\n', '')
            profile_name:set_markup(stdout)
        end
    )
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    local user_profile =
        wibox.widget {
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(5),
        {
            layout = wibox.layout.align.vertical,
            expand = 'none',
            nil,
            profile_imagebox,
            nil
        },
        profile_name
    }
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    return user_profile
end

return create_profile
