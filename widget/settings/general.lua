--  _______                                __
-- |     __|.-----.-----.-----.----.---.-.|  |
-- |    |  ||  -__|     |  -__|   _|  _  ||  |
-- |_______||_____|__|__|_____|__| |___._||__|

--  _______         __   __   __
-- |     __|.-----.|  |_|  |_|__|.-----.-----.-----.
-- |__     ||  -__||   _|   _|  ||     |  _  |__ --|
-- |_______||_____||____|____|__||__|__|___  |_____|
--                                     |_____|
local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')
local configWriter = require('lib.config-writer')
local configFile = os.getenv('HOME') .. '/.config/awesome/electrictantra/general.conf'
local dpi = beautiful.xresources.apply_dpi
local icons = require('theme.icons')
local slider = require('lib.slider')
local seperator_widget = require('lib.separator')
local signals = require('module.signals')
local card = require('lib.card')
local button = require('lib.button')
local checkbox = require('lib.checkbox')
local datetime = require('lib.function.datetime')

local m = dpi(5)
local settings_index = dpi(40)
local settings_width = dpi(1100)
local settings_nw = dpi(260)

local button_widgets = {}
local primary_theme = beautiful.xcolor4

signals.connect_primary_theme_changed(
    function(new_theme)
        primary_theme = new_theme
    end
)

local function create_multi_option_array(name, tooltip, options, default, configOption)
    local name_widget =
        wibox.widget {
        text = name,
        font = beautiful.title_font,
        widget = wibox.widget.textbox
    }
    awful.tooltip {
        objects = {name_widget},
        timer_function = function()
            return tooltip
        end
    }
    local layout = wibox.layout.flex.horizontal()
    layout.forced_width = settings_width - settings_nw
    layout:add(name_widget)
    button_widgets[name] = {}
    for _, option in ipairs(options) do
        -- leave focus button callback
        local leave = function()
            if button_widgets[name][option].active then
                button_widgets[name][option].bg = primary_theme.hue_600
            else
                button_widgets[name][option].bg = beautiful.bg_modal
            end
        end

        -- the button object
        local option_widget
        option_widget =
            button(
            option,
            function()
                print('Pressed button')
                for _, widget in pairs(button_widgets[name]) do
                    widget.bg = beautiful.bg_modal
                    widget.active = false
                end
                option_widget.bg = primary_beautiful.bg_focus
                option_widget.active = true
                configWriter.update_entry(configFile, configOption, option)
            end,
            nil,
            nil,
            nil,
            leave
        )

        option_widget.forced_height = settings_index * 0.7

        if option == default then
            option_widget.active = true
        else
            option_widget.bg = beautiful.bg_modal
        end

        button_widgets[name][option] = option_widget
        layout:add(wibox.container.margin(option_widget, m, m, m, m))
    end
    return layout
end

local function create_checkbox(name, tooltip, checked, configOption, on, off)
    local name_widget =
        wibox.widget {
        text = name,
        font = beautiful.title_font,
        widget = wibox.widget.textbox
    }
    local box =
        checkbox(
        checked,
        function(box_checked)
            local value = off or '0'
            if box_checked then
                value = on or '1'
            end
            configWriter.update_entry(configFile, configOption, value)
        end,
        settings_index * 0.7
    )

    awful.tooltip {
        objects = {name_widget},
        timer_function = function()
            return tooltip
        end
    }

    return wibox.container.margin(
        wibox.widget {
            layout = wibox.layout.align.horizontal,
            wibox.container.margin(name_widget, m),
            nil,
            wibox.container.margin(box, 0, m)
        },
        m,
        m,
        m,
        m
    )
end

local function create_option_slider(title, min, max, inc, option, start_value, callback, tooltip_callback)
    local option_slider =
        slider(
        min,
        max,
        inc,
        start_value,
        function(value)
            callback(value)
            configWriter.update_entry(configFile, option, tostring(value))
        end,
        tooltip_callback
    )

    return wibox.widget {
        layout = wibox.layout.align.horizontal,
        wibox.container.margin(wibox.widget.textbox(title), 0, m),
        option_slider,
        forced_height = dpi(30)
    }
