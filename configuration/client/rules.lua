--  ______         __
-- |   __ \.--.--.|  |.-----.-----.
-- |      <|  |  ||  ||  -__|__ --|
-- |___|__||_____||__||_____|_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- This requires the development branch of Awesome or it will throw an
-- error as `ruled` was included after the release of Awesome 4.3
-- ########################################################################
-- ########################################################################
-- ########################################################################
ruled.client.connect_signal(
    'request::rules',
    function()
        -- All clients will match this rule.
        --
        ruled.client.append_rule {
            id = 'global',
            rule = {},
            properties = {
                focus = awful.client.focus.filter,
                raise = true,
                floating = false,
                maximized = false,
                above = false,
                below = false,
                ontop = false,
                sticky = false,
                maximized_horizontal = false,
                maximized_vertical = false,
                keys = client_keys,
                buttons = client_buttons,
                screen = awful.screen.preferred,
                placement = awful.placement.no_offscreen + awful.placement.centered
            }
        }
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        ruled.client.append_rule {
            id = 'round_clients',
            rule_any = {
                type = {
                    'normal',
                    'dialog',
                    'modal',
                    'utility'
                }
            },
            except_any = {
                name = {'Discord Updater'}
            },
            properties = {
                round_corners = true,
                shape = beautiful.client_shape_rounded
            }
        }
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Titlebar rules
        --
        ruled.client.append_rule {
            id = 'titlebars',
            rule_any = {
                type = {
                    'normal',
                    'dialog',
                    'modal',
                    'utility'
                }
            },
            properties = {
                titlebars_enabled = true
            }
        }
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Dialogs
        --
        ruled.client.append_rule {
            id = 'dialog',
            rule_any = {
                type = {'dialog'},
                class = {'Wicd-client.py', 'calendar.google.com'}
            },
            properties = {
                titlebars_enabled = true,
                floating = true,
                above = true,
                skip_decoration = false,
                placement = awful.placement.centered + awful.placement.no_offscreen
            }
        }
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Modals
        --
        ruled.client.append_rule {
            id = 'modal',
            rule_any = {
                type = {'modal'}
            },
            properties = {
                titlebars_enabled = true,
                floating = true,
                above = true,
                skip_decoration = true,
                placement = awful.placement.centered + awful.placement.no_offscreen
            }
        }
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Utilities
        --
        ruled.client.append_rule {
            id = 'utility',
            rule_any = {
                type = {'utility'}
            },
            properties = {
                titlebars_enabled = false,
                floating = true,
                skip_decoration = true,
                placement = awful.placement.centered + awful.placement.no_offscreen
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
        -- Terminal emulators
        --
        ruled.client.append_rule {
            id = 'terminals',
            rule_any = {
                class = {
                    'URxvt',
                    'XTerm',
                    'Alacritty',
                    'UXTerm',
                    'kitty',
                    'K3rmit'
                }
            },
            properties = {
                size_hints_honor = true,
                titlebars_enabled = true
            }
        }
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Multimedia
        --
        ruled.client.append_rule {
            id = 'multimedia',
            rule_any = {
                class = {
                    'vlc',
                    'Spotify'
                }
            },
            properties = {
                placement = awful.placement.centered + awful.placement.no_offscreen,
                floating = true,
                titlebars_enabled = true,
                size_hints_honor = true
            }
        }
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Image viewers
        --
        ruled.client.append_rule {
            id = 'image_viewers',
            rule_any = {
                class = {
                    'feh',
                    'Pqiv',
                    'Sxiv'
                }
            },
            properties = {
                titlebars_enabled = true,
                size_hints_honor = true,
                skip_decoration = true,
                floating = true,
                ontop = true,
                placement = awful.placement.centered + awful.placement.no_offscreen
            }
        }
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Floating
        --
        ruled.client.append_rule {
            id = 'floating',
            rule_any = {
                instance = {
                    'file_progress',
                    'Popup',
                    'nm-connection-editor'
                },
                class = {
                    'scrcpy',
                    'Mugshot',
                    'Pulseeffects'
                },
                role = {
                    'AlarmWindow',
                    'ConfigManager',
                    'pop-up'
                }
            },
            properties = {
                titlebars_enabled = true,
                skip_decoration = true,
                ontop = true,
                floating = true,
                focus = awful.client.focus.filter,
                raise = true,
                keys = client_keys,
                buttons = client_buttons,
                placement = awful.placement.centered + awful.placement.no_offscreen
            }
        }
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Normally we'd do this with a rule, but some program like spotify doesn't set its class or name
-- until after it starts up, so we need to catch that signal.
client.connect_signal(
    'property::class',
    function(c)
        if c.class == 'Spotify' then
            local window_mode = true

            -- Check if fullscreen or window mode
            if c.fullscreen then
                window_mode = false
                c.fullscreen = false
            else
                window_mode = true
            end

            -- Check if Spotify is already open
            local app = function(c)
                return ruled.client.match(c, {class = 'Spotify'})
            end

            local app_count = 0
            for c in awful.client.iterate(app) do
                app_count = app_count + 1
            end

            -- If Spotify is already open, don't open a new instance
            if app_count > 1 then
                c:kill()
                -- Switch to previous instance
                for c in awful.client.iterate(app) do
                    c:jump_to(false)
                end
            end
        end
    end
)
