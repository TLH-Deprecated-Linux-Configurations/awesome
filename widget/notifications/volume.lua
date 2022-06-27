--  ___ ___         __
-- |   |   |.-----.|  |.--.--.--------.-----.
-- |   |   ||  _  ||  ||  |  |        |  -__|
--  \_____/ |_____||__||_____|__|__|__|_____|

--               __   __   ___ __              __   __
-- .-----.-----.|  |_|__|.'  _|__|.----.---.-.|  |_|__|.-----.-----.-----.
-- |     |  _  ||   _|  ||   _|  ||  __|  _  ||   _|  ||  _  |     |__ --|
-- |__|__|_____||____|__||__| |__||____|___._||____|__||_____|__|__|_____|

local volume_osd_icon =
    wibox.widget(
    {
        {
            id = 'popup_icon',
            image = icons.volume,
            align = 'center',
            forced_height = dpi(96),
            forced_width = dpi(96),
            valign = 'center',
            widget = wibox.widget.imagebox()
        },
        top = dpi(15),
        left = dpi(50),
        right = dpi(50),
        bottom = dpi(15),
        widget = wibox.container.margin
    }
)

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
            shape = gears.shape.rounded_rect,
            bar_shape = gears.shape.rounded_rect,
            forced_height = dpi(24),
            widget = wibox.widget.progressbar
        },
        nil,
        expand = 'none',
        layout = wibox.layout.align.vertical
    }
)

local volume_osd_height = dpi(200)
local volume_osd_width = dpi(200)

screen.connect_signal(
    'request::desktop_decoration',
    function(s)
        s.volume_osd =
            awful.popup(
            {
                type = 'notification',
                screen = s,
                height = volume_osd_height,
                width = volume_osd_width,
                maximum_height = volume_osd_height,
                maximum_width = volume_osd_width,
                bg = beautiful.transparent,
                ontop = true,
                visible = false,
                widget = {
                    {
                        {
                            layout = wibox.layout.fixed.vertical,
                            {
                                {
                                    layout = wibox.layout.align.horizontal,
                                    expand = 'none',
                                    nil,
                                    volume_osd_icon,
                                    nil
                                },
                                volume_osd_bar,
                                spacing = dpi(10),
                                layout = wibox.layout.fixed.vertical
                            }
                        },
                        left = dpi(25),
                        right = dpi(25),
                        bottom = dpi(30),
                        widget = wibox.container.margin
                    },
                    bg = colors.alpha(colors.black, '88'),
                    border_width = dpi(2),
                    border_color = colors.alpha(colors.colorA, 'aa'),
                    shape = beautiful.client_shape_rounded_xl,
                    widget = wibox.container.background
                }
            }
        )

        awful.placement.centered(
            s.volume_osd,
            {
                offset = {
                    y = 300
                }
            }
        )

        local volume_osd_timeout =
            gears.timer(
            {
                timeout = 2,
                autostart = true,
                callback = function()
                    s.volume_osd.visible = false
                end
            }
        )

        local function toggle_volume_osd()
            if s.volume_osd.visible then
                volume_osd_timeout:again()
            else
                s.volume_osd.visible = true
                volume_osd_timeout:start()
            end
        end

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
    end
)
