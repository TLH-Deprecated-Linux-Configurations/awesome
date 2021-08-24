--require('ui.bar.pillbar')
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

local dpi = beautiful.xresources.apply_dpi

local task_list = require('ui.bar.widgets.tasklist')
local tag_list = require('ui.bar.widgets.pacman_taglist')
local hardware = require('lib.hardware')
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
            height = dpi(38), -- 48
            width = s.geometry.width - offsetx,
            x = s.geometry.x + offsetx,
            y = s.geometry.y,
            stretch = false,
            bg = {
                type = 'linear',
                from = {0, 0},
                to = {15, 15},
                stops = {
                    {0, beautiful.xbackground .. '33'},
                    {0.45, beautiful.xcolor18 .. '66'},
                    {0.85, beautiful.xbackground .. '66'},
                    {1, beautiful.xcolor18 .. '33'}
                }
            },
            fg = beautiful.fg_normal,
            struts = {
                bottom = dpi(38)
            }
        }
    )
    panel:struts {bottom = dpi(48)}

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
                border_color = beautiful.xcolor0 .. '33',
                bg = beautiful.bg_normal .. '22',
                shape = beautiful.btn_lg_shape,
                widget = wibox.container.background
            },
            top = dpi(2),
            bottom = dpi(2),
            widget = wibox.container.margin
        }
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    s.systray =
        wibox.widget {
        {
            base_size = dpi(40),
            horizontal = true,
            screen = s,
            widget = wibox.widget.systray,
            bg = beautiful.bg_normal .. '22'
        },
        visible = true,
        bottom = dpi(0),
        widget = wibox.container.margin,
        bg = beautiful.bg_normal .. '22'
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    s.control_center_toggle = build_widget(require('ui.bar.widgets.start-launcher'))
    -- s.bluetooth = build_widget(show_widget_or_default('widget.bluetooth', hardware.hasBluetooth()))
    -- s.network = build_widget(show_widget_or_default('widget.wifi', hardware.hasWifi()))
    local layout_box = build_widget(require('ui.bar.widgets.layoutbox')(s))
    local battery = build_widget(require 'ui.bar.widgets.battery_widget')
    s.mytextclock = build_widget(require('ui.bar.widgets.time_widget'))
    s.mydatewidget = build_widget(require 'ui.bar.widgets.date_widget')
    --local dropbox = build_widget(require 'ui.widgets.dropbox.dropbox')
    --  s.notification_center = build_widget(require('layout.right-panel'))
    -- s.screen_record = build_widget(require("widget.screen-record"))
    -- ########################################################################
    -- ### Setup Panel Widgets ################################################
    -- ########################################################################
    panel:setup {
        {
            layout = wibox.layout.align.horizontal,
            expand = false,
            position = 'bottom',
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = dpi(2),
                s.control_center_toggle,
                tag_list(s),
                left = dpi(5),
                right = dpi(5),
                widget = wibox.container.margin
            },
            task_list(s),
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = dpi(2),
                {s.systray, margins = dpi(0), widget = wibox.container.margin},
                -- s.network,
                -- s.bluetooth,
                --s.screen_record,
                battery,
                layout_box,
                --   s.screen_recorder,
                s.mytextclock,
                s.mydatewidget
                --   s.notification_center

                -- clock,
            }
        },
        left = dpi(10),
        right = dpi(10),
        widget = wibox.container.margin
    }
    -- ########################################################################
    -- ### Provide the Trigger for the Bottom #################################
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
