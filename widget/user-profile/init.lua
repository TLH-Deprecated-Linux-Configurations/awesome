-- YOU CAN UPDATE YOUR PROFILE PICTURE USING `mugshot` package
-- Will use default user.svg if there's no user image in /var/lib/...

local wibox = require('wibox')
local dpi = require('beautiful').xresources.apply_dpi
local profilebox = require('lib.profilebox')
local card = require('module.card')
local HOME = os.getenv('HOME')
local PATH_TO_ICONS = HOME .. '/.config/awesome/widget/user-profile/icons/'

local PATH_TO_CACHE_ICON = os.getenv('HOME') .. '/.cache/awesome/user-icons/'

local signals = require('module.signals')
local filehandle = require('module.file')

local user_card = card()

-- guarantee that the cache dir exists
filehandle.dir_create(PATH_TO_CACHE_ICON)

local profile_imagebox =
    profilebox(
    PATH_TO_ICONS .. 'user' .. '.svg',
    dpi(90),
    function(_)
    end
)

local profile_name =
    wibox.widget {
    align = 'right',
    valign = 'bottom',
    widget = wibox.widget.textbox
}

local distro_name =
    wibox.widget {
    align = 'right',
    valign = 'center',
    widget = wibox.widget.textbox
}

local uptime_time =
    wibox.widget {
    align = 'right',
    valign = 'center',
    widget = wibox.widget.textbox
}

local function init()
    -- get the username
    signals.connect_username(
        function(name)
            profile_name.markup = '<span font="agave Nerd Font Mono Bold 24">' .. name .. '</span>'
        end
    )

    signals.connect_profile_picture_changed(
        function(picture)
            profile_imagebox.update(picture)
        end
    )

    signals.connect_distro(
        function(distroname)
            distro_name.markup = '<span font="agave Nerd Font Mono Bold  16">' .. distroname .. '</span>'
        end
    )

    signals.connect_uptime(
        function(time)
            uptime_time.markup = '<span font="agave Nerd Font Mono Bold  8">' .. time .. '</span>'
        end
    )
end

init()

local body =
    wibox.widget {
    {
        layout = wibox.layout.align.horizontal,
        {
            profile_imagebox,
            margins = dpi(0),
            widget = wibox.container.margin
        },
        {
            -- expand = 'none',
            layout = wibox.layout.fixed.vertical,
            {
                wibox.container.margin(profile_name, dpi(5)),
                layout = wibox.layout.fixed.vertical
            },
            {
                wibox.container.margin(distro_name, dpi(5)),
                layout = wibox.layout.fixed.vertical
            },
            {
                wibox.container.margin(uptime_time, dpi(5)),
                layout = wibox.layout.fixed.vertical
            }
        }
    },
    margins = dpi(5),
    widget = wibox.container.margin
}
user_card.update_body(body)

return user_card
