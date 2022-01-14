--  ______         __
-- |   __ \.--.--.|  |.-----.-----.
-- |      <|  |  ||  ||  -__|__ --|
-- |___|__||_____||__||_____|_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- This requires the development branch of Awesome or it will throw an
-- error as `ruled` was included after the release of Awesome 4.3
--
--  And no, I don't use all of the apps that mentioned in these rules,
-- just kept here as a just in case sort of thing for future convenience
-- ########################################################################
-- ########################################################################
-- ########################################################################

ruled.client.connect_signal(
    'request::rules',
    function()
        -- All clients will match this rule.
        --
        ruled.client.append_rule {
            rule = {},
            except_any = {
                instance = {'nm-connection-editor', 'file_progress'}
            },
            properties = {
                focus = awful.client.focus.filter,
                keys = client_keys,
                buttons = client_buttons,
                screen = awful.screen.preferred,
                placement = awful.placement.no_overlap + awful.placement.no_offscreen,
                floating = false,
                maximized = false,
                above = false,
                below = false,
                ontop = false,
                sticky = false,
                maximized_horizontal = false,
                maximized_vertical = false,
                titlebars_enabled = true,
                skip_decoration = false,
                raise = false,
                honor_padding = true,
                honor_workarea = true,
                round_corners = true,
                shape = beautiful.client_shape_rounded
            }
        }

        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Splash
        --
        ruled.client.append_rule {
            id = 'splash',
            rule_any = {
                type = {'splash'},
                name = {'Discord Updater'}
            },
            properties = {
                titlebars_enabled = false,
                round_corners = false,
                floating = true,
                above = true,
                skip_decoration = true,
                placement = awful.placement.centered + awful.placement.no_offscreen
            }
        }

        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Floating
        --
        ruled.client.append_rule {
            {
                rule_any = {
                    instance = {
                        'DTA', -- Firefox addon DownThemAll.
                        'copyq', -- Includes session name in class.
                        'pinentry'
                    },
                    class = {
                        'Arandr',
                        'Blueman-manager',
                        'Gpick',
                        'Kruler',
                        'MessageWin',
                        'feh',
                        'Pqiv',
                        'Sxiv',
                        -- Needs a fixed window size to avoid fingerprinting by screen size.
                        --
                        'Tor Browser',
                        'VirtualBox Machine',
                        'VirtualBox Machine',
                        'Wpa_gui',
                        'veromix',
                        'mini panel',
                        'Popup',
                        'popup',
                        'dialog',
                        'Wicd-client.py',
                        'calendar.google.com',
                        'Dialog',
                        'xtightvncviewer',
                        'Wicd-client.py',
                        'calendar.google.com'
                    },
                    name = {
                        'Event Tester'
                        -- xev.
                    },
                    role = {
                        'AlarmWindow', -- Thunderbird's calendar.
                        'ConfigManager', -- Thunderbird's about:config.
                        'pop-up', -- e.g. Google Chrome's (detached) Developer Tools.
                        'Popup'
                    },
                    type = {'utility', 'dialog', 'modal'}
                },
                properties = {
                    floating = true,
                    ontop = true,
                    raise = true,
                    visible = true
                }
            }
        }
    end
)
