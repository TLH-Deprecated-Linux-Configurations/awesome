-- ______ __ __               __
-- |      |  |__|.-----.-----.|  |_
-- |   ---|  |  ||  -__|     ||   _|
-- |______|__|__||_____|__|__||____|
-- ______         __
-- |   __ \.--.--.|  |.-----.-----.
-- |      <|  |  ||  ||  -__|__ --|
-- |___|__||_____||__||_____|_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local client_keys = require("configuration.client.keys")
local client_buttons = require("configuration.client.buttons")
-- Rules
--

awful.rules.rules = {
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- All clients will match this rule.
    --
    {
        rule = {},
        except_any = {
            instance = {"nm-connection-editor", "file_progress"},
            class = "Xfdesktop"
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
            raise = false
        }
    },
    {
        rule_any = {name = {"QuakeTerminal"}},
        properties = {
            skip_decoration = false,
            titlebars_enabled = true,
            shape = function()
                return function(cr, w, h)
                    gears.shape.rounded_rect(cr, w, h, 12)
                end
            end
        }
    },
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Custom
    --
    {
        rule_any = {class = {"feh", "Lxpolkit"}},
        properties = {
            skip_decoration = true,
            titlebars_enabled = false,
            floating = true,
            placement = awful.placement.centered,
            ontop = true
        }
    },
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    {
        rule_any = {
            instance = {
                "DTA", -- Firefox addon DownThemAll.
                "copyq", -- Includes session name in class.
                "pinentry"
            },
            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin",
                -- kalarm.
                "Sxiv",
                "Tor Browser",
                -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
                "mini panel",
                "Popup",
                "popup",
                "dialog",
                "Dialog",
                "xtightvncviewer",
                "Wicd-client.py",
                "calendar.google.com"
            },
            name = {
                "Event Tester"
                -- xev.
            },
            role = {
                "AlarmWindow", -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
                "Popup"
            },
            type = {"utility", "dialog"}
        },
        properties = {
            floating = true,
            ontop = true,
            raise = true,
            visible = true
        }
    },
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    {
        rule_any = {class = {"xlunch-fullscreen"}},
        properties = {fullscreen = true, ontop = true}
    },
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Network Manager Editor
    --
    {
        rule = {instance = "nm-connection-editor"},
        properties = {
            ontop = true,
            floating = true,
            drawBackdrop = false,
            focus = awful.client.focus.filter,
            raise = true,
            keys = client_keys,
            buttons = client_buttons
        }
    },
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- For nemo progress bar when copying or moving
    --
    {
        rule = {instance = "file_progress"},
        properties = {
            ontop = true,
            floating = true,
            drawBackdrop = false,
            focus = awful.client.focus.filter,
            raise = true,
            keys = client_keys,
            buttons = client_buttons
        }
    },
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    {
        rule_any = {class = {"Xephyr"}},
        properties = {
            floating = true,
            placement = awful.placement.centered,
            ontop = true
        }
    },
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Centered
    {
        rule_any = {
            class = {
                "feh",
                "Sxiv",
                "mpv",
                "shellweb"
                -- rss popup
            },
            name = {"Save file", "Page Unresponsive", "Pages Unresponsive"}
        },
        callback = function(c)
            awful.placement.centered(
                c,
                {
                    honor_padding = true,
                    honor_workarea = true
                }
            )
        end
    },
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Additional rules for floating apps
    {
        rule_any = {class = {"feh"}},
        properties = {
            skip_decoration = true,
            floating = true,
            hide_titlebars = true,
            ontop = true,
            placement = awful.placement.centered
        }
    },
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    {
        rule_any = {
            class = {"Toolkit"},
            name = {"Picture-in-Picture", "Picture in picture"}
        },
        properties = {
            floating = true,
            placement = awful.placement.centered,
            ontop = true,
            sticky = true
        }
    },
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    {
        rule_any = {
            class = {"Onboard", "onboard"},
            properties = {
                titlebars_enabled = true,
                focusable = false,
                focus = awful.client.focus.filter,
                ontop = true,
                above = true,
                sticky = true
            }
        }
    },
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    {
        rule_any = {class = {"lxpolkit", "Lxpolkit"}},
        except_any = {type = {"dialog"}},
        properties = {
            floating = true,
            placement = awful.placement.centered + awful.placement.no_offscreen,
            ontop = true,
            raise = true,
            focus = awful.client.focus.filter,
            drawBackdrop = true
        }
    },
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Dialog with blurred background
    {
        rule_any = {
            class = {
                "Pinentry-gtk-2",
                "pinentry-gtk-2",
                "Pinentry-gtk",
                "pinentry-gtk"
            }
        },
        properties = {
            floating = true,
            placement = awful.placement.centered,
            ontop = true,
            drawBackdrop = true
        }
    }
    -- -- ########################################################################
    -- -- ########################################################################
    -- -- ########################################################################
}
