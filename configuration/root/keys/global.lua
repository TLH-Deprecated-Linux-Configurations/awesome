--  _______ __         __           __
-- |     __|  |.-----.|  |--.---.-.|  |
-- |    |  |  ||  _  ||  _  |  _  ||  |
-- |_______|__||_____||_____|___._||__|
--  __  __
-- |  |/  |.-----.--.--.-----.
-- |     < |  -__|  |  |__ --|
-- |__|\__||_____|___  |_____|
--               |_____|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- setup
local awful = require('awful')
local naughty = require('naughty')

local modkey = require('configuration.root.keys.mod').modKey
local altkey = require('configuration.root.keys.mod').altKey

local apps = require('configuration.root.apps')
_G.switcher = require('module.application_switcher')
require('awful.autofocus')
local focusmap = require('configuration.root.keys.maps.focus')
local applicationsmap = require('configuration.root.keys.maps.applications')
local awesomemap = require('configuration.root.keys.maps.awesome')
local layoutmap = require('configuration.root.keys.maps.layout')
local modalbind = require('utilities.client.modalbind')

modalbind.init()

local globalKeys =
    awful.util.table.join(
    -- ------------------------------------------------- --
    awful.key(
        {'Mod1'},
        'b',
        function()
            modalbind.grab {keymap = focusmap, name = 'Focus Conrol', stay_in_mode = true}
        end,
        {description = 'Enter Focus Control Mode', group = 'Mode'}
    ),
    -- ------------------------------------------------- --
    awful.key(
        {'Mod1'},
        'l',
        function()
            modalbind.grab {keymap = layoutmap, name = 'Layout Conrol', stay_in_mode = true}
        end,
        {description = 'Enter Layout Control Mode', group = 'Mode'}
    ),
    -- ------------------------------------------------- --
    awful.key(
        {'Mod1'},
        'z',
        function()
            modalbind.grab {keymap = applicationsmap, name = 'Applications Launch', stay_in_mode = false}
        end,
        {description = 'Enter Focus Control Mode', group = 'Mode'}
    ),
    -- ------------------------------------------------- --
    awful.key(
        {'Mod1'},
        'a',
        function()
            modalbind.grab {keymap = awesomemap, name = 'Awesome Conrol', stay_in_mode = false}
        end,
        {description = 'Enter Awesome Control Mode', group = 'Mode'}
    ),
    -- ------------------------------------------------- --
    --- Lockscreen
    awful.key(
        {modkey},
        'l',
        function()
            require('module.lockscreen.lockscreen').lock_screen_show()
        end,
        {description = 'lock screen', group = 'hotkeys'}
    ),
    -- ------------------------------------------------- --
    awful.key(
        {modkey},
        'Tab',
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = 'go back', group = 'Window'}
    ),
    -- ------------------------------------------------- --
    -- Tab Between Applications
    awful.key(
        {'Mod1'},
        'Tab',
        function()
            _G.switcher.switch(1, 'Mod1', 'Alt_L', 'Shift', 'Tab')
        end,
        {description = 'Tab Forward Between Applications', group = 'Launcher'}
    ),
    -- ------------------------------------------------- --
    awful.key(
        {'Mod1', 'Shift'},
        'Tab',
        function()
            _G.switcher.switch(-1, 'Mod1', 'Alt_L', 'Shift', 'Tab')
        end,
        {
            description = 'Tab Back Between Applications',
            group = 'Launcher'
        }
    ),
    -- ------------------------------------------------- --
    awful.key(
        {modkey},
        'space',
        function()
            awesome.emit_signal('layout::changed:next')
            naughty.notify(
                {
                    preset = naughty.config.presets.low,
                    title = 'Switched Layouts',
                    text = awful.layout.getname(awful.layout.get(awful.screen.focused()))
                }
            )
        end,
        {description = 'Select Next Layout', group = 'Layout'}
    ),
    -- ------------------------------------------------- --
    awful.key(
        {modkey, 'Shift'},
        'space',
        function()
            awesome.emit_signal('layout::changed:prev')
            naughty.notify(
                {
                    preset = naughty.config.presets.low,
                    title = 'Switched Layouts',
                    text = awful.layout.getname(awful.layout.get(awful.screen.focused()))
                }
            )
        end,
        {description = 'Select Previous Layout', group = 'Layout'}
    ),
    -- ------------------------------------------------- --
    --Run App Menu
    awful.key(
        {modkey, 'Control'},
        'Escape',
        function()
            awful.spawn.with_shell(
                'rofi -no-lazy-grab -show drun -theme ~/.config/awesome/configuration/rofi/centered.rasi'
            )
        end,
        {description = 'run rofi prompt', group = 'Launcher'}
    ),
    -- ------------------------------------------------- --
    -- Raise Brightness
    awful.key(
        {},
        'XF86MonBrightnessUp',
        function()
            awful.spawn('light -A 10%', false)
            awful.spawn.with_line_callback(
                'light -G',
                {
                    stdout = function(value)
                        awful.spawn.with_line_callback(
                            'light -M ',
                            {
                                stdout = function(max)
                                    percentage = value / max * 100
                                    -- if percentage ~= percentage_old then
                                    awesome.emit_signal('signal::brightness', percentage)
                                    -- percentage_old = percentage
                                    -- end
                                end
                            }
                        )
                    end
                }
            )
        end,
        {description = 'increase brightness by 10%', group = 'Awesome'}
    ),
    -- ------------------------------------------------- --
    -- Decrease Brightness
    awful.key(
        {},
        'XF86MonBrightnessDown',
        function()
            awful.spawn('light -U 10%', false)
            awful.spawn.with_line_callback(
                'light -G',
                {
                    stdout = function(value)
                        awful.spawn.with_line_callback(
                            'light -M ',
                            {
                                stdout = function(max)
                                    percentage = value / max * 100
                                    -- if percentage ~= percentage_old then
                                    awesome.emit_signal('signal::brightness', percentage)
                                    -- percentage_old = percentage
                                    -- end
                                end
                            }
                        )
                    end
                }
            )
        end,
        {description = 'decrease brightness by 10%', group = 'Awesome'}
    ),
    -- ------------------------------------------------- --
    -- Raise Volume Key
    awful.key(
        {},
        'XF86AudioRaiseVolume',
        function()
            awful.spawn.easy_async_with_shell(
                'pamixer -i 5',
                function()
                    awful.spawn.with_line_callback(
                        'pamixer --get-volume',
                        {
                            stdout = function(value)
                                awesome.emit_signal('signal::volume', value)
                            end
                        }
                    )
                end
            )
        end,
        {description = 'Increase Volume', group = 'Awesome'}
    ),
    -- ------------------------------------------------- --
    -- Lower Volume Key
    awful.key(
        {},
        'XF86AudioLowerVolume',
        function()
            awful.spawn.easy_async_with_shell(
                'pamixer -d 5',
                function()
                    awful.spawn.with_line_callback(
                        'pamixer --get-volume',
                        {
                            stdout = function(value)
                                awesome.emit_signal('signal::volume', value)
                            end
                        }
                    )
                end
            )
        end,
        {description = 'Decrease Volume', group = 'Awesome'}
    ),
    -- ------------------------------------------------- --
    -- Mute Key
    awful.key(
        {},
        'XF86AudioMute',
        function()
            awful.spawn('pamixer -t')
            awful.spawn(
                'pamixer --get-mute',
                function(value)
                    if value == true then
                        awesome.emit_signal('signal::volume')
                    else
                        awesome.emit_signal('signal::volume', 0)
                    end
                end
            )
        end,
        {description = 'Mute Volume', group = 'Awesome'}
    ),
    -- ------------------------------------------------- --
    -- Power Button
    awful.key(
        {},
        'XF86PowerDown',
        function()
            awesome.emit_signal('module::exit_screen:show')
        end,
        {description = 'Shutdown Skynet', group = 'Awesome'}
    ), -- ------------------------------------------------- --
    awful.key(
        {},
        'XF86PowerOff',
        function()
            awesome.emit_signal('module::exit_screen:show')
        end,
        {description = 'Toggle Exit Screen', group = 'Awesome'}
    ),
    -- ------------------------------------------------- --
    -- Display Button
    awful.key(
        {},
        'XF86Display',
        function()
            awful.spawn.single_instance('arandr', false)
        end,
        {description = 'Arandr', group = 'Awesome'}
    )
    --
)
-- ------------------------------------------------- --
for i = 1, 9 do
    globalKeys =
        awful.util.table.join(
        globalKeys,
        -- View tag only.
        awful.key(
            {modkey},
            '#' .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {description = 'view tag #' .. i, group = 'Tag'}
        ),
        -- ------------------------------------------------- --
        -- Toggle tag display.
        awful.key(
            {modkey, 'Control'},
            '#' .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = 'toggle tag #' .. i, group = 'Tag'}
        ),
        -- ------------------------------------------------- --
        -- Move client to tag.
        awful.key(
            {modkey, 'Shift'},
            '#' .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = 'move focused client to tag #' .. i, group = 'Tag'}
        ),
        -- ------------------------------------------------- --
        -- Toggle tag on focused client.
        awful.key(
            {modkey, 'Control', 'Shift'},
            '#' .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {description = 'toggle focused client on tag #' .. i, group = 'Tag'}
        )
    )
end

return globalKeys
