--  ______         __
-- |   __ \.--.--.|  |.-----.-----.
-- |      <|  |  ||  ||  -__|__ --|
-- |___|__||_____||__||_____|_____|
-- ------------------------------------------------- --
-- This requires the development branch of Awesome or it will throw an
-- error as `ruled` was included after the release of Awesome 4.3
-- ------------------------------------------------- --
ruled.client.connect_signal(
    'request::rules',
    function()
        -- ------------------------------------------------- --
        -- ---------------------- ALL ---------------------- --
        -- All clients will match this rule
        --
        ruled.client.append_rule {
            id = 'global',
            rule = {},
            properties = {
                focus = awful.client.focus.filter,
                raise = true,
                maximized = false,
                above = false,
                below = false,
                size_hints_honor = false,
                ontop = false,
                honor_padding = true,
                honor_workarea = true,
                sticky = false,
                maximized_horizontal = false,
                maximized_vertical = false,
                keys = client_keys,
                buttons = client_buttons,
                -- screen = awful.screen.preferred,
                -- most durable (so far) solution to insuring the window dialogs are
                -- on screen with the parent window and the screens open on the screen
                -- where the mouse is. The joys of awesomewm
                screen = function(c)
                    if awesome.startup then
                        return c.screen
                    else
                        return awful.screen.focused(c)
                    end
                end,
                shape = beautiful.client_shape_rounded_lg
            }
        }
        -- ------------------------------------------------- --
        -- ----------------- Titlebar rules ---------------- --
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
            except_any = {
                name = {'Discord Updater'}
            },
            properties = {
                titlebars_enabled = true,
                round_corners = true,
                shape = beautiful.client_shape_rounded_lg
            }
        }

        -- ------------------------------------------------- --
        -- -------------------- Dialogs -------------------- --
        --
        ruled.client.append_rule {
            id = 'dialog',
            rule_any = {
                type = {'dialog'},
                class = {
                    'Wicd-client.py',
                    'calendar.google.com'
                }
            },
            properties = {
                titlebars_enabled = true,
                floating = true,
                above = true
            }
        }
        -- ------------------------------------------------- --
        -- --------------------- Modals -------------------- --
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
                skip_decoration = true
            }
        }
        -- ------------------------------------------------- --
        -- ------------------- Utilities ------------------- --
        --
        ruled.client.append_rule {
            id = 'utility',
            rule_any = {
                type = {'utility'}
            },
            properties = {
                titlebars_enabled = false,
                floating = true
            }
        }
        -- ------------------------------------------------- --
        -- --------------------- Splash -------------------- --
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
                skip_decoration = true
            }
        }
        -- ------------------------------------------------- --
        -- --------------- Terminal emulators -------------- --
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
                    'tym',
                    'K3rmit'
                }
            },
            properties = {
                size_hints_honor = true,
                titlebars_enabled = true
            }
        }

        -- ------------------------------------------------- --
        -- ----------------- Image viewers ----------------- --
        --
        ruled.client.append_rule {
            id = 'image_viewers',
            rule_any = {
                class = {
                    'feh',
                    'Pqiv',
                    'Sxiv',
                    'imv'
                }
            },
            properties = {
                titlebars_enabled = true,
                skip_decoration = true,
                floating = true,
                ontop = true
            }
        }
        -- ------------------------------------------------- --
        -- --------------- Centered Placement -------------- --
        -- ruled.client.append_rule {
        --     id = 'center_placement',
        --     rule_any = {
        --         type = {'dialog', 'modal', 'utility', 'splash'},
        --         class = {
        --             'Steam',
        --             'discord',
        --             'markdown_input',
        --             'scratchpad',
        --             'feh',
        --             'Pqiv',
        --             'Sxiv',
        --             'imv'
        --         },
        --         instance = {'markdown_input', 'scratchpad'},
        --         role = {'GtkFileChooserDialog', 'conversation'}
        --     },
        --     properties = {
        --         placement = awful.placement.center + awful.placement.no_offscreen
        --     }
        -- }
        -- ------------------------------------------------- --
        -- -------------------- Floating ------------------- --
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
                ontop = true,
                floating = true,
                raise = true
            }
        }
        -- ------------------------------------------------- --
        ruled.client.append_rule {
            id = 'floating_not_top',
            rule_any = {
                class = {
                    'virt-manager',
                    'Virt-manager',
                    'VirtualBox Manager',
                    'VirtualBox Manager',
                    'mate-color-select',
                    'Mate-color-select'
                }
            },
            properties = {
                titlebars_enabled = true,
                ontop = false,
                floating = true,
                raise = true
            }
        }
    end
)