end

return function()
    local view = wibox.container.margin()
    view.left = m
    view.right = m

    local title = wibox.widget.textbox('General')
    title.font = beautiful.title_font
    title.forced_height = settings_index + m + m

    local close = wibox.widget.imagebox(icons.close)
    close.forced_height = settings_index
    close:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                function()
                    if root.elements.settings then
                        root.elements.settings.close()
                    end
                end
            )
        )
    )

    local save =
        button(
        'Update',
        function()
            print('Saving general settings')
            -- reload TDE
            awesome.restart()
        end
    )

    local separator = seperator_widget(settings_index / 1.5)

    local checkbox_widget =
        wibox.widget {
        layout = wibox.layout.flex.vertical,
        create_checkbox(
            'Audio popup',
            "Enable the 'pop' sound when changing the audio",
            general['audio_change_sound'] == '1',
            'audio_change_sound'
        ),
        create_checkbox(
            'Titlebar drawing',
            'Draw the titlebar above every application',
            general['draw_mode'] == 'full',
            'draw_mode',
            'full',
            'none'
        ),
        create_checkbox(
            'Screen timeout',
            'Put the system in sleep mode after a period of inactivity',
            general['screen_timeout'] == '1' or general['screen_timeout'] == nil,
            'screen_timeout'
        ),
        create_checkbox(
            'Weak Hardware',
            "Disable a lot of the 'nice' features in order to reduce hardware consumption",
            general['weak_hardware'] == '1',
            'weak_hardware'
        ),
        create_checkbox(
            'Autofocus',
            'Automatically make the focus follow the mouse without clicking',
            general['autofocus'] == '1',
            'autofocus'
        ),
        create_checkbox(
            'Minimize Network Usage',
            'Disable a lot of network utilities to reduce network usage',
            general['minimize_network_usage'] == '1',
            'minimize_network_usage'
        )
    }

    local multi_option_widget =
        wibox.widget {
        create_multi_option_array(
            'Window screenshot mode',
            'when making a screenshot of a window, you can either show the screenshot or make a pretty version with some shadows, and your theme color',
            {'shadow', 'none'},
            general['window_screen_mode'] or 'shadow',
            'window_screen_mode'
        ),
        layout = wibox.layout.flex.vertical
    }

    local slider_widget =
        wibox.widget {
        create_option_slider(
            'Animation Speed',
            0,
            1.5,
            0.05,
            'animation_speed',
            tonumber(general['window_screen_mode']) or _G.anim_speed,
            function(value)
                _G.update_anim_speed(value)
            end
        ),
        layout = wibox.layout.flex.vertical
    }

    local checkbox_card = card()
    checkbox_card.update_body(wibox.container.margin(checkbox_widget, dpi(10), dpi(10), dpi(3), dpi(3)))

    local multi_option_card = card()
    multi_option_card.update_body(wibox.container.margin(multi_option_widget, dpi(10), dpi(10), dpi(3), dpi(3)))

    local slider_card = card()
    slider_card.update_body(wibox.container.margin(slider_widget, dpi(10), dpi(10), dpi(3), dpi(3)))

    view:setup {
        layout = wibox.container.background,
        {
            layout = wibox.layout.fixed.vertical,
            {
                layout = wibox.layout.align.horizontal,
                nil,
                wibox.container.margin(
                    {
                        layout = wibox.container.place,
                        title
                    },
                    settings_index * 2
                ),
                close
            },
            separator,
            wibox.container.margin(checkbox_card, dpi(10), dpi(10)),
            separator,
            wibox.container.margin(multi_option_card, dpi(10), dpi(10)),
            separator,
            wibox.container.margin(slider_card, dpi(10), dpi(10)),
            separator,
            wibox.container.margin(save, m, m, m, m)
        }
    }

    return view
end
