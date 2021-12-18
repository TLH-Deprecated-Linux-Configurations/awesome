--  _______ __         __           __
-- |     __|  |.-----.|  |--.---.-.|  |
-- |    |  |  ||  _  ||  _  |  _  ||  |
-- |_______|__||_____||_____|___._||__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local awful = require('awful')
local beautiful = require('beautiful')
local drop = require('module.attachdrop')
require('awful.autofocus')

local hotkeys_popup = require('awful.hotkeys_popup').widget
_G.switcher = require('module.application-switcher')
local modkey = require('configuration.keys.mod').mod_key
local altkey = require('configuration.keys.mod').alt_key
local apps = require('configuration.apps')

-- Key bindings
local global_keys =
    awful.util.table.join(
    -- #####################################################################

    awful.key(
        {'Mod1'},
        'Escape',
        function()
            print('Spawning Window Menu')
            awful.menu.menu_keys.down = {'Down', 'Alt_L'}
            awful.menu.menu_keys.up = {'Up', 'Alt_R'}
            awful.menu.clients({theme = {width = 450}}, {keygrabber = true})
        end,
        {description = 'Open Window Menu', group = 'Utility'}
    ),
    -- Hotkeys
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Hotkeys Helper
    awful.key(
        {modkey},
        'F1',
        function()
            hotkeys_popup.show_help()
        end,
        {
            description = 'Show Key Bindings',
            group = 'Awesome'
        }
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Browsers
    awful.key(
        {modkey},
        'F2',
        function()
            print('Spawning Firefox Instance')
            awful.spawn('firefox-nightly')
        end,
        {description = 'Launch New Firefox Instance', group = 'Launcher'}
    ),
    -- #############################################################################
    awful.key(
        {modkey, 'Control'},
        'F2',
        function()
            print('Spawning Epiphany')

            awful.spawn('epiphany')
        end,
        {description = 'Launch New Epiphany Instance', group = 'Launcher'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- File Manager
    awful.key(
        {modkey},
        'F3',
        function()
            print('Spawning caja in Scratchpad')
            drop.toggle('caja', 'left', 'top', 0.7, 0.7)

            -- awful.spawn('caja')
        end,
        {description = 'Launch caja in Scratchpad', group = 'Launcher'}
    ),
    -- #############################################################################
    awful.key(
        {modkey, 'Control'},
        'F3',
        function()
            print('Spawning caja as Root')

            awful.spawn('gksu caja')
        end,
        {description = 'Launch file Manager as Root', group = 'Launcher'}
    ),
    -- #############################################################################
    awful.key(
        {modkey, 'Shift'},
        'F3',
        function()
            print('Spawning New caja Instance')

            awful.spawn('caja')
        end,
        {description = 'Launch New caja Instance', group = 'Launcher'}
    ),
    -- #############################################################################
    awful.key(
        {modkey, 'Mod1'},
        'F3',
        function()
            print('Spawning New Ranger Instance')

            awful.spawn('ranger')
        end,
        {description = 'Launch New Ranger Instance', group = 'Launcher'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Icon Picker Application
    awful.key(
        {modkey},
        'F4',
        function()
            print('Spawning Font Awesome Menu')

            awful.spawn.easy_async_with_shell('~/.config/awesome/external/rofi/fontawesome_menu/fontawesome-menu')
        end,
        {
            description = 'Copy FontAwesome Icons to Clipboard',
            group = 'Launcher'
        }
    ),
    -- #############################################################################
    awful.key(
        {modkey, 'Control'},
        'F4',
        function()
            print('Spawning Emoji Picker')

            awful.spawn.easy_async_with_shell('rofimoji -a copy ')
        end,
        {description = 'Copy bin/emojis to Clipboard', group = 'Launcher'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Open system monitor
    --
    awful.key(
        {'Control', 'Mod1'},
        'Delete',
        function()
            print('Opening System Monitor')
            awful.spawn.easy_async_with_shell("sudo kitty -e '/usr/bin/htop'")
        end,
        {description = 'Open System Monitor', group = 'Launcher'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Tab Between Applications
    awful.key(
        {'Mod1'},
        'Tab',
        function()
            print('Tabbing between applications')
            _G.switcher.switch(1, 'Mod1', 'Alt_L', 'Shift', 'Tab')
        end,
        {description = 'Tab Forward Between Applications', group = 'Launcher'}
    ),
    -- #############################################################################
    awful.key(
        {'Mod1', 'Shift'},
        'Tab',
        function()
            print('Reverse tabbing between applications')
            _G.switcher.switch(-1, 'Mod1', 'Alt_L', 'Shift', 'Tab')
        end,
        {
            description = 'Tab Between Applications In Reverse Order',
            group = 'Launcher'
        }
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Show Scratch WIndows
    awful.key(
        {modkey, 'Mod1'},
        'Return',
        function()
            print('Showing all scratch windows')
            drop.showall()
        end,
        {
            description = 'Show all scratchpad windows on screen',
            group = 'Launcher'
        }
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Display Configuration
    --
    awful.key(
        {},
        'XF86Display',
        function()
            print('Spawning Arandr')
            awful.spawn('Arandr')
        end,
        {description = 'Spawn Arandr', group = 'Awesome'}
    ),
    -- #############################################################################
    awful.key(
        {modkey},
        'F5',
        function()
            print('Spawning Arandr')

            awful.spawn('arandr')
        end,
        {
            description = 'Open Display Configuration Application',
            group = 'Launcher'
        }
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Open system monitor
    --
    awful.key(
        {'Control', 'Mod1'},
        'Delete',
        function()
            print('Opening System Monitor')
            awful.spawn.easy_async_with_shell("sudo kitty -e '/usr/bin/htop'")
        end,
        {description = 'Open System Monitor', group = 'Launcher'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Restart Awesome
    --
    awful.key({modkey}, 'r', awesome.restart, {description = 'reload awesome', group = 'Awesome'}),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Quit Awesome
    awful.key({modkey, 'Control'}, 'q', awesome.quit, {description = 'quit awesome', group = 'Awesome'}),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Increase Master Width Factor
    awful.key(
        {altkey, 'Shift'},
        'l',
        function()
            awful.tag.incmwfact(0.05)
        end,
        {description = 'increase master width factor', group = 'layout'}
    ),
    -- ########################################################################
    awful.key(
        {altkey, 'Shift'},
        'h',
        function()
            awful.tag.incmwfact(-0.05)
        end,
        {description = 'decrease master width factor', group = 'layout'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Increase Number of Master Clients
    awful.key(
        {modkey, 'Shift'},
        'h',
        function()
            awful.tag.incnmaster(1, nil, true)
        end,
        {description = 'increase the number of master clients', group = 'layout'}
    ),
    -- ########################################################################
    awful.key(
        {modkey, 'Shift'},
        'l',
        function()
            awful.tag.incnmaster(-1, nil, true)
        end,
        {description = 'decrease the number of master clients', group = 'layout'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Increase Number of Columns
    awful.key(
        {modkey, 'Control'},
        'h',
        function()
            awful.tag.incncol(1, nil, true)
        end,
        {description = 'increase the number of columns', group = 'layout'}
    ),
    -- ########################################################################
    awful.key(
        {modkey, 'Control'},
        'l',
        function()
            awful.tag.incncol(-1, nil, true)
        end,
        {description = 'decrease the number of columns', group = 'layout'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Select the Next Layout
    awful.key(
        {modkey},
        'space',
        function()
            awful.layout.inc(1)
        end,
        {description = 'select next layout', group = 'layout'}
    ),
    -- ########################################################################
    awful.key(
        {modkey, 'Shift'},
        'space',
        function()
            awful.layout.inc(-1)
        end,
        {description = 'select previous layout', group = 'layout'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Modify the Gap
    awful.key(
        {modkey},
        'o',
        function()
            awful.tag.incgap(1)
        end,
        {description = 'increase gap', group = 'layout'}
    ),
    -- ########################################################################
    awful.key(
        {modkey, 'Shift'},
        'o',
        function()
            awful.tag.incgap(-1)
        end,
        {description = 'decrease gap', group = 'layout'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- View Tags
    awful.key({modkey}, 'w', awful.tag.viewprev, {description = 'view previous tag', group = 'tag'}),
    -- ########################################################################
    awful.key({modkey}, 's', awful.tag.viewnext, {description = 'view next tag', group = 'tag'}),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    awful.key(
        {modkey},
        'Tab',
        awful.tag.history.restore,
        {description = 'alternate between current and previous tag', group = 'tag'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- View Non-Empty Tags
    awful.key(
        {modkey, 'Control'},
        'w',
        function()
            -- tag_view_nonempty(-1)
            local focused = awful.screen.focused()
            for i = 1, #focused.tags do
                awful.tag.viewidx(-1, focused)
                if #focused.clients > 0 then
                    return
                end
            end
        end,
        {description = 'view previous non-empty tag', group = 'tag'}
    ),
    -- ########################################################################
    awful.key(
        {modkey, 'Control'},
        's',
        function()
            -- tag_view_nonempty(1)
            local focused = awful.screen.focused()
            for i = 1, #focused.tags do
                awful.tag.viewidx(1, focused)
                if #focused.clients > 0 then
                    return
                end
            end
        end,
        {description = 'view next non-empty tag', group = 'tag'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Screen Toggle
    --
    awful.key(
        {modkey, 'Shift'},
        'c',
        function()
            awful.screen.focus_relative(-1)
        end,
        {description = 'focus the previous screen', group = 'screen'}
    ),
    -- ########################################################################
    awful.key(
        {modkey, 'Shift'},
        'v',
        function()
            awful.screen.focus_relative(1)
        end,
        {description = 'focus the next screen', group = 'screen'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Restore Minimize
    --
    awful.key(
        {modkey, 'Control'},
        'n',
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal('request::activate')
                c:raise()
            end
        end,
        {description = 'restore minimized', group = 'screen'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Brightness
    --
    awful.key(
        {},
        'XF86MonBrightnessUp',
        function()
            awful.spawn('light -A 10', false)
            awesome.emit_signal('widget::brightness')
            awesome.emit_signal('module::brightness_osd:show', true)
        end,
        {description = 'increase brightness by 10%', group = 'hotkeys'}
    ),
    -- ########################################################################

    awful.key(
        {},
        'XF86MonBrightnessDown',
        function()
            awful.spawn('light -U 10', false)
            awesome.emit_signal('widget::brightness')
            awesome.emit_signal('module::brightness_osd:show', true)
        end,
        {description = 'decrease brightness by 10%', group = 'hotkeys'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- ALSA volume control
    --
    awful.key(
        {},
        'XF86AudioRaiseVolume',
        function()
            awful.spawn('amixer sset Master 5%+')
            awesome.emit_signal('widget::volume')
            awesome.emit_signal('module::volume_osd:show', true)
        end,
        {description = 'increase volume up by 5%', group = 'hotkeys'}
    ),
    -- ########################################################################

    awful.key(
        {},
        'XF86AudioLowerVolume',
        function()
            awful.spawn('amixer sset Master 5%-', false)
            awesome.emit_signal('widget::volume')
            awesome.emit_signal('module::volume_osd:show', true)
        end,
        {description = 'decrease volume up by 5%', group = 'hotkeys'}
    ),
    -- ########################################################################

    awful.key(
        {},
        'XF86AudioMute',
        function()
            awful.spawn('amixer  set Master 1+ toggle', false)
        end,
        {description = 'toggle mute', group = 'hotkeys'}
    ),
    -- ########################################################################

    awful.key(
        {},
        'XF86AudioNext',
        function()
            awful.spawn('mpc next', false)
        end,
        {description = 'next music', group = 'hotkeys'}
    ),
    -- ########################################################################

    awful.key(
        {},
        'XF86AudioPrev',
        function()
            awful.spawn('mpc prev', false)
        end,
        {description = 'previous music', group = 'hotkeys'}
    ),
    -- ########################################################################

    awful.key(
        {},
        'XF86AudioPlay',
        function()
            awful.spawn('mpc toggle', false)
        end,
        {description = 'play/pause music', group = 'hotkeys'}
    ),
    -- ########################################################################

    awful.key(
        {},
        'XF86AudioMicMute',
        function()
            awful.spawn('amixer sset Capture toggle', false)
        end,
        {description = 'mute microphone', group = 'hotkeys'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Power Button
    awful.key(
        {},
        'XF86PowerDown',
        function()
            awesome.emit_signal('module::exit_screen:show')
        end,
        {description = 'shutdown skynet', group = 'hotkeys'}
    ),
    -- ########################################################################

    awful.key(
        {},
        'XF86PowerOff',
        function()
            awesome.emit_signal('module::exit_screen:show')
        end,
        {description = 'toggle exit screen', group = 'hotkeys'}
    ),
    awful.key(
        {modkey},
        'Escape',
        function()
            awesome.emit_signal('module::exit_screen:show')
        end,
        {description = 'toggle exit screen', group = 'hotkeys'}
    ),
    -- ########################################################################

    awful.key(
        {modkey},
        '`',
        function()
            awesome.emit_signal('module::quake_terminal:toggle')
        end,
        {description = 'dropdown application', group = 'Launcher'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Display Button
    awful.key(
        {},
        'XF86Display',
        function()
            awful.spawn.single_instance('arandr', false)
        end,
        {description = 'arandr', group = 'hotkeys'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    --Screenshot
    awful.key(
        {},
        'Print',
        function()
            awful.spawn(apps.utils.full_screenshot)
        end,
        {description = 'screenshot tool', group = 'Launcher'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    --Screenshot
    awful.key(
        {modkey},
        'Print',
        function()
            awful.spawn(apps.utils.area_screenshot)
        end,
        {description = 'screenshot tool', group = 'launcher'}
    ),
    -- ########################################################################

    awful.key(
        {modkey, 'Shift'},
        's',
        function()
            awful.spawn.easy_async_with_shell(
                apps.utils.area_screenshot,
                function()
                end
            )
        end,
        {description = 'area/selected screenshot', group = 'Utility'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Blur Effect
    awful.key(
        {modkey},
        ']',
        function()
            awesome.emit_signal('widget::blur:increase')
        end,
        {description = 'increase blur effect by 10%', group = 'Utility'}
    ),
    -- ########################################################################
    awful.key(
        {modkey},
        '[',
        function()
            awesome.emit_signal('widget::blur:decrease')
        end,
        {description = 'decrease blur effect by 10%', group = 'Utility'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Systray Visiblility
    awful.key(
        {'Control'},
        'Escape',
        function()
            if screen.primary.systray then
                if not screen.primary.tray_toggler then
                    local systray = screen.primary.systray
                    systray.visible = not systray.visible
                else
                    awesome.emit_signal('widget::systray:toggle')
                end
            end
        end,
        {description = 'toggle systray visibility', group = 'Utility'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Screen Lock
    awful.key(
        {modkey},
        'l',
        function()
            awful.spawn(apps.default.lock, false)
        end,
        {description = 'lock the screen', group = 'Utility'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Terminal
    awful.key(
        {modkey},
        'Return',
        function()
            drop.toggle(apps.default.terminal, 'left', 'top', 0.8, 0.8)
        end,
        {description = 'open terminal', group = 'launcher'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    --NVIM
    awful.key(
        {modkey},
        'F6',
        function()
            awful.spawn(apps.default.text_editor)
        end,
        {description = 'open NeoVim', group = 'launcher'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- App Drawer
    --
    awful.key(
        {modkey, 'Control'},
        'Escape',
        function()
            local focused = awful.screen.focused()

            if focused.control_center then
                focused.control_center:hide_dashboard()
                focused.control_center.opened = false
            end
            if focused.info_center then
                focused.info_center:hide_dashboard()
                focused.info_center.opened = false
            end
            awful.spawn(apps.default.rofi_appmenu, false)
        end,
        {description = 'open application drawer', group = 'launcher'}
    ),
    -- ########################################################################
    awful.key(
        {altkey},
        'space',
        function()
            local focused = awful.screen.focused()

            if focused.control_center then
                focused.control_center:hide_dashboard()
                focused.control_center.opened = false
            end
            if focused.info_center then
                focused.info_center:hide_dashboard()
                focused.info_center.opened = false
            end
            awful.spawn(apps.default.rofi_appmenu, false)
        end,
        {description = 'open application drawer', group = 'launcher'}
    ),
    -- ########################################################################
    awful.key(
        {},
        'XF86Launch1',
        function()
            local focused = awful.screen.focused()

            if focused.control_center then
                focused.control_center:hide_dashboard()
                focused.control_center.opened = false
            end
            if focused.info_center then
                focused.info_center:hide_dashboard()
                focused.info_center.opened = false
            end
            awful.spawn(apps.default.rofi_appmenu, false)
        end,
        {description = 'open application drawer', group = 'launcher'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    awful.key(
        {modkey},
        '/',
        function()
            awful.spawn(apps.default.rofi_global, false)
        end,
        {description = 'open global search', group = 'Launcher'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Control Center
    awful.key(
        {modkey},
        '=',
        function()
            local focused = awful.screen.focused()
            if focused.info_center and focused.info_center.visible then
                focused.info_center:toggle()
            end
            focused.control_center:toggle()
        end,
        {description = 'open control center', group = 'Launcher'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Info Center
    awful.key(
        {modkey},
        '-',
        function()
            local focused = awful.screen.focused()
            if focused.control_center and focused.control_center.visible then
                focused.control_center:toggle()
            end
            focused.info_center:toggle()
        end,
        {description = 'open info center', group = 'Launcher'}
    )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = 'view tag #', group = 'tag'}
        descr_toggle = {description = 'toggle tag #', group = 'tag'}
        descr_move = {description = 'move focused client to tag #', group = 'tag'}
        descr_toggle_focus = {description = 'toggle focused client on tag #', group = 'tag'}
    end
    global_keys =
        awful.util.table.join(
        global_keys,
        -- View tag only.
        awful.key(
            {modkey},
            '#' .. i + 9,
            function()
                local focused = awful.screen.focused()
                local tag = focused.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            descr_view
        ),
        -- Toggle tag display.
        awful.key(
            {modkey, 'Control'},
            '#' .. i + 9,
            function()
                local focused = awful.screen.focused()
                local tag = focused.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            descr_toggle
        ),
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
            descr_move
        ),
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
            descr_toggle_focus
        )
    )
end

return global_keys
