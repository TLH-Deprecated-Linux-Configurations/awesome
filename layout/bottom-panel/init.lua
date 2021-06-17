--  ______         __   __                       ______                     __
-- |   __ \.-----.|  |_|  |_.-----.--------.    |   __ \.---.-.-----.-----.|  |
-- |   __ <|  _  ||   _|   _|  _  |        |    |    __/|  _  |     |  -__||  |
-- |______/|_____||____|____|_____|__|__|__|    |___|   |___._|__|__|_____||__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require('gears')

local dpi = beautiful.xresources.apply_dpi

local task_list = require('widget.task-list')
local tag_list = require('widget.tag-list')
local hardware = require('lib.hardware-check')
-- ########################################################################
-- ########################################################################
-- ########################################################################
local bottom_panel = function(s)
    local function show_widget_or_default(widget, show, require_is_function)
        if show and require_is_function then
            return require(widget)()
        elseif show then
            return require(widget)
        end
        return wibox.widget.base.empty_widget()
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local offsetx = 0
    local panel =
        awful.wibar(
        {
            ontop = true,
            screen = s,
            position = 'bottom',
            height = dpi(42), -- 48
            width = s.geometry.width - offsetx,
            x = s.geometry.x + offsetx,
            y = s.geometry.y,
            stretch = false,
            bg = beautiful.bg_normal .. '88',
            fg = beautiful.fg_normal,
            struts = {
                bottom = dpi(42) -- 48
            }
        }
    )
    panel:struts {bottom = dpi(42)}

    panel:connect_signal(
        'mouse::enter',
        function()
            local w = mouse.current_wibox
            if w then
                w.cursor = 'left_ptr'
            end
        end
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local build_widget = function(widget)
        return wibox.widget {
            {
                widget,
                border_width = dpi(3),
                border_color = beautiful.xcolor0,
                bg = beautiful.bg_normal .. '99',
                shape = function(cr, w, h)
                    gears.shape.rounded_rect(cr, w, h, dpi(3))
                end,
                widget = wibox.container.background
            },
            top = dpi(1),
            bottom = dpi(0),
            widget = wibox.container.margin
        }
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    s.systray =
        wibox.widget {
        {
            base_size = dpi(20),
            horizontal = true,
            screen = s,
            widget = wibox.widget.systray
        },
        visible = false,
        bottom = dpi(10),
        widget = wibox.container.margin
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    s.control_center_toggle = build_widget(require('layout.left-panel'))

    s.screen_rec = build_widget(require('widget.screen-recorder')())
    s.bluetooth = build_widget(show_widget_or_default('widget.bluetooth', hardware.hasBluetooth()))
    s.network = build_widget(show_widget_or_default('widget.wifi', hardware.hasWifi()))
    local layout_box = build_widget(require('widget.layoutbox')(s))
    s.battery = build_widget(show_widget_or_default('widget.battery', hardware.hasBattery(), true))
    s.notification_center = build_widget(require('layout.right-panel'))
    s.about = build_widget(require('widget.about'))
    s.mytextclock = build_widget(require('widget.clock'))
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    panel:setup {
        {
            layout = wibox.layout.align.horizontal,
            expand = 'none',
            position = 'bottom',
            {
                layout = wibox.layout.align.horizontal,
                spacing = dpi(2),
                s.control_center_toggle,
                tag_list(s),
                task_list(s)
            },
            nil,
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = dpi(2),
                {s.systray, margins = dpi(2), widget = wibox.container.margin},
                s.about,
                s.screen_rec,
                s.network,
                s.bluetooth,
                s.battery,
                layout_box,
                s.mytextclock,
                s.notification_center

                -- clock,
            }
        },
        left = dpi(5),
        right = dpi(5),
        widget = wibox.container.margin
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################

    -- Invisible trigger that enables the bottom_panel
    local panel_trigger =
        awful.wibar(
        {
            screen = s,
            position = 'bottom',
            height = dpi(1),
            ontop = true,
            width = s.geometry.width,
            bg = '#00000000',
            visible = true
        }
    )

    -- Show panel and hide trigger
    panel_trigger:connect_signal(
        'mouse::enter',
        function()
            panel.visible = true
            panel_trigger.visible = false
        end
    )
    -- Hide panel and show trigger
    panel:connect_signal(
        'mouse::leave',
        function()
            panel.visible = false
            panel_trigger.visible = true
        end
    )

    -- hide panel when client is fullscreen
    local function change_panel_visibility(client)
        if client.screen == s then
            panel.ontop = not client.fullscreen
        end
    end

    -- connect panel visibility function to relevant signals
    client.connect_signal('property::fullscreen', change_panel_visibility)
    client.connect_signal('focus', change_panel_visibility)
    return panel
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
return bottom_panel
