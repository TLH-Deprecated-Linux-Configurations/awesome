-- ########################################################################
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
-- Provides the client rules, which apply properties to clients in general or
-- specific ones because of some quirk of said client requiring modification.
-- This is a highly powerful aspect of awesome that makes it so much more than
-- i3, or its wayland fork (the fork really sucks, no nvidia support? Lame).
-- `
-- This can be used for things like feh, where titlebars and window decorations
-- just mess up its functionality and it needs to be floating if used properly
-- ########################################################################
-- ########################################################################
-- ########################################################################
local client_keys = require("configuration.client.keys")
local client_buttons = require("configuration.client.buttons")
-- All clients will match this rule.
--

awful.rules.rules = {
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
            drawBackdrop = false,
            titlebars_enabled = true,
            skip_decoration = false,
            raise = false,
            honor_padding = true,
            honor_workarea = true
        }
    },
    {
        rule_any = {name = {"QuakeTerminal"}},
        properties = {
            skip_decoration = false,
            titlebars_enabled = true,
            shape = beautiful.btn_lg_shape
        }
    },
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- feh & polkit
    --

    {
        rule_any = {class = {"feh", "Lxpolkit", "xfce-polkit"}},
        properties = {
            skip_decoration = true,
            titlebars_enabled = false,
            floating = true,
            placement = awful.placement.centered,
            ontop = true,
            drawBackdrop = false
        }
    },
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    --
    --
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
            visible = true,
            drawBackdrop = false
        }
    },
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- xlunch fullscreen mode
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
    -- For progress bar when copying or moving
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
    -- awmtt windows
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
            drawBackdrop = false,
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
            placement = awful.placement.centered + awful.placement.no_offscreen,
            ontop = true,
            sticky = true,
            drawBackdrop = false
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
                sticky = true,
                drawBackdrop = false
            }
        }
    },
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    {
        rule_any = {class = {"lxpolkit", "Lxpolkit", "xfce-polkit"}},
        properties = {
            floating = true,
            placement = awful.placement.centered + awful.placement.no_offscreen,
            ontop = true,
            raise = true,
            focus = awful.client.focus.filter,
            drawBackdrop = false
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
        except_any = {
            class = {
                "maim"
            }
        },
        properties = {
            floating = true,
            placement = awful.placement.centered + awful.placement.no_offscreen,
            ontop = true,
            drawBackdrop = false
        }
    }
    -- -- ########################################################################
    -- -- ########################################################################
    -- -- ########################################################################
}
