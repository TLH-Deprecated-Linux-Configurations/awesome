local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')

local dpi = require('beautiful').xresources.apply_dpi
local clickable_container = require('widget.material.clickable-container')
local signals = require('module.signals')
local animate = require('lib.animations').createAnimObject
local seperator_widget = require('lib.separator')

local keyconfig = require('configuration.keys.mod')
local modKey = keyconfig.modKey

local scrollbox = require('lib.scrollbox')

-- load the notification plugins
local plugins = require('lib.plugin-loader')('notification')

local get_screen = require('lib.function.common').focused_screen

-- body gets populated with a scrollbox widget once generated
local body = {}

local function notification_plugin()
    local separator = seperator_widget(16, 'vertical', 0)

    local table_widget =
        wibox.widget {
        separator,
        layout = wibox.layout.fixed.vertical
    }

    local table =
        wibox.widget {
        visible = false,
        layout = wibox.layout.fixed.vertical,
        table_widget
    }

    for _, value in ipairs(plugins) do
        table_widget:add(
            {
                wibox.container.margin(value, dpi(15), dpi(15), dpi(0), dpi(10)),
                layout = wibox.layout.fixed.vertical
            }
        )
    end
    return table
end

local right_panel = function()
    local panel_width = dpi(350)

    local s = get_screen()

    local backdrop =
        wibox {
        ontop = true,
        screen = s,
        bg = '#00000000',
        type = 'dock',
        x = s.geometry.x,
        y = s.geometry.y,
        width = s.geometry.width,
        height = s.geometry.height
    }

    local function update_backdrop_location()
        backdrop.x = s.geometry.x
        backdrop.y = s.geometry.y
        backdrop.width = s.geometry.width
        backdrop.height = s.geometry.height
    end

    local panel =
        wibox {
        ontop = true,
        screen = s,
        width = panel_width,
        height = s.geometry.height,
        x = s.geometry.x + (s.geometry.width - panel_width),
        bg = beautiful.bg_normal .. '88',
        fg = beautiful.fg_normal
    }

    signals.connect_background_theme_changed(
        function()
            panel.bg = beautiful.bg_modal .. beautiful.background_transparency
        end
    )

    screen.connect_signal(
        'removed',
        function(removed)
            if s == removed then
                s = get_screen()
            end
        end
    )

    -- this is called when we need to update the screen
    signals.connect_refresh_screen(
        function()
            print('Refreshing action center')

            if panel == nil then
                return
            end

            s = get_screen()

            -- the action center itself
            panel.x = s.geometry.x + (s.geometry.width - panel_width)
            panel.width = panel_width
            panel.height = s.geometry.height

            -- the backdrop
            update_backdrop_location()
        end
    )

    panel.opened = false

    panel:struts(
        {
            right = 0
        }
    )

    local separator = seperator_widget(15, 'horizontal', 0)

    local clear_all_text =
        wibox.widget {
        text = i18n.translate('Clear All Notifications'),
        font = beautiful.font .. ' 10',
        align = 'center',
        valign = 'bottom',
        widget = wibox.widget.textbox
    }

    local wrap_clear_text =
        wibox.widget {
        clear_all_text,
        margins = dpi(5),
        widget = wibox.container.margin
    }
    local clear_all_button =
        clickable_container(wibox.container.margin(wrap_clear_text, dpi(0), dpi(0), dpi(3), dpi(3)))
    clear_all_button:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                nil,
                function()
                    _G.notification_clear_all()
                    _G.notification_firstime = true
                end
            )
        )
    )

    local notification_widget =
        wibox.widget {
        visible = true,
        separator,
        require('layout.right-panel.subwidgets.dont-disturb'),
        {
            expand = 'none',
            layout = wibox.layout.align.horizontal,
            {
                nil,
                layout = wibox.layout.fixed.horizontal
            },
            nil,
            {
                wibox.container.margin(clear_all_button, dpi(15), dpi(15), dpi(10), dpi(0)),
                layout = wibox.layout.fixed.horizontal
            }
        },
        {
            require('layout.right-panel.subwidgets.notif-generate'),
            wibox.widget({}),
            margins = dpi(15),
            widget = wibox.container.margin
        },
        layout = wibox.layout.fixed.vertical
    }

    local grabber

    local openPanel = function()
        backdrop.visible = true
        panel.visible = true
        if grabber then
            grabber:start()
        end
        panel:emit_signal('opened')

        s = get_screen()

        -- start the animations
        panel.x = s.geometry.x + s.geometry.width
        panel.height = s.geometry.height
        panel.opacity = 0
        animate(
            _G.anim_speed,
            panel,
            {opacity = 1, x = s.geometry.x + (s.geometry.width - panel_width)},
            'outCubic',
            function()
                update_backdrop_location()
            end
        )
    end

    local closePanel = function()
        s = get_screen()

        -- start the animations
        panel.x = s.geometry.x + (s.geometry.width - panel_width)
        panel.height = s.geometry.height
        panel.opacity = 1
        backdrop.visible = false

        animate(
            _G.anim_speed,
            panel,
            {opacity = 0, x = s.geometry.x + s.geometry.width},
            'outCubic',
            function()
                panel.visible = false
                if grabber then
                    grabber:stop()
                end
                panel:emit_signal('closed')
                update_backdrop_location()

                -- reset the scrollbox
                body:reset()
            end
        )
    end

    grabber =
        awful.keygrabber {
        keybindings = {
            awful.key {
                modifiers = {},
                key = 'Escape',
                on_press = function()
                    panel.opened = false
                    closePanel()
                end
            },
            awful.key {
                modifiers = {modKey},
                key = keyconfig.notificationPanel,
                on_press = function()
                    panel.opened = false
                    closePanel()
                end
            }
        },
        -- Note that it is using the key name and not the modifier name.
        stop_key = 'Escape',
        stop_event = 'release'
    }

    -- Hide this panel when app dashboard is called.
    function panel:HideDashboard()
        closePanel()
        collectgarbage('collect')
    end

    function panel:toggle()
        self.opened = not self.opened
        if self.opened then
            openPanel()
        else
            closePanel()
            collectgarbage('collect')
        end
    end

    local widgets = notification_plugin()
    -- returns the state of the widgets
    -- first tuple element returns the notification section (type wibox.widget)
    -- the second tuple element returns the widget section (type wibox.widget)
    -- if no element is supplied it should return the current unmodified state
    function panel:switch_mode(mode)
        if mode == 'notif_mode' then
            -- Update Content
            notification_widget.visible = true
            widgets.visible = false
        elseif mode == 'widgets_mode' then
            -- Update Content
            notification_widget.visible = false
            widgets.visible = true
        end
        return notification_widget, widgets
    end

    backdrop:buttons(
        awful.util.table.join(
            awful.button(
                {},
                1,
                function()
                    panel:toggle()
                end
            )
        )
    )

    local headerSeparator =
        wibox.widget {
        orientation = 'horizontal',
        forced_height = 15,
        span_ratio = 1.0,
        opacity = 0.90,
        color = beautiful.bg_modal,
        widget = wibox.widget.separator
    }

    body =
        scrollbox(
        wibox.widget {
            separator,
            {
                expand = 'none',
                layout = wibox.layout.align.horizontal,
                {
                    nil,
                    layout = wibox.layout.fixed.horizontal
                },
                require('layout.right-panel.subwidgets.panel-mode-switcher'),
                {
                    nil,
                    layout = wibox.layout.fixed.horizontal
                }
            },
            separator,
            headerSeparator,
            {
                layout = wibox.layout.stack,
                -- Notification Center
                notification_widget,
                -- Widget Center
                widgets
            },
            layout = wibox.layout.fixed.vertical
        }
    )

    panel:setup {
        expand = 'none',
        layout = wibox.layout.fixed.vertical,
        body
    }

    return panel
end

return right_panel
