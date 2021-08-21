--  _______ __         __           __      __  __
-- |     __|  |.-----.|  |--.---.-.|  |    |  |/  |.-----.--.--.-----.
-- |    |  |  ||  _  ||  _  |  _  ||  |    |     < |  -__|  |  |__ --|
-- |_______|__||_____||_____|___._||__|    |__|\__||_____|___  |_____|
--                                                       |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Contains Global Keys
local gears = require 'gears'
local awful = require 'awful'
local hotkeys_popup = require 'awful.hotkeys_popup'
local helpers = require 'helpers'
-- Custom modules
local bling = require 'module.bling'
local lockscreen = require 'ui.lockscreen'
local HOME = os.getenv 'HOME'
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Mouse Bindings
-- Scrolling to change workspaces is more annoying than a high school cafeteria
-- but the structure is still here in case I want to add other functions to the mouse
-- not elsewhere defined.
--awful.mouse.append_global_mousebindings {}
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Client and Tabs Bindings
awful.keyboard.append_global_keybindings {
    -- ########################################################################
    awful.key(
        {'Mod1'},
        'a',
        function()
            bling.module.tabbed.pick_with_dmenu()
        end,
        {description = 'pick client to add to tab group', group = 'tabs'}
    ),
    -- ===================================================================================
    awful.key(
        {'Mod1'},
        's',
        function()
            bling.module.tabbed.iter()
        end,
        {description = 'iterate through tabbing group', group = 'tabs'}
    ),
    -- ===================================================================================
    awful.key(
        {'Mod1'},
        'd',
        function()
            bling.module.tabbed.pop()
        end,
        {
            description = 'remove focused client from tabbing group',
            group = 'tabs'
        }
    ), --
    -- ########################################################################
    awful.key(
        {'Mod1'},
        'Down',
        function()
            awful.client.focus.bydirection 'down'
            bling.module.flash_focus.flashfocus(client.focus)
        end,
        {description = 'focus down', group = 'Client'}
    ),
    -- =========================================================================

    awful.key(
        {'Mod1'},
        'Up',
        function()
            awful.client.focus.bydirection 'up'
            bling.module.flash_focus.flashfocus(client.focus)
        end,
        {description = 'focus up', group = 'Client'}
    ),
    -- =========================================================================

    awful.key(
        {'Mod1'},
        'Left',
        function()
            awful.client.focus.bydirection 'left'
            bling.module.flash_focus.flashfocus(client.focus)
        end,
        {description = 'focus left', group = 'Client'}
    ),
    -- =========================================================================

    awful.key(
        {'Mod1'},
        'Right',
        function()
            awful.client.focus.bydirection 'right'
            bling.module.flash_focus.flashfocus(client.focus)
        end,
        {description = 'focus right', group = 'Client'}
    ),
    -- =========================================================================

    awful.key(
        {'Mod1'},
        'j',
        function()
            awful.client.focus.byidx(1)
        end,
        {description = 'focus next by index', group = 'Client'}
    ),
    -- =========================================================================

    awful.key(
        {'Mod1'},
        'k',
        function()
            awful.client.focus.byidx(-1)
        end,
        {description = 'focus previous by index', group = 'Client'}
    ),
    -- =========================================================================

    awful.key(
        {'Mod1', 'Shift'},
        'j',
        function()
            awful.client.swap.byidx(1)
        end,
        {description = 'swap with next client by index', group = 'Client'}
    ),
    -- =========================================================================

    awful.key(
        {'Mod1', 'Shift'},
        'k',
        function()
            awful.client.swap.byidx(-1)
        end,
        {
            description = 'swap with previous client by index',
            group = 'Client'
        }
    ),
    -- =========================================================================
    awful.key({'Mod1'}, 'u', awful.client.urgent.jumpto, {description = 'jump to urgent client', group = 'Client'})
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Global Bindings
awful.keyboard.append_global_keybindings {
    -- Lockscreen
    awful.key(
        {modkey, 'Control', 'Shift'},
        'l',
        function()
            print('Locking screen')
            lockscreen.init()
        end,
        {
            description = 'Lock The Screen',
            group = 'Awesome'
        }
    ),
    -- =========================================================================
    -- Key Help Menu
    awful.key(
        {modkey},
        'F1',
        hotkeys_popup.show_help,
        {
            description = 'Show Key Bindings',
            group = 'Awesome'
        }
    ),
    -- =========================================================================
    awful.key(
        {modkey},
        'F2',
        function()
            awful.spawn('firefox')
        end,
        {
            description = 'Launch Firefox',
            group = 'Launcher'
        }
    ),
    -- =========================================================================
    awful.key(
        {modkey, 'Shift'},
        'F2',
        function()
            awful.spawn('buku_run')
        end,
        {
            description = 'Launch Buku Rofi Menu',
            group = 'Launcher'
        }
    ),
    -- =========================================================================

    awful.key(
        {modkey, 'Control'},
        'F2',
        function()
            awful.spawn('chrome')
        end,
        {
            description = 'Launch Chrome',
            group = 'Launcher'
        }
    ),
    -- =========================================================================

    awful.key(
        {modkey},
        'F3',
        function()
            awful.spawn('thunar')
        end,
        {
            description = 'Launch file Manager',
            group = 'Launcher'
        }
    ),
    -- =========================================================================

    awful.key(
        {modkey, 'Control'},
        'F3',
        function()
            awful.spawn('gksu thunar')
        end,
        {
            description = 'Launch file Manager as Root',
            group = 'Launcher'
        }
    ),
    -- =========================================================================

    awful.key(
        {modkey, 'Shift'},
        'F3',
        function()
            awful.spawn('kitty -e ranger')
        end,
        {
            description = 'Launch Terminal file Manager',
            group = 'Launcher'
        }
    ),
    -- =========================================================================
    awful.key(
        {modkey},
        'F4',
        function()
            awful.spawn.easy_async_with_shell('~/.config/awesome/ui/fontawesome_menu/fontawesome-menu')
        end,
        {
            description = 'Copy Font - Awesome Icons to Clipboard',
            group = 'Launcher'
        }
    ),
    -- #############################################################################
    awful.key(
        {modkey, 'Control'},
        'F4',
        function()
            awful.spawn.easy_async_with_shell('~/.config/awesome/ui/fontawesome_menu/emoji.sh')
        end,
        {description = 'Copy bin/emojis to Clipboard', group = 'Launcher'}
    ),
    -- =========================================================================
    awful.key(
        {modkey},
        'Return',
        function()
            awful.spawn(terminal)
        end,
        {
            description = 'Open Terminal',
            group = 'Launcher'
        }
    ),
    -- =========================================================================
    awful.key(
        {modkey, 'Control'},
        'Escape',
        function()
            awful.spawn('bash ' .. HOME .. '/.config/awesome/ui/appmenu/applauncher.sh ')
        end,
        {
            description = 'Open App Menu',
            group = 'Launcher'
        }
    ),
    -- =========================================================================
    -- Volume control
    awful.key(
        {},
        'XF86AudioRaiseVolume',
        function()
            awful.spawn 'pamixer -i 3'
        end,
        {description = 'increase volume', group = 'Awesome'}
    ),
    -- =========================================================================

    awful.key(
        {},
        'XF86AudioLowerVolume',
        function()
            awful.spawn 'pamixer -d 3'
        end,
        {description = 'decrease volume', group = 'Awesome'}
    ),
    -- =========================================================================

    awful.key(
        {},
        'XF86AudioMute',
        function()
            awful.spawn 'pamixer -t'
        end,
        {description = 'mute volume', group = 'Awesome'}
    ),
    -- =========================================================================

    -- Media Control
    awful.key(
        {},
        'XF86AudioPlay',
        function()
            awful.spawn 'playerctl play-pause'
        end,
        {description = 'toggle playerctl', group = 'Awesome'}
    ),
    -- =========================================================================

    awful.key(
        {},
        'XF86AudioPrev',
        function()
            awful.spawn 'playerctl previous'
        end,
        {description = 'playerctl previous', group = 'Awesome'}
    ),
    -- =========================================================================

    awful.key(
        {},
        'XF86AudioNext',
        function()
            awful.spawn 'playerctl next'
        end,
        {description = 'playerctl next', group = 'Awesome'}
    ),
    -- =========================================================================

    -- Screen Shots/Vids
    awful.key(
        {},
        'Print',
        function()
            awful.spawn.with_shell 'shoot'
        end,
        {description = 'take a screenshot', group = 'Awesome'}
    ),
    -- =========================================================================

    awful.key(
        {modkey},
        'Print',
        function()
            awful.spawn.with_shell 'shoot selnp'
        end,
        {
            description = 'take a selection with no pads',
            group = 'Awesome'
        }
    ),
    -- =========================================================================
    awful.key(
        {modkey, 'Shift'},
        'Print',
        function()
            awful.spawn.with_shell 'shoot sel'
        end,
        {description = 'take a selection with pads', group = 'Awesome'}
    ),
    -- =========================================================================
    -- Brightness
    awful.key(
        {},
        'XF86MonBrightnessUp',
        function()
            awful.spawn 'brightnessctl s +5%'
        end,
        {description = 'increase brightness', group = 'Awesome'}
    ),
    -- =========================================================================

    awful.key(
        {},
        'XF86MonBrightnessDown',
        function()
            awful.spawn 'brightnessctl s 5%-'
        end,
        {description = 'decrease brightness', group = 'Awesome'}
    ),
    -- =========================================================================

    -- ColorPicker
    awful.key(
        {modkey},
        'p',
        function()
            awful.spawn 'farge --notify'
        end,
        {description = 'color picker', group = 'Awesome'}
    ),
    -- =========================================================================

    -- Awesome stuff
    awful.key({modkey}, 'F1', hotkeys_popup.show_help, {description = 'show help', group = 'Awesome'}),
    -- =========================================================================

    awful.key({modkey}, 'Escape', awful.tag.history.restore, {description = 'go back', group = 'Tag'}),
    -- =========================================================================

    awful.key(
        {modkey, shift},
        'd',
        function()
            awesome.emit_signal('widgets::start::toggle', mouse.screen)
        end,
        {description = 'show panel', group = 'Awesome'}
    ),
    -- =========================================================================

    awful.key(
        {modkey},
        'Escape',
        function()
            awesome.emit_signal 'widgets::exit_screen::toggle'
        end,
        {description = 'show exit screen', group = 'Awesome'}
    ),
    -- =========================================================================
    -- Restart Awesome.
    -- The default adds Control which is annoying af
    awful.key({modkey}, 'r', awesome.restart, {description = 'reload awesome', group = 'Awesome'}),
    -- ########################################################################

    awful.key({modkey, 'Shift'}, 'q', awesome.quit, {description = 'quit awesome', group = 'Awesome'})
}
-- Launcher and screen
awful.keyboard.append_global_keybindings {
    awful.key(
        {modkey, 'Control'},
        'j',
        function()
            awful.screen.focus_relative(1)
        end,
        {description = 'focus the next screen', group = 'screen'}
    ),
    -- =========================================================================

    awful.key(
        {modkey, 'Control'},
        'k',
        function()
            awful.screen.focus_relative(-1)
        end,
        {description = 'focus the previous screen', group = 'screen'}
    ),
    -- =========================================================================

    awful.key(
        {modkey},
        'd',
        function()
            awful.spawn(launcher)
        end,
        {description = 'show rofi ', group = 'launcher'}
    ),
    -- =========================================================================

    -- Standard program
    awful.key(
        {modkey},
        't',
        function()
            awful.spawn(terminal)
        end,
        {description = 'open a terminal', group = 'launcher'}
    ),
    -- =========================================================================

    awful.key(
        {modkey},
        's',
        function()
            awesome.emit_signal 'scratch::music'
        end,
        {description = 'open music', group = 'scratchpad'}
    ),
    -- =========================================================================

    awful.key(
        {modkey},
        'z',
        function()
            awesome.emit_signal 'widgets::peek'
        end,
        {description = 'peek', group = 'Client'}
    ),
    -- =========================================================================

    awful.key(
        {modkey},
        'Right',
        function()
            awful.tag.incmwfact(0.05)
        end,
        {description = 'increase master width factor', group = 'Layout'}
    ),
    -- =========================================================================

    awful.key(
        {modkey},
        'Left',
        function()
            awful.tag.incmwfact(-0.05)
        end,
        {description = 'decrease master width factor', group = 'Layout'}
    ),
    -- =========================================================================

    awful.key(
        {modkey, 'Shift'},
        'h',
        function()
            awful.tag.incnmaster(1, nil, true)
        end,
        {
            description = 'increase the number of master clients',
            group = 'Layout'
        }
    ),
    -- =========================================================================
    awful.key(
        {modkey, 'Shift'},
        'l',
        function()
            awful.tag.incnmaster(-1, nil, true)
        end,
        {
            description = 'decrease the number of master clients',
            group = 'Layout'
        }
    ),
    -- =========================================================================
    awful.key(
        {modkey, 'Control'},
        'h',
        function()
            awful.tag.incncol(1, nil, true)
        end,
        {
            description = 'increase the number of columns',
            group = 'Layout'
        }
    ),
    -- =========================================================================
    awful.key(
        {modkey, 'Control'},
        'l',
        function()
            awful.tag.incncol(-1, nil, true)
        end,
        {
            description = 'decrease the number of columns',
            group = 'Layout'
        }
    ),
    -- =========================================================================
    awful.key(
        {modkey},
        'space',
        function()
            awful.layout.inc(1)
        end,
        {description = 'select next', group = 'Layout'}
    ),
    -- =========================================================================

    awful.key(
        {modkey, 'Shift'},
        'space',
        function()
            awful.layout.inc(-1)
        end,
        {description = 'select previous', group = 'Layout'}
    ),
    -- =========================================================================

    -- Set Layout
    awful.key(
        {modkey, 'Control'},
        'w',
        function()
            awful.layout.set(awful.layout.suit.max)
        end,
        {description = 'set max layout', group = 'Tag'}
    ),
    -- =========================================================================

    awful.key(
        {modkey},
        's',
        function()
            awful.layout.set(awful.layout.suit.tile)
        end,
        {description = 'set tile layout', group = 'Tag'}
    ),
    -- =========================================================================

    awful.key(
        {modkey, shift},
        's',
        function()
            awful.layout.set(awful.layout.suit.floating)
        end,
        {description = 'set floating layout', group = 'Tag'}
    ),
    -- =========================================================================

    awful.key(
        {modkey, 'Control'},
        'n',
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal('request::activate', 'key.unminimize', {raise = true})
            end
        end,
        {description = 'restore minimized', group = 'Client'}
    )
}
-- Client management keybinds
client.connect_signal(
    'request::default_keybindings',
    function()
        awful.keyboard.append_client_keybindings {
            awful.key(
                {modkey, 'Shift'},
                'f',
                function(c)
                    c.fullscreen = not c.fullscreen
                    c:raise()
                end,
                {description = 'toggle fullscreen', group = 'Client'}
            ),
            -- ########################################################################
            -- ########################################################################
            -- ########################################################################

            awful.key(
                {modkey},
                'x',
                function(c)
                    c:kill()
                end,
                {description = 'close', group = 'Client'}
            ),
            -- ########################################################################
            -- ########################################################################
            -- ########################################################################

            awful.key(
                {modkey, 'Control'},
                'space',
                awful.client.floating.toggle,
                {description = 'toggle floating', group = 'Client'}
            ),
            -- ########################################################################
            -- ########################################################################
            -- ########################################################################

            awful.key(
                {modkey, 'Control'},
                'Return',
                function(c)
                    c:swap(awful.client.getmaster())
                end,
                {description = 'move to master', group = 'Client'}
            ),
            -- ########################################################################
            -- ########################################################################
            -- ########################################################################

            awful.key(
                {modkey},
                'o',
                function(c)
                    c:move_to_screen()
                end,
                {description = 'move to screen', group = 'Client'}
            ),
            -- ########################################################################
            -- ########################################################################
            -- ########################################################################

            awful.key(
                {modkey, 'Shift'},
                't',
                function(c)
                    c.ontop = not c.ontop
                end,
                {description = 'toggle keep on top', group = 'Client'}
            ),
            -- ########################################################################
            -- ########################################################################
            -- ########################################################################

            awful.key(
                {modkey, shift},
                'b',
                function(c)
                    c.floating = not c.floating
                    c.width = 400
                    c.height = 200
                    awful.placement.bottom_right(c)
                    c.sticky = not c.sticky
                end,
                {description = 'toggle keep on top', group = 'Client'}
            ),
            -- ########################################################################
            -- ########################################################################
            -- ########################################################################

            awful.key(
                {modkey},
                'n',
                function(c)
                    -- The client currently has the input focus, so it cannot be
                    -- minimized, since minimized clients can't have the focus.
                    c.minimized = true
                end,
                {description = 'minimize', group = 'Client'}
            ),
            -- ########################################################################
            -- ########################################################################
            -- ########################################################################

            awful.key(
                {modkey},
                'm',
                function(c)
                    c.maximized = not c.maximized
                    c:raise()
                end,
                {description = '(un)maximize', group = 'Client'}
            ),
            -- ########################################################################
            -- ########################################################################
            -- ########################################################################

            awful.key(
                {modkey, 'Control'},
                'm',
                function(c)
                    c.maximized_vertical = not c.maximized_vertical
                    c:raise()
                end,
                {description = '(un)maximize vertically', group = 'Client'}
            ),
            -- ########################################################################
            -- ########################################################################
            -- ########################################################################

            awful.key(
                {modkey, 'Shift'},
                'm',
                function(c)
                    c.maximized_horizontal = not c.maximized_horizontal
                    c:raise()
                end,
                {description = '(un)maximize horizontally', group = 'Client'}
            ),
            -- ########################################################################
            -- ########################################################################
            -- ########################################################################

            -- On the fly padding change
            awful.key(
                {modkey, shift},
                '=',
                function()
                    helpers.resize_padding(5)
                end,
                {description = 'add padding', group = 'screen'}
            ),
            -- ########################################################################
            -- ########################################################################
            -- ########################################################################

            awful.key(
                {modkey, shift},
                '-',
                function()
                    helpers.resize_padding(-5)
                end,
                {description = 'subtract padding', group = 'screen'}
            ),
            -- ########################################################################
            -- ########################################################################
            -- ########################################################################

            -- On the fly useless gaps change
            awful.key(
                {modkey},
                '=',
                function()
                    helpers.resize_gaps(5)
                end,
                {description = 'add gaps', group = 'screen'}
            ),
            -- ########################################################################
            -- ########################################################################
            -- ########################################################################

            awful.key(
                {modkey},
                '-',
                function()
                    helpers.resize_gaps(-5)
                end,
                {description = 'subtract gaps', group = 'screen'}
            ),
            -- Single tap: Center client
            -- Double tap: Center client + Floating + Resize
            awful.key(
                {modkey},
                'c',
                function(c)
                    awful.placement.centered(
                        c,
                        {
                            honor_workarea = true,
                            honor_padding = true
                        }
                    )
                    helpers.single_double_tap(
                        nil,
                        function()
                            helpers.float_and_resize(c, screen_width * 0.25, screen_height * 0.28)
                        end
                    )
                end
            ),
            -- ########################################################################

            awful.key(
                {modkey, 'Shift'},
                'Up',
                function(c)
                    c:relative_move(0, dpi(-10), 0, dpi(10))
                end,
                {
                    description = 'increase floating client size vertically by 10 px up',
                    group = 'Client'
                }
            ),
            -- ########################################################################

            awful.key(
                {modkey, 'Shift'},
                'Down',
                function(c)
                    c:relative_move(0, 0, 0, dpi(10))
                end,
                {
                    description = 'increase floating client size vertically by 10 px down',
                    group = 'Client'
                }
            ),
            -- ########################################################################

            awful.key(
                {modkey, 'Shift'},
                'Left',
                function(c)
                    c:relative_move(dpi(-10), 0, dpi(10), 0)
                end,
                {
                    description = 'increase floating client size horizontally by 10 px left',
                    group = 'Client'
                }
            ),
            -- ########################################################################

            awful.key(
                {modkey, 'Shift'},
                'Right',
                function(c)
                    c:relative_move(0, 0, dpi(10), 0)
                end,
                {
                    description = 'increase floating client size horizontally by 10 px right',
                    group = 'Client'
                }
            ),
            -- ########################################################################

            awful.key(
                {modkey, 'Control'},
                'Up',
                function(c)
                    if c.height > 10 then
                        c:relative_move(0, 0, 0, dpi(-10))
                    end
                end,
                {
                    description = 'decrease floating client size vertically by 10 px up',
                    group = 'Client'
                }
            ),
            -- ########################################################################

            awful.key(
                {modkey, 'Control'},
                'Down',
                function(c)
                    local c_height = c.height
                    c:relative_move(0, 0, 0, dpi(-10))
                    if c.height ~= c_height and c.height > 10 then
                        c:relative_move(0, dpi(10), 0, 0)
                    end
                end,
                {
                    description = 'decrease floating client size vertically by 10 px down',
                    group = 'Client'
                }
            ),
            -- ########################################################################

            awful.key(
                {modkey, 'Control'},
                'Left',
                function(c)
                    if c.width > 10 then
                        c:relative_move(0, 0, dpi(-10), 0)
                    end
                end,
                {
                    description = 'decrease floating client size horizontally by 10 px left',
                    group = 'Client'
                }
            ),
            -- ########################################################################

            awful.key(
                {modkey, 'Control'},
                'Right',
                function(c)
                    local c_width = c.width
                    c:relative_move(0, 0, dpi(-10), 0)
                    if c.width ~= c_width and c.width > 10 then
                        c:relative_move(dpi(10), 0, 0, 0)
                    end
                end,
                {
                    description = 'decrease floating client size horizontally by 10 px right',
                    group = 'Client'
                }
            ),
            -- ########################################################################

            awful.key(
                {modkey, 'Control', 'Shift'},
                'Up',
                function(c)
                    c.height = mouse.screen.workarea.height / 2
                    c.width = mouse.screen.workarea.width / 2

                    c.x = mouse.screen.workarea.width / 2 - client.focus.width / 2
                    c.y = mouse.screen.workarea.height / 2 - client.focus.height / 2 + mouse.screen.workarea.y
                end,
                {
                    description = 'Center Floating Client',
                    group = 'Client'
                }
            ),
            -- ########################################################################

            awful.key(
                {modkey, 'Control', 'Shift'},
                'Down',
                function(c)
                    c.width = mouse.screen.workarea.width * 0.75

                    c.height = mouse.screen.workarea.height * 0.90
                end,
                {
                    description = 'Resize Floating Client to w75/h90',
                    group = 'Client'
                }
            ),
            -- ########################################################################

            awful.key(
                {modkey, 'Control', 'Shift'},
                'Left',
                function(c)
                    c.width = mouse.screen.workarea.width * 0.45

                    c.height = mouse.screen.workarea.height * 0.45
                end,
                {
                    description = 'Resize Floating Client to w45/h45',
                    group = 'Client'
                }
            ),
            -- ########################################################################

            awful.key(
                {modkey, 'Control', 'Shift'},
                'Right',
                function(c)
                    c.width = mouse.screen.workarea.width * 0.95

                    c.height = mouse.screen.workarea.height * 0.95
                end,
                {
                    description = 'Resize Floating Client to w95/h95',
                    group = 'Client'
                }
            )
        }
    end
)
-- Num row keybinds
awful.keyboard.append_global_keybindings {
    awful.key {
        modifiers = {modkey},
        keygroup = 'numrow',
        description = 'only view tag',
        group = 'Tag',
        on_press = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end
    },
    awful.key {
        modifiers = {modkey, 'Control'},
        keygroup = 'numrow',
        description = 'toggle tag',
        group = 'Tag',
        on_press = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end
    },
    awful.key {
        modifiers = {modkey, 'Shift'},
        keygroup = 'numrow',
        description = 'move focused client to tag',
        group = 'Tag',
        on_press = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end
    },
    awful.key {
        modifiers = {modkey, 'Control', 'Shift'},
        keygroup = 'numrow',
        description = 'toggle focused client on tag',
        group = 'Tag',
        on_press = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end
    },
    awful.key {
        modifiers = {modkey},
        keygroup = 'numpad',
        description = 'select layout directly',
        group = 'Layout',
        on_press = function(index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end
    }
}
client.connect_signal(
    'request::default_mousebindings',
    function()
        awful.mouse.append_client_mousebindings {
            awful.button(
                {},
                1,
                function(c)
                    c:activate {context = 'mouse_click'}
                end
            ),
            awful.button(
                {modkey},
                1,
                function(c)
                    c:activate {context = 'mouse_click', action = 'mouse_move'}
                end
            ),
            awful.button(
                {modkey},
                3,
                function(c)
                    c:activate {context = 'mouse_click', action = 'mouse_resize'}
                end
            )
        }
    end
)
-- EOF ------------------------------------------------------------------------
