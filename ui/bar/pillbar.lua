--            __ __
-- .--.--.--.|__|  |--.---.-.----.
-- |  |  |  ||  |  _  |  _  |   _|
-- |________||__|_____|___._|__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Wibar (top bar)
local awful = require('awful')
local gears = require('gears')
local gfs = require('gears.filesystem')
local wibox = require('wibox')
local beautiful = require('beautiful')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi
local helpers = require('helpers')

local systray_margin = (beautiful.wibar_height - beautiful.systray_icon_size) / 2

-- ########################################################################
-- ########################################################################
-- ########################################################################

local icon1 =
    wibox.widget {
    widget = wibox.widget.imagebox,
    image = beautiful.distro_logo,
    resize = true
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local awesome_icon =
    wibox.widget {
    {
        icon1,
        top = dpi(2),
        bottom = dpi(2),
        left = dpi(4),
        right = dpi(2),
        widget = wibox.container.margin
    },
    widget = wibox.container.background
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
awesome_icon:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            function()
                awesome.emit_signal('widgets::start::toggle', mouse.screen)
            end
        )
    )
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Battery Bar Widget

local battery_text =
    wibox.widget {
    font = beautiful.font,
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local battery_icon =
    wibox.widget {
    font = beautiful.icon_font_name .. '18',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local battery_pill =
    wibox.widget {
    {
        {battery_icon, top = dpi(1), widget = wibox.container.margin},
        helpers.horizontal_pad(10),
        {battery_text, top = dpi(1), widget = wibox.container.margin},
        layout = wibox.layout.fixed.horizontal
    },
    left = dpi(10),
    right = dpi(10),
    widget = wibox.container.margin
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
awesome.connect_signal(
    'signal::battery',
    function(percentage, state)
        local value = percentage

        local bat_icon = ''

        if value >= 90 and value <= 100 then
            bat_icon = ''
        elseif value >= 70 and value < 90 then
            bat_icon = ''
        elseif value >= 60 and value < 70 then
            bat_icon = ''
        elseif value >= 50 and value < 60 then
            bat_icon = ''
        elseif value >= 30 and value < 50 then
            bat_icon = ''
        elseif value >= 15 and value < 30 then
            bat_icon = ''
        else
            bat_icon = ''
        end
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- if charging
        if state == 1 then
            bat_icon = ''
        end

        -- if full
        if state == 4 then
            bat_icon = ''
        end

        battery_icon.markup = "<span foreground='" .. beautiful.xcolor12 .. "'>" .. bat_icon .. '</span>'
        battery_text.markup =
            "<span foreground='" .. beautiful.xcolor12 .. "'>" .. string.format('%1d', value) .. '%' .. '</span>'
    end
)
local date_pill = require('ui.bar.date_widget')
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Time Widget -----

local time_text =
    wibox.widget {
    font = beautiful.font,
    format = '%l:%M %P',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textclock
}

time_text.markup = "<span foreground='" .. beautiful.xcolor5 .. "'>" .. time_text.text .. '</span>'

time_text:connect_signal(
    'widget::redraw_needed',
    function()
        time_text.markup = "<span foreground='" .. beautiful.xcolor5 .. "'>" .. time_text.text .. '</span>'
    end
)

local time_icon =
    wibox.widget {
    font = beautiful.icon_font_name .. '18',
    markup = "<span foreground='" .. beautiful.xcolor5 .. "'></span>",
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local time_pill =
    wibox.widget {
    {
        {time_icon, top = dpi(1), widget = wibox.container.margin},
        helpers.horizontal_pad(10),
        {time_text, top = dpi(1), widget = wibox.container.margin},
        layout = wibox.layout.fixed.horizontal
    },
    left = dpi(10),
    right = dpi(10),
    widget = wibox.container.margin
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Systray Widget --

local mysystray = wibox.widget.systray()
--mysystray:set_base_size(beautiful.systray_icon_size)

local mysystray_container = {
    mysystray,
    left = dpi(4),
    right = dpi(4),
    top = dpi(2),
    bottom = dpi(2),
    widget = wibox.container.margin,
    bg = beautiful.xbackground .. '00'
}

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Playerctl Bar Widget -------------------------------------------------------

-- Title Widget
local song_title =
    wibox.widget {
    markup = 'Nothing Playing',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local song_artist =
    wibox.widget {
    markup = 'nothing playing',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local song_logo =
    wibox.widget {
    markup = '<span foreground="' .. beautiful.xcolor6 .. '"> </span>',
    font = beautiful.icon_font_name .. 12,
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local playerctl_bar =
    wibox.widget {
    {
        {
            song_logo,
            top = dpi(3),
            left = dpi(3),
            right = dpi(0),
            bottom = dpi(1),
            widget = wibox.container.margin
        },
        {
            {
                song_title,
                expand = 'outside',
                layout = wibox.layout.align.vertical
            },
            top = dpi(1),
            left = dpi(10),
            right = dpi(10),
            widget = wibox.container.margin
        },
        {
            {
                song_artist,
                expand = 'outside',
                layout = wibox.layout.align.vertical
            },
            top = dpi(1),
            left = dpi(10),
            widget = wibox.container.margin
        },
        spacing = 1,
        spacing_widget = {
            shape = gears.shape.powerline,
            widget = wibox.container.background
        },
        layout = wibox.layout.fixed.horizontal
    },
    left = dpi(10),
    right = dpi(13),
    widget = wibox.container.margin
}

playerctl_bar.visible = false

awesome.connect_signal(
    'bling::playerctl::no_players',
    function()
        playerctl_bar.visible = false
    end
)

-- Get Title
awesome.connect_signal(
    'bling::playerctl::title_artist_album',
    function(title, artist, _)
        playerctl_bar.visible = true
        song_title.markup = '<span foreground="' .. beautiful.xcolor5 .. '">' .. title .. '</span>'

        song_artist.markup = '<span foreground="' .. beautiful.xcolor4 .. '">' .. artist .. '</span>'
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Create the Wibar

local final_systray =
    wibox.widget {
    {
        mysystray_container,
        top = dpi(0),
        left = dpi(3),
        right = dpi(3),
        bottom = dpi(0),
        layout = wibox.container.margin
    },
    bg = beautiful.xcolor0,
    shape = helpers.rrect(10),
    widget = wibox.container.background
}

local wrap_widget = function(w)
    local wrapped =
        wibox.widget {
        w,
        top = dpi(0),
        left = dpi(4),
        bottom = dpi(0),
        right = dpi(4),
        widget = wibox.container.margin,
        bg = beautiful.xbackground .. '66'
    }
    return wrapped
end

local make_pill = function(w, c)
    local pill =
        wibox.widget {
        w,
        bg = beautiful.xbackground .. '66',
        shape = helpers.rrect(10),
        widget = wibox.container.background
    }
    return pill
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
screen.connect_signal(
    'request::desktop_decoration',
    function(s)
        -- Create a promptbox for each screen
        s.mypromptbox = awful.widget.prompt()

        -- Create layoutbox widget
        s.mylayoutbox = awful.widget.layoutbox(s)

        -- Create the wibox
        s.mywibox =
            awful.wibar(
            {
                position = 'bottom',
                screen = s,
                type = 'dock',
                ontop = true
            }
        )
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Remove wibar on full screen
        local function remove_wibar(c)
            if c.fullscreen or c.maximized then
                c.screen.mywibox.visible = false
            else
                c.screen.mywibox.visible = true
            end
        end

        -- Remove wibar on full screen
        local function add_wibar(c)
            if c.fullscreen or c.maximized then
                c.screen.mywibox.visible = true
            end
        end
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Hide bar when a splash widget is visible
        awesome.connect_signal(
            'widgets::splash::visibility',
            function(vis)
                screen.primary.mywibox.visible = not vis
            end
        )

        client.connect_signal('property::fullscreen', remove_wibar)

        client.connect_signal('request::unmanage', add_wibar)

        -- Create the taglist widget
        s.mytaglist = require('ui.bar.pacman_taglist')(s)

        -- Create a tasklist widget
        local tasklist = require('ui.bar.tasklist')
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Add widgets to the wibox
        s.mywibox:setup {
            layout = wibox.layout.align.vertical,
            nil,
            {
                {
                    layout = wibox.layout.align.horizontal,
                    expand = 'none',
                    {
                        layout = wibox.layout.align.horizontal,
                        helpers.horizontal_pad(4),
                        -- function to add padding
                        wrap_widget( --
                            -- function to add pill
                            make_pill(
                                {
                                    awesome_icon,
                                    {
                                        s.mytaglist,
                                        helpers.horizontal_pad(4),
                                        layout = wibox.layout.fixed.horizontal
                                    },
                                    layout = wibox.layout.fixed.horizontal
                                }
                            )
                        ),
                        s.mypromptbox,
                        wrap_widget(make_pill(playerctl_bar, beautiful.xcolor0 .. '55'))
                    },
                    tasklist(s),
                    {
                        wrap_widget(make_pill(time_pill, beautiful.xcolor0 .. '55')),
                        wrap_widget(make_pill(date_pill, beautiful.xcolor0 .. '55')),
                        wrap_widget(make_pill(battery_pill, beautiful.xcolor0 .. '55')),
                        wrap_widget(
                            make_pill(
                                {
                                    s.mylayoutbox,
                                    top = dpi(5),
                                    bottom = dpi(5),
                                    right = dpi(8),
                                    left = dpi(8),
                                    widget = wibox.container.margin
                                }
                            )
                        ),
                        wrap_widget(awful.widget.only_on_screen(final_systray, screen[1])),
                        helpers.horizontal_pad(4),
                        layout = wibox.layout.fixed.horizontal
                    }
                },
                widget = wibox.container.margin,
                bg = beautiful.wibar_bg_secondary
            }
        }
    end
)

-- EOF -------------
