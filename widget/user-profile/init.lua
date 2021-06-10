-- YOU CAN UPDATE YOUR PROFILE PICTURE USING `mugshot` package
-- Will use default user.svg if there's no user image in /var/lib/...

local wibox = require('wibox')
local dpi = require('beautiful').xresources.apply_dpi
local profilebox = require('lib.profilebox')
local card = require('lib.card')
local HOME = os.getenv('HOME')
local PATH_TO_ICONS = HOME .. '/.config/awesome/widget/user-profile/icons/'

local PATH_TO_CACHE_ICON = os.getenv('HOME') .. '/.cache/tos/user-icons/'

local signals = require('module.signals')
local filehandle = require('lib.file')

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
    align = 'left',
    valign = 'bottom',
    widget = wibox.widget.textbox
}

local distro_name =
    wibox.widget {
    align = 'left',
    valign = 'center',
    widget = wibox.widget.textbox
}

local kernel_name =
    wibox.widget {
    align = 'left',
    valign = 'center',
    widget = wibox.widget.textbox
}

local uptime_time =
    wibox.widget {
    align = 'left',
    valign = 'center',
    widget = wibox.widget.textbox
}

local function init()
    -- get the username
    signals.connect_username(
        function(name)
            profile_name.markup = '<span font="SFNS Display Bold 24">' .. name .. '</span>'
        end
    )

    signals.connect_profile_picture_changed(
        function(picture)
            profile_imagebox.update(picture)
        end
    )

    signals.connect_distro(
        function(distroname)
            distro_name.markup = '<span font="SFNS Display Regular 12">' .. distroname .. '</span>'
        end
    )

    signals.connect_uptime(
        function(time)
            uptime_time.markup = '<span font="SFNS Display Regular 10">' .. time .. '</span>'
        end
    )

    -- Run once on startup or login
    awful.spawn.easy_async_with_shell(
        "uname -r | cut -d '-' -f 1,2",
        function(out)
            local kernel = out:gsub('%\n', '')
            kernel_name.markup = '<span font="SFNS Display Regular 12">Kernel: ' .. kernel .. '</span>'
            signals.emit_kernel(kernel)
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
            margins = dpi(3),
            widget = wibox.container.margin
        },
        {
            -- expand = 'none',
            layout = wibox.layout.fixed.vertical,
            {
                wibox.container.margin(profile_name, dpi(5)),
                layout = wibox.layout.fixed.horizontal
            },
            {
                wibox.container.margin(distro_name, dpi(5)),
                layout = wibox.layout.fixed.vertical
            },
            {
                wibox.container.margin(kernel_name, dpi(5)),
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
