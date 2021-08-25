--            __ __
-- .--.--.--.|__|  |--.---.-.----.
-- |  |  |  ||  |  _  |  _  |   _|
-- |________||__|_____|___._|__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Wibar (top bar)

local gears = require 'gears'
local gfs = require 'gears.filesystem'
local wibox = require 'wibox'
local beautiful = require 'beautiful'
local xresources = require 'beautiful.xresources'
local dpi = xresources.apply_dpi
local helpers = require 'helpers'

local systray_margin = (beautiful.wibar_height - beautiful.systray_icon_size) / 2

-- ########################################################################
-- ########################################################################
-- ########################################################################

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Battery Bar Widget

local date_pill = require 'ui.bar.widgets.date_widget'
local time_pill = require 'ui.bar.widgets.time_widget'
local battery_pill = require 'ui.bar.widgets.battery_widget'
local systray_margin = (beautiful.wibar_height - beautiful.systray_icon_size) / 2
local hardware = require 'lib.hardware'
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
    widget = wibox.container.margin
}

local final_systray =
    wibox.widget {
    {
        mysystray_container,
        top = dpi(10),
        left = dpi(13),
        right = dpi(13),
        bottom = dpi(10),
        layout = wibox.container.margin
    },
    shape = helpers.rrect(10),
    widget = wibox.container.background
}

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Create the Wibar
--

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
        bg = beautiful.xbackground .. '44',
        border_color = beautiful.xcolor7 .. '88',
        border_width = dpi(1),
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
        function show_widget_or_default(widget, show, require_is_function)
            if show and require_is_function then
                return require(widget)()
            elseif show then
                return require(widget)
            end
            return wibox.widget.base.empty_widget()
        end
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
        s.mytaglist = require('ui.bar.widgets.pacman_taglist')(s)
        awesome_icon = require 'ui.bar.awesome_icon'
        dropbox = require 'ui.widgets.dropbox.dropbox'
        -- Create a tasklist widget
        local tasklist = require('ui.bar.widgets.tasklist')
        local separator = require('ui.bar.widgets.separator')
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
                                        helpers.horizontal_pad(2),
                                        layout = wibox.layout.fixed.horizontal
                                    },
                                    layout = wibox.layout.fixed.horizontal
                                }
                            )
                        )
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
                        wrap_widget(make_pill(dropbox, beautiful.xcolor0 .. '88')),
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
