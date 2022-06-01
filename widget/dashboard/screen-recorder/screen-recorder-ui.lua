--  _______
-- |     __|.----.----.-----.-----.-----.
-- |__     ||  __|   _|  -__|  -__|     |
-- |_______||____|__| |_____|_____|__|__|
--  ______                           __
-- |   __ \.-----.----.-----.----.--|  |.-----.----.
-- |      <|  -__|  __|  _  |   _|  _  ||  -__|   _|
-- |___|__||_____|____|_____|__| |_____||_____|__|
--  _______ _______
-- |   |   |_     _|
-- |   |   |_|   |_
-- |_______|_______|
-- ------------------------------------------------- --
local config_dir = gears.filesystem.get_configuration_dir()
local widget_icon_dir = config_dir .. 'widget/dashboard/screen-recorder/icons/'
local record_tbl = {}
-- ------------------------------------------------- --
-- Panel UI
--
record_tbl.screen_rec_toggle_imgbox =
    wibox.widget {
    image = widget_icon_dir .. 'start-recording-button' .. '.svg',
    resize = true,
    widget = wibox.widget.imagebox
}
-- ------------------------------------------------- --
record_tbl.screen_rec_toggle_button =
    wibox.widget {
    {
        record_tbl.screen_rec_toggle_imgbox,
        margins = dpi(7),
        widget = wibox.container.margin
    },
    widget = clickable_container
}
-- ------------------------------------------------- --
record_tbl.screen_rec_countdown_txt =
    wibox.widget {
    id = 'countdown_text',
    font = 'SF Pro Rounded Heavy    64',
    text = '4',
    align = 'center',
    valign = 'bottom',
    opacity = 0.0,
    widget = wibox.widget.textbox
}
-- ------------------------------------------------- --
record_tbl.screen_rec_main_imgbox =
    wibox.widget {
    image = widget_icon_dir .. 'recorder-off' .. '.svg',
    resize = true,
    widget = wibox.widget.imagebox
}
-- ------------------------------------------------- --
record_tbl.screen_rec_main_button =
    wibox.widget {
    {
        {
            {
                record_tbl.screen_rec_main_imgbox,
                margins = dpi(24),
                widget = wibox.container.margin
            },
            widget = clickable_container
        },
        forced_width = dpi(200),
        forced_height = dpi(200),
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, 6)
        end,
        widget = wibox.container.background
    },
    margins = dpi(24),
    widget = wibox.container.margin
}
-- ------------------------------------------------- --
record_tbl.screen_rec_audio_imgbox =
    wibox.widget {
    image = widget_icon_dir .. 'audio' .. '.svg',
    resize = true,
    widget = wibox.widget.imagebox
}
-- ------------------------------------------------- --
record_tbl.screen_rec_audio_button =
    wibox.widget {
    {
        nil,
        {
            {
                record_tbl.screen_rec_audio_imgbox,
                margins = dpi(16),
                widget = wibox.container.margin
            },
            widget = clickable_container
        },
        nil,
        expand = 'none',
        layout = wibox.layout.align.vertical,
        bg = beautiful.transparent
    },
    forced_width = dpi(60),
    forced_height = dpi(60),
    bg = beautiful.transparent,
    shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 6)
    end,
    widget = wibox.container.background
}
-- ------------------------------------------------- --
record_tbl.screen_rec_close_imgbox =
    wibox.widget {
    image = widget_icon_dir .. 'close-screen' .. '.svg',
    resize = true,
    widget = wibox.widget.imagebox
}
-- ------------------------------------------------- --
record_tbl.screen_rec_close_button =
    wibox.widget {
    {
        nil,
        {
            {
                record_tbl.screen_rec_close_imgbox,
                margins = dpi(16),
                widget = wibox.container.margin
            },
            widget = clickable_container
        },
        nil,
        expand = 'none',
        layout = wibox.layout.align.horizontal
    },
    forced_width = dpi(60),
    forced_height = dpi(60),
    shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 6)
    end,
    widget = wibox.container.background
}
-- ------------------------------------------------- --
record_tbl.screen_rec_settings_imgbox =
    wibox.widget {
    image = widget_icon_dir .. 'settings' .. '.svg',
    resize = true,
    widget = wibox.widget.imagebox
}
-- ------------------------------------------------- --
record_tbl.screen_rec_settings_button =
    wibox.widget {
    {
        nil,
        {
            {
                record_tbl.screen_rec_settings_imgbox,
                margins = dpi(16),
                widget = wibox.container.margin
            },
            widget = clickable_container
        },
        nil,
        expand = 'none',
        layout = wibox.layout.align.vertical
    },
    forced_width = dpi(60),
    forced_height = dpi(60),
    shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 6)
    end,
    widget = wibox.container.background
}
-- ------------------------------------------------- --
record_tbl.screen_rec_back_imgbox =
    wibox.widget {
    image = widget_icon_dir .. 'back' .. '.svg',
    resize = true,
    widget = wibox.widget.imagebox
}
-- ------------------------------------------------- --
record_tbl.screen_rec_back_button =
    wibox.widget {
    {
        nil,
        {
            {
                record_tbl.screen_rec_back_imgbox,
                margins = dpi(16),
                widget = wibox.container.margin
            },
            widget = clickable_container
        },
        nil,
        expand = 'none',
        layout = wibox.layout.align.vertical
    },
    forced_width = dpi(48),
    forced_height = dpi(48),
    shape = beautiful.client_shape_rounded,
    widget = wibox.container.background
}
-- ------------------------------------------------- --
record_tbl.screen_rec_back_txt =
    wibox.widget {
    {
        text = 'Back',
        font = 'SF Pro Rounded Heavy    16',
        align = 'left',
        valign = 'center',
        widget = wibox.widget.textbox
    },
    margins = dpi(5),
    widget = wibox.container.margin
}
-- ------------------------------------------------- --
record_tbl.screen_rec_res_txt =
    wibox.widget {
    {
        text = 'Resolution',
        font = 'SF Pro Rounded Heavy    16',
        align = 'left',
        valign = 'center',
        widget = wibox.widget.textbox
    },
    margins = dpi(5),
    widget = wibox.container.margin
}
-- ------------------------------------------------- --
record_tbl.screen_rec_res_txtbox =
    wibox.widget {
    {
        {
            {
                id = 'res_tbox',
                markup = '<span foreground="#FFFFFF66">' .. '1366x768' .. '</span>',
                font = 'SF Pro Rounded Heavy    16',
                align = 'left',
                valign = 'center',
                widget = wibox.widget.textbox
            },
            margins = dpi(5),
            widget = wibox.container.margin
        },
        widget = clickable_container
    },
    forced_width = dpi(60),
    forced_height = dpi(60),
    shape = beautiful.client_shape_rounded,
    widget = wibox.container.background
}
-- ------------------------------------------------- --
record_tbl.screen_rec_offset_txt =
    wibox.widget {
    {
        text = 'Offset',
        font = 'SF Pro Rounded Heavy    16',
        align = 'left',
        valign = 'center',
        widget = wibox.widget.textbox
    },
    margins = dpi(5),
    widget = wibox.container.margin
}
-- ------------------------------------------------- --
record_tbl.screen_rec_offset_txtbox =
    wibox.widget {
    {
        {
            {
                id = 'offset_tbox',
                markup = '<span foreground="#FFFFFF66">' .. '0,0' .. '</span>',
                font = 'SF Pro Rounded Heavy    16',
                ellipsize = 'start',
                align = 'left',
                valign = 'center',
                widget = wibox.widget.textbox
            },
            margins = dpi(5),
            widget = wibox.container.margin
        },
        widget = clickable_container
    },
    forced_width = dpi(60),
    forced_height = dpi(60),
    shape = beautiful.client_shape_rounded,
    widget = wibox.container.background
}
-- ------------------------------------------------- --
screen.connect_signal(
    'request::desktop_decoration',
    function(s)
        s.recorder_screen =
            wibox(
            {
                ontop = true,
                screen = s,
                type = 'dock',
                height = s.geometry.height,
                width = s.geometry.width,
                x = s.geometry.x,
                y = s.geometry.y,
                bg = beautiful.background,
                fg = '#f4f4f7'
            }
        )
        -- ------------------------------------------------- --
        -- ------------------------------------------------- --
        -- ------------------------------------------------- --
        s.recorder_screen:setup {
            layout = wibox.layout.stack,
            {
                id = 'recorder_panel',
                visible = true,
                layout = wibox.layout.align.vertical,
                expand = 'none',
                nil,
                {
                    layout = wibox.layout.align.horizontal,
                    expand = 'none',
                    nil,
                    {
                        layout = wibox.layout.fixed.vertical,
                        record_tbl.screen_rec_countdown_txt,
                        {
                            layout = wibox.layout.align.horizontal,
                            record_tbl.screen_rec_settings_button,
                            record_tbl.screen_rec_main_button,
                            record_tbl.screen_rec_audio_button
                        },
                        record_tbl.screen_rec_close_button
                    },
                    nil
                },
                nil
            },
            {
                id = 'recorder_settings',
                visible = false,
                layout = wibox.layout.align.vertical,
                expand = 'none',
                nil,
                {
                    layout = wibox.layout.align.horizontal,
                    expand = 'none',
                    nil,
                    {
                        layout = wibox.layout.fixed.vertical,
                        forced_width = dpi(240),
                        spacing = dpi(10),
                        {
                            layout = wibox.layout.fixed.horizontal,
                            spacing = dpi(10),
                            record_tbl.screen_rec_back_button,
                            record_tbl.screen_rec_back_txt
                        },
                        record_tbl.screen_rec_res_txt,
                        record_tbl.screen_rec_res_txtbox,
                        record_tbl.screen_rec_offset_txt,
                        record_tbl.screen_rec_offset_txtbox
                    },
                    nil
                },
                nil
            }
        }
    end
)
-- ------------------------------------------------- --
return record_tbl
