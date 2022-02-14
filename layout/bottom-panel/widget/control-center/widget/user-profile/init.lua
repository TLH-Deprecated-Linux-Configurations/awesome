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
local clickable_container = require("module.clickable-container")
local config_dir = gears.filesystem.get_configuration_dir()
local widget_icon_dir = config_dir .. "configuration/user-profile/"
local user_icon_dir = "/var/lib/AccountsService/icons/"
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local create_profile = function()
    local profile_imagebox =
        wibox.widget {
        {
            id = "icon",
            image = widget_icon_dir .. "user.png",
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
        font = "Nineteen Ninety Seven Regular  10",
        markup = "User",
        align = "left",
        valign = "center",
        widget = wibox.widget.textbox
    }

    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --

    awful.spawn.easy_async_with_shell(
        [[
		"$(whoami)"
		]],
        function(stdout)
            profile_name:set_markup(tostring(stdout))
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
            expand = "none",
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
