--  ___ ___         __
-- |   |   |.-----.|  |.--.--.--------.-----.
-- |   |   ||  _  ||  ||  |  |        |  -__|
--  \_____/ |_____||__||_____|__|__|__|_____|
--  _______ _______ _____
-- |       |     __|     \
-- |   -   |__     |  --  |
-- |_______|_______|_____/
-- ------------------------------------------------- --
local screen = awful.screen.focused()
local height = dpi(200)
local width = dpi(200)

local volume_osd_icon =
    wibox.widget(
    {
        id = 'popup_icon',
        image = icons.volume,
        align = 'center',
        forced_height = dpi(72),
        forced_width = dpi(72),
        valign = 'center',
        widget = wibox.widget.imagebox()
    }
)
-- ------------------------------------------------- --
local volume_osd_bar =
    wibox.widget(
    {
        nil,
        {
            id = 'volume_osd_progressbar',
            max_value = 100,
            value = 0,
            background_color = colors.alpha(colors.colorH, '88'),
            color = colors.white,
            shape = gears.shape.rounded_bar,
            bar_shape = gears.shape.rounded_rect,
            widget = wibox.widget.progressbar
        },
        nil,
        expand = 'none',
        layout = wibox.layout.align.vertical
    }
)
-- ------------------------------------------------- --
local volume_osd =
    wibox(
    {
        type = 'notification',
        x = screen.geometry.width / 2 - width / 2,
        y = screen.geometry.height / 2 - height / 2 + 300,
        width = width,
        height = height,
        visible = false,
        ontop = true,
        bg = colors.alpha(colors.black, '88')
    }
)

-- ------------------------------------------------- --
volume_osd:setup(
    {
        {
            layout = wibox.layout.align.vertical,
            {
                volume_osd_icon,
                top = dpi(35),
                left = dpi(65),
                right = dpi(65),
                bottom = dpi(35),
                widget = wibox.container.margin
            },
            {
                volume_osd_bar,
                left = dpi(25),
                right = dpi(25),
                bottom = dpi(30),
                widget = wibox.container.margin
            }
        },
        shape = beautiful.client_shape_rounded_xl,
        bg = colors.alpha(colors.black, '88'),
        border_width = dpi(2),
        border_color = colors.alpha(colors.colorA, 'aa'),
        widget = wibox.container.background
    }
)
-- ------------------------------------------------- --
local volume_osd_timeout =
    gears.timer(
    {
        timeout = 3,
        autostart = true,
        callback = function()
            volume_osd.visible = false
        end
    }
)
-- ------------------------------------------------- --
local function toggle_volume_osd()
    if volume_osd.visible then
        volume_osd_timeout:again()
    else
        volume_osd.visible = true
        volume_osd_timeout:start()
    end
end
-- ------------------------------------------------- --
awesome.connect_signal(
    'signal::volume',
    function(value, muted)
        volume_osd_bar.volume_osd_progressbar.value = value
        if muted == 1 or value == 0 then
            volume_osd_icon.popup_icon = icons.mute
            volume_osd_bar.volume_osd_progressbar.color = colors.white
        else
            volume_osd_icon.popup_icon = icons.volume
            volume_osd_bar.volume_osd_progressbar.color = colors.white
        end
        toggle_volume_osd()
    end
)
