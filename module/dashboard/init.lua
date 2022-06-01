--  ______               __               __
-- |      |.-----.-----.|  |_.----.-----.|  |
-- |   ---||  _  |     ||   _|   _|  _  ||  |
-- |______||_____|__|__||____|__| |_____||__|
--  ______               __
-- |      |.-----.-----.|  |_.-----.----.
-- |   ---||  -__|     ||   _|  -__|   _|
-- |______||_____|__|__||____|_____|__|

-- ------------------------------------------------- --
-- Standard awesome library
local gears = require('gears')
local awful = require('awful')

-- Theme handling library
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi

-- Widget library
local wibox = require('wibox')

-- rubato

-- Get screen geometry
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height

-- control_center
------------

-- Helpers
local function centered_widget(widget)
    local w =
        wibox.widget {
        nil,
        {
            nil,
            widget,
            expand = 'none',
            layout = wibox.layout.align.vertical
        },
        expand = 'none',
        layout = wibox.layout.align.horizontal
    }

    return w
end

local function create_boxed_widget(widget_to_be_boxed, width, height, bg_color)
    local box_container = wibox.container.background()
    box_container.bg = bg_color
    box_container.forced_height = height
    box_container.forced_width = width
    box_container.shape = beautiful.client_shape_rounded

    local boxed_widget =
        wibox.widget {
        -- Add margins
        {
            -- Add background color
            {
                -- The actual widget goes here
                widget_to_be_boxed,
                top = dpi(9),
                bottom = dpi(9),
                left = dpi(10),
                right = dpi(10),
                widget = wibox.container.margin
            },
            widget = box_container
        },
        margins = dpi(10),
        color = '#00000000',
        widget = wibox.container.margin
    }

    return boxed_widget
end

-- Widget

local time = require('widget.dashboard.time')
local date = require('widget.dashboard.date')
local uptime = require('widget.dashboard.uptime')
local stats = require('widget.dashboard.dials')
local notifs = require('widget.dashboard.notifs')
local battery = require('widget.dashboard.battery')
local sliders = require('widget.dashboard.sliders')
local buttons = require('widget.dashboard.buttons')
local bluetooth = require('widget.dashboard.bluetooth.')
local end_session = require('widget.dashboard.end-session')
local network = require('widget.dashboard.network')
local fortune = require('widget.dashboard.fortune')
local calendar = require('widget.dashboard.calendar')

local urls = require('widget.dashboard.urls')

local url_boxed = create_boxed_widget(urls, dpi(500), dpi(300), '#00000000')

local fortune_boxed = create_boxed_widget(fortune, dpi(450), dpi(300), beautiful.bg_normal)
local network_boxed = create_boxed_widget(network, dpi(450), dpi(650), beautiful.bg_normal)
local end_session_boxed = create_boxed_widget(end_session, dpi(200), dpi(120), beautiful.bg_normal)
local buttons_boxed = create_boxed_widget(buttons, dpi(450), dpi(300), '#00000000')

local sliders_boxed = create_boxed_widget(sliders, dpi(450), dpi(275), beautiful.bg_normal)
local bluetooth_boxed = create_boxed_widget(bluetooth, dpi(450), dpi(350), beautiful.bg_normal)
local time_boxed = create_boxed_widget(centered_widget(time), dpi(250), dpi(120), beautiful.bg_normal)
local date_boxed = create_boxed_widget(centered_widget(date), dpi(200), dpi(120), beautiful.bg_normal)
local battery_boxed = create_boxed_widget(battery, dpi(250), dpi(120), beautiful.bg_normal)
local stats_boxed = create_boxed_widget(stats, dpi(450), dpi(350), beautiful.bg_normal)
local notifs_boxed = create_boxed_widget(notifs, dpi(450), dpi(400), beautiful.bg_normal)
local uptime_boxed = create_boxed_widget(centered_widget(uptime), dpi(250), dpi(145), beautiful.bg_normal)
local calendar_boxed = create_boxed_widget(calendar, dpi(450), dpi(430), beautiful.bg_normal)
-- Dashboard
control_center =
    wibox(
    {
        type = 'splash',
        screen = mouse.screen,
        height = screen_height,
        width = screen_width,
        ontop = true,
        visible = false,
        bg = colors.alpha(colors.blacker, 'aa')
    }
)

awful.placement.centered(control_center)

control_center:buttons(
    gears.table.join(
        -- Middle click - Hide control_center
        awful.button(
            {},
            2,
            function()
                control_center_hide()
            end
        )
    )
)

local slide =
    rubato.timed {
    pos = dpi(-1080),
    rate = 60,
    intro = 0.215,
    duration = 0.84,
    easing = rubato.bouncy,
    awestore_compat = true,
    subscribed = function(pos)
        control_center.y = pos
    end
}

local slide_strut =
    rubato.timed {
    pos = dpi(0),
    rate = 60,
    intro = 0.21,
    duration = 0.63,
    easing = rubato.quadratic,
    awestore_compat = true,
    subscribed = function(height)
        control_center:struts {left = 0, right = 0, top = height, bottom = 0}
    end
}

local control_center_status = false

slide.ended:subscribe(
    function()
        if control_center_status then
            control_center.visible = false
        end
    end
)

control_center_show = function()
    awesome.emit_signal('bluetooth::power:refresh')
    awesome.emit_signal('bluetooth::devices:refreshPanel')
    awesome.emit_signal('network::networks:refreshPanel')
    control_center.visible = true
    slide:set(0)
    slide_strut:set(1080)
    control_center_status = false
end

control_center_hide = function()
    slide:set(-1080)
    slide_strut:set(0)
    control_center_status = true
end

control_center_toggle = function()
    if control_center.visible then
        control_center_hide()
    else
        control_center_show()
    end
end

control_center:setup {
    {
        {
            widget = wibox.container.margin,
            layout = wibox.layout.fixed.vertical,
            network_boxed,
            fortune_boxed
        },
        -- ------------------------------------------------- --
        {
            {
                {
                    sliders_boxed,
                    bluetooth_boxed,
                    notifs_boxed,
                    layout = wibox.layout.fixed.vertical
                },
                {
                    url_boxed,
                    stats_boxed,
                    buttons_boxed,
                    layout = wibox.layout.fixed.vertical
                },
                {
                    layout = wibox.layout.fixed.vertical,
                    {
                        battery_boxed,
                        end_session_boxed,
                        layout = wibox.layout.fixed.horizontal
                    },
                    uptime_boxed,
                    {
                        time_boxed,
                        date_boxed,
                        layout = wibox.layout.fixed.horizontal
                    },
                    calendar_boxed
                },
                layout = wibox.layout.fixed.horizontal
            },
            {
                layout = wibox.layout.fixed.vertical
            },
            layout = wibox.layout.fixed.vertical
        },
        expand = 'none',
        layout = wibox.layout.fixed.horizontal
    },
    margins = dpi(10),
    widget = wibox.container.margin
}
