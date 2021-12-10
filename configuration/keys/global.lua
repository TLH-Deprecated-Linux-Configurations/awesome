--  _______ __         __           __      __  __
-- |     __|  |.-----.|  |--.---.-.|  |    |  |/  |.-----.--.--.-----.
-- |    |  |  ||  _  ||  _  |  _  ||  |    |     < |  -__|  |  |__ --|
-- |_______|__||_____||_____|___._||__|    |__|\__||_____|___  |_____|
--                                                       |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local drop = require('lib.attachdrop')
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Defines the global keys, which are those not specific to individual
-- client windows
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Key bindings
local globalKeys =
    awful.util.table.join( -- Hotkeys
    awful.key(
        -- #####################################################################
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
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Terminal
    awful.key(
        {modkey},
        'Return',
        function()
            print('Spawning Scratch Terminal')
            drop.toggle('kitty', 'left', 'top', 0.8, 0.8)
        end,
        {description = 'Open Scratch Terminal', group = 'Launcher'}
    ),
    -- #############################################################################
    awful.key(
        {modkey, 'Shift'},
        'Return',
        function()
            print('Spawning Terminal')

            awful.spawn(apps.default.terminal)
        end,
        {description = 'Open Terminal', group = 'Launcher'}
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
    -- Applications Menu
    awful.key(
        {modkey, 'Control'},
        'Escape',
        function()
            print('Spawning Applications Menu')
            awful.spawn(apps.default.rofiappmenu)
        end,
        {description = 'Open Applications Menu', group = 'Utility'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Tag Browsing
    --
    awful.key(
        {modkey},
        'Page_Up',
        awful.tag.viewprev,
        {
            description = 'view prev/next tag',
            group = 'tag'
        }
    ),
    -- #############################################################################
    awful.key(
        {modkey},
        'Page_Down',
        awful.tag.viewnext,
        {
            description = 'view prev/next tag',
            group = 'tag'
        }
    ),
    -- #############################################################################
    awful.key(
        {modkey, 'Cotrol'},
        'Page_Up',
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
    -- #############################################################################
    awful.key(
        {modkey, 'Cotrol'},
        'Page_Down',
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
    -- Client Restore
    awful.key(
        {modkey},
        'Tab',
        function()
            print('Backing Up By Index')

            awful.client.focus.history.previous()
            if _G.client.focus then
                _G.client.focus:raise()
            end
        end,
        {description = 'Go Back', group = 'Client'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Client resize (based on master width)
    --
    awful.key(
        {modkey},
        'Right',
        function()
            print('Increasing Width')

            awful.tag.incmwfact(0.05)
        end,
        {description = 'Increase Master Width Factor', group = 'Layout'}
    ),
    -- #############################################################################
    awful.key(
        {modkey},
        'Left',
        function()
            print('Decreasing Width')

            awful.tag.incmwfact(-0.05)
        end,
        {description = 'Decrease Master Width Factor', group = 'Layout'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Increase/Decrease numbers of master
    awful.key(
        {modkey},
        'Up',
        function()
            print('Increasing Number of Master Clients')

            awful.tag.incnmaster(1, nil, true)
        end,
        {
            description = 'Increase The Number Of Master Clients',
            group = 'Layout'
        }
    ),
    -- #############################################################################
    awful.key(
        {modkey},
        'Down',
        function()
            print('Decreasing Number of Master Clients')

            awful.tag.incnmaster(-1, nil, true)
        end,
        {
            description = 'Decrease The Number Of Master Clients',
            group = 'Layout'
        }
    ),
    -- ########################################################################
    -- #############################################################################
    -- ########################################################################
    -- Client focus
    awful.key(
        {modkey},
        'w',
        function()
            print('Focusing Next By Index')
            awful.client.focus.global_bydirection('left')
        end,
        {description = 'Focus Client to the Left', group = 'Client'}
    ),
    -- #############################################################################
    awful.key(
        {modkey},
        'a',
        function()
            print('Focusing Prior By Index')
            awful.client.focus.global_bydirection('right')
        end,
        {description = 'Focus Client to the Right', group = 'Client'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Sidebars
    --
    awful.key(
        {modkey},
        'g',
        function()
            print('Showing action center')
            _G.screen.primary.left_panel:toggle(true)
        end,
        {description = 'Open Control panel', group = 'Utility'}
    ),
    -- #############################################################################
    awful.key(
        {modkey},
        'h',
        function()
            print('Toggeling Right Panel')
            if _G.screen.primary.right_panel ~= nil then
                _G.screen.primary.right_panel:toggle()
            end
        end,
        {description = 'Open Notification Center', group = 'Utility'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Urgent Client
    --
    awful.key(
        {modkey},
        'u',
        awful.client.urgent.jumpto,
        {
            description = 'Jump To Urgent Client',
            group = 'Client'
        }
    ),
    -- ########################################################################
    -- #########################################################################
    -- ########################################################################
    -- Lockscreen
    --
    awful.key(
        {modkey},
        'l',
        function()
            print('Locking screen')
            awful.spawn(apps.default.lock)
        end,
        {description = 'Lock The Screen', group = 'Awesome'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- reload Awesome
    --
    awful.key(
        {modkey},
        'r',
        _G.awesome.restart,
        {
            description = 'Reload Awesome',
            group = 'Awesome'
        }
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Quit Awesome
    --
    awful.key(
        {modkey, 'Control'},
        'x',
        _G.awesome.quit,
        {
            description = 'Quit Awesome',
            group = 'Awesome'
        }
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- On-the-fly Layout Modification
    --
    awful.key(
        {modkey, 'Control'},
        'h',
        function()
            awful.tag.incnplugplug(1, nil, true)
        end,
        {description = 'Increase The Number Of Columns', group = 'Layout'}
    ),
    -- #############################################################################
    awful.key(
        {modkey, 'Control'},
        'l',
        function()
            awful.tag.incncol(-1, nil, true)
        end,
        {description = 'Decrease The Number Of Columns', group = 'Layout'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Changing Layouts
    awful.key(
        {modkey},
        'space',
        function()
            awful.layout.inc(1)
        end,
        {
            description = 'Select Next Layout',
            group = 'Layout'
        }
    ),
    -- #############################################################################
    awful.key(
        {modkey, 'Shift'},
        'space',
        function()
            awful.layout.inc(-1)
        end,
        {
            description = 'Select Previous Layout',
            group = 'Layout'
        }
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Minimize client
    awful.key(
        {modkey},
        'n',
        function()
            local c = client.focus
            if c then
                c.minimized = true
            end
        end,
        {description = 'Minimize', group = 'Client'}
    ),
    -- #############################################################################
    awful.key(
        {modkey, 'Control'},
        'n',
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                _G.client.focus = c
                c:raise()
            end
        end,
        {description = 'Restore Minimized', group = 'Client'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Show/Hide Bottom Bar
    --
    awful.key(
        {modkey},
        'c',
        function()
            screen = awful.screen.focused()
            screen.bottom_panel.visible = not screen.bottom_panel.visible
        end,
        {description = 'Toggle Bottom Bar', group = 'Awesome'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Rofi Clipboard
    --
    awful.key(
        {modkey},
        'p',
        function()
            print('Opening rofi clipboard')

            naughty.notify(
                {
                    title = 'System',
                    text = 'The rofi clipboard is now opening on your screen',
                    timeout = 10
                }
            )

            awful.spawn(apps.default.roficlipboard)
        end,
        {description = 'Show Clipboard History', group = 'Utility'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Brightness Keys
    awful.key(
        {},
        'XF86MonBrightnessUp',
        function()
            print('Increasing brightness')
            awful.spawn('brightnessctl +10% --save')
            awesome.emit_signal('widget::brightness')

            _G.UpdateBrOSD()
        end,
        {description = '+10%', group = 'Hardware'}
    ),
    -- #############################################################################
    awful.key(
        {},
        'XF86MonBrightnessDown',
        function()
            print('Decreasing brightness')
            awful.spawn('brightnessctl -10% --save')
            awesome.emit_signal('widget::brightness')

            _G.UpdateBrOSD()
        end,
        {description = '-10%', group = 'Hardware'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- volume control
    --
    awful.key(
        {},
        'XF86AudioRaiseVolume',
        function()
            print('Raising volume')
            volume.inc_volume()
            signals.emit_volume_update()
        end,
        {description = 'Volume Up', group = 'Hardware'}
    ),
    -- #############################################################################
    awful.key(
        {},
        'XF86AudioLowerVolume',
        function()
            print('Lowering volume')
            volume.dec_volume()
            signals.emit_volume_update()
        end,
        {description = 'Volume Down', group = 'Hardware'}
    ),
    -- #############################################################################
    awful.key(
        {},
        'XF86AudioMute',
        function()
            print('Toggeling volume')
            volume.toggle_master()
            signals.emit_volume_update()
        end,
        {description = 'Toggle Mute', group = 'Hardware'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Exit Screen
    --
    awful.key(
        {modkey},
        'Escape',
        function()
            print('Showing Exit Screen')
            _G.exit_screen_show()
        end,
        {description = 'Toggle Exit Screen', group = 'Hardware'}
    ),
    -- ########################################################################
    -- Power Button
    --
    awful.key(
        {},
        'XF86PowerOff',
        function()
            print('Showing Exit Screen')
            _G.exit_screen_show()
        end,
        {description = 'Toggle Exit Screen', group = 'Hardware'}
    ),
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Screenshots
    awful.key(
        {},
        'Print',
        function()
            print('Taking A Full Screenshot')

            awful.spawn('bash ' .. HOME .. '/.config/awesome/bin/snapshot.sh full')
        end,
        {description = 'Fullscreen Screenshot', group = 'Utility'}
    ),
    -- #############################################################################
    awful.key(
        {modkey},
        'Print',
        function()
            print('Taking An Area Screenshot')
            awful.spawn('bash ' .. HOME .. '/.config/awesome/bin/snapshot.sh area ')
            client.drawBackdrop = false
        end,
        {description = 'Area/selected Screenshot', group = 'Utility'}
    )
    -- #############################################################################
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Bind all key numbers to tags.
--
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window
    globalKeys =
        awful.util.table.join(
        globalKeys, -- View tag only.
        awful.key(
            {modkey},
            '#' .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                print('Going To Tag: ' .. i)
                if _G.clear_desktop_selection then
                    _G.clear_desktop_selection()
                end
                if tag then
                    tag:view_only()
                end
            end
        ),
        -- #############################################################################
        -- Toggle tag display.
        awful.key(
            {modkey, 'Control'},
            '#' .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                print('Toggling Tag: ' .. i)
                if _G.clear_desktop_selection then
                    _G.clear_desktop_selection()
                end
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end
        ),
        -- #############################################################################
        -- Move client to tag.
        awful.key(
            {modkey, 'Shift'},
            '#' .. i + 9,
            function()
                print('Moving Client To Tag: ' .. i)
                if _G.clear_desktop_selection then
                    _G.clear_desktop_selection()
                end

                if _G.client.focus then
                    local tag = _G.client.focus.screen.tags[i]
                    if tag then
                        _G.client.focus:move_to_tag(tag)
                    end
                end
            end
        ),
        -- #############################################################################
        -- Toggle tag on focused client.
        awful.key(
            {modkey, 'Control', 'Shift'},
            '#' .. i + 9,
            function()
                print('Toggling Tag ' .. i .. ' Focused Client')
                if _G.clear_desktop_selection then
                    _G.clear_desktop_selection()
                end

                if _G.client.focus then
                    local tag = _G.client.focus.screen.tags[i]
                    if tag then
                        _G.client.focus:toggle_tag(tag)
                    end
                end
            end
        )
    )
end

return globalKeys
