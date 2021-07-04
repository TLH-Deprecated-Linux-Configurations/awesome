--  _______ __         __           __      __  __
-- |     __|  |.-----.|  |--.---.-.|  |    |  |/  |.-----.--.--.-----.
-- |    |  |  ||  _  ||  _  |  _  ||  |    |     < |  -__|  |  |__ --|
-- |_______|__||_____||_____|___._||__|    |__|\__||_____|___  |_____|
--                                                       |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
require("awful.autofocus")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local has_package_installed = require("lib.hardware-check").has_package_installed
require("awful.hotkeys_popup.keys")

local config = require("configuration.keys.mod")
local modkey = config.modKey
local altkey = config.altKey
local apps = require("configuration.apps")
local xrandr = require("module.xrandr")
local signals = require("module.signals")
local volume = require("lib.volume")
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- returns true if we cannot create a screenshot
local function send_notification_if_maim_missing()
    if not has_package_installed("maim") then
        require("naughty").notification(
            {
                title = "Cannot create screenshot",
                message = "maim is not installed",
                app_name = "Package Notifier"
            }
        )
        return true
    end
    return false
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Key bindings
local globalKeys =
    awful.util.table.join( -- Hotkeys
    awful.key(
        {modkey},
        "F1",
        hotkeys_popup.show_help,
        {
            description = "Show Key Bindings",
            group = "Awesome"
        }
    ),
    -- #############################################################################

    -- Custom Keys
    awful.key(
        {modkey},
        "y",
        function()
            xrandr.xrandr()
        end,
        {
            description = "Launch Screen Layout Selector",
            group = "Launcher"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey},
        "Return",
        function()
            print("Spawning terminal")
            awful.spawn(apps.default.terminal)
        end,
        {
            description = "Open Terminal",
            group = "Launcher"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey},
        "b",
        function()
            print("Spawning rofi window switcher")
            awful.spawn(apps.default.rofiwindowswitch)
        end,
        {
            description = "Open a Window Switcher",
            group = "Launcher"
        }
    ),
    -- #############################################################################

    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    awful.key(
        {modkey, "Control"},
        "Escape",
        function()
            print("Spawning rofi app menu")
            awful.spawn(apps.default.rofiappmenu)
        end,
        {
            description = "Open Rofi",
            group = "Launcher"
        }
    ),
    -- #############################################################################

    -- #############################################################################
    awful.key(
        {modkey},
        "F2",
        function()
            print("Spawning Firefox")

            awful.spawn("firefox")
        end,
        {
            description = "Launch Firefox",
            group = "Launcher"
        }
    ),
    -- #############################################################################
    awful.key(
        {modkey, "Shift"},
        "F2",
        function()
            print("Spawning Buku")
            awful.spawn("buku_run")
        end,
        {
            description = "Launch Buku Rofi Menu",
            group = "Launcher"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey, "Control"},
        "F2",
        function()
            print("Spawning Chrome")

            awful.spawn("chrome")
        end,
        {
            description = "Launch Chrome",
            group = "Launcher"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey},
        "F3",
        function()
            print("Spawning Thunar")

            awful.spawn("thunar")
        end,
        {
            description = "Launch File Manager",
            group = "Launcher"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey, "Control"},
        "F3",
        function()
            print("Spawning Thunar as Root")

            awful.spawn("gksu thunar")
        end,
        {
            description = "Launch File Manager as Root",
            group = "Launcher"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey, "Shift"},
        "F3",
        function()
            print("Spawning Ranger")

            awful.spawn("kitty -e ranger")
        end,
        {
            description = "Launch Terminal File Manager",
            group = "Launcher"
        }
    ),
    -- #############################################################################
    awful.key(
        {modkey},
        "F4",
        function()
            print("Spawning Font Awesome Menu")

            awful.spawn.easy_async_with_shell("~/.config/awesome/external/rofi/fontawesome_menu/fontawesome-menu")
        end,
        {
            description = "Copy Font - Awesome Icons to Clipboard",
            group = "Launcher"
        }
    ), -- #############################################################################
    awful.key(
        {modkey, "Control"},
        "F4",
        function()
            print("Spawning Emoji Pick")

            awful.spawn.easy_async_with_shell("bin/emojipick")
        end,
        {description = "Copy bin/emojis to Clipboard", group = "Launcher"}
    ),
    -- #############################################################################
    awful.key(
        {modkey},
        "F5",
        function()
            print("Spawning Arandr")

            awful.spawn("arandr")
        end,
        {
            description = "open display configuration application",
            group = "Launcher"
        }
    ),
    -- #############################################################################

    -- Dropdown application
    awful.key(
        {modkey},
        "F12",
        function()
            print("Spawning terminal in Quake Mode")

            _G.toggle_quake()
        end,
        {
            description = "dropdown terminal",
            group = "Launcher"
        }
    ),
    -- #############################################################################

    awful.key(
        {"Control", "Mod1"},
        "Delete",
        function()
            print("Opening system monitor")
            awful.spawn.easy_async_with_shell("htop")
        end,
        {
            description = "Open system monitor",
            group = "Launcher"
        }
    ),
    -- #############################################################################

    awful.key(
        {"Mod1"},
        "Tab",
        function()
            print("Tabbing between applications")
            _G.switcher.switch(1, "Mod1", "Alt_L", "Shift", "Tab")
        end,
        {
            description = "Tab between applications",
            group = "Laucher"
        }
    ),
    -- #############################################################################

    awful.key(
        {"Mod1", "Shift"},
        "Tab",
        function()
            print("Reverse tabbing between applications")
            _G.switcher.switch(-1, "Mod1", "Alt_L", "Shift", "Tab")
        end,
        {
            description = "Tab between applications in reverse order",
            group = "Laucher"
        }
    ),
    -- #############################################################################
    -- #############################################################################
    -- Client resize master
    awful.key(
        {modkey},
        "Right",
        function()
            print("Increasing Width")

            awful.tag.incmwfact(0.05)
        end,
        {
            description = "increase master width factor",
            group = "Layout"
        }
    ),
    -- #############################################################################
    awful.key(
        {modkey},
        "Left",
        function()
            print("Decreasing Width")

            awful.tag.incmwfact(-0.05)
        end,
        {
            description = "decrease master width factor",
            group = "Layout"
        }
    ),
    -- #############################################################################
    -- Increase/Decrease numbers of master
    awful.key(
        {modkey},
        "Up",
        function()
            print("Decreasing Number of Master Clients")

            awful.tag.incnmaster(1, nil, true)
        end,
        {
            description = "increase the number of master clients",
            group = "Layout"
        }
    ),
    -- #############################################################################
    awful.key(
        {modkey},
        "Down",
        function()
            print("Decreasing Number of Master Clients")

            awful.tag.incnmaster(-1, nil, true)
        end,
        {
            description = "decrease the number of master clients",
            group = "Layout"
        }
    ),
    -- #############################################################################

    -- Screen Shots
    -- Screen Shot and Save
    awful.key(
        {},
        "Print",
        function()
            print("Taking a full screenshot")
            if not send_notification_if_maim_missing() then
                awful.spawn("snap full")
            end
        end
    ),
    -- #############################################################################

    -- Screen Shot Area and Save
    awful.key(
        {modkey},
        "Print",
        function()
            print("Taking an area screenhot")
            if not send_notification_if_maim_missing() then
                awful.spawn("snap area")
            end
        end
    ),
    -- #############################################################################

    -- Toggle System Tray
    awful.key(
        {modkey},
        "=",
        function()
            print("Toggeling systray visibility")
            awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
        end,
        {
            description = "Toggle systray visibility",
            group = "custom"
        }
    ),
    -- #############################################################################

    -- Tag browsing
    awful.key(
        {modkey},
        "w",
        awful.tag.viewprev,
        {
            description = "view previous",
            group = "tag"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey},
        "a",
        awful.tag.viewnext,
        {
            description = "view next",
            group = "tag"
        }
    ),
    -- #############################################################################

    -- Default client focus
    awful.key(
        {modkey, "Shift"},
        "w",
        function()
            print("Focusing Next By Index")
            awful.client.focus.byidx(1)
        end,
        {
            description = "focus next by index",
            group = "Client"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey, "Shift"},
        "a",
        function()
            print("Focusing Prior By Index")
            awful.client.focus.byidx(-1)
        end,
        {
            description = "focus previous by index",
            group = "Client"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey},
        "g",
        function()
            print("Showing action center")
            _G.screen.primary.left_panel:toggle(true)
        end,
        {
            description = "Open Control panel",
            group = "Launcher"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey},
        "h",
        function()
            print("Toggeling right panel")
            if _G.screen.primary.right_panel ~= nil then
                _G.screen.primary.right_panel:toggle()
            end
        end,
        {
            description = "Open Notification Center",
            group = "Launcher"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey},
        "u",
        awful.client.urgent.jumpto,
        {
            description = "jump to urgent client",
            group = "Client"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey},
        "Tab",
        function()
            print("Backing Up By Index")

            awful.client.focus.history.previous()
            if _G.client.focus then
                _G.client.focus:raise()
            end
        end,
        {
            description = "go back",
            group = "Client"
        }
    ),
    -- #############################################################################

    -- Programs
    awful.key(
        {modkey},
        "l",
        function()
            print("Locking screen")
            awful.spawn(apps.default.lock)
        end,
        {
            description = "lock the screen",
            group = "hotkeys"
        }
    ),
    -- #############################################################################

    -- Standard program
    awful.key(
        {modkey},
        "r",
        _G.awesome.restart,
        {
            description = "reload awesome",
            group = "awesome"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey, "Control"},
        "x",
        _G.awesome.quit,
        {
            description = "quit awesome",
            group = "awesome"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey, "Control"},
        "h",
        function()
            awful.tag.incnplugplug(1, nil, true)
        end,
        {
            description = "increase the number of columns",
            group = "Layout"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey, "Control"},
        "l",
        function()
            awful.tag.incncol(-1, nil, true)
        end,
        {
            description = "decrease the number of columns",
            group = "Layout"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey},
        "space",
        function()
            awful.layout.inc(1)
        end,
        {
            description = "select next",
            group = "Layout"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey, "Shift"},
        "space",
        function()
            awful.layout.inc(-1)
        end,
        {
            description = "select previous",
            group = "Layout"
        }
    ),
    -- #############################################################################
    awful.key(
        {modkey},
        "n",
        function()
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            local c = client.focus
            if c then
                c.minimized = true
            end
        end,
        {description = "minimize", group = "Client"}
    ),
    -- #############################################################################

    awful.key(
        {modkey, "Control"},
        "n",
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                _G.clXient.focus = c
                c:raise()
            end
        end,
        {
            description = "restore minimized",
            group = "Client"
        }
    ),
    -- #############################################################################
    -- Thanks to the Arch Wiki for this snippet, mitigating
    -- the bar not appearing issues that hiding it would
    -- otherwise guarentee

    awful.key(
        {modkey},
        "c",
        function()
            screen = awful.screen.focused()
            screen.bottom_panel.visible = not screen.bottom_panel.visible
        end,
        {description = "Toggle Bottom Bar", group = "Awesome"}
    ),
    -- #############################################################################

    awful.key(
        {modkey},
        "p",
        function()
            print("Opening rofi clipboard")
            awful.spawn(apps.default.roficlipboard)
        end,
        {
            description = "Show clipboard history",
            group = "Utility"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey},
        "s",
        function()
            print("Opening settings application")
            root.elements.settings.enable_view_by_index(-1, mouse.screen)
        end,
        {
            description = "Open settings application",
            group = "Launcher"
        }
    ),
    -- #############################################################################
    -- Brightness
    awful.key(
        {},
        "XF86MonBrightnessUp",
        function()
            print("Increasing brightness")
            if (_G.oled) then
                awful.spawn("brightness -a 5 -F")
            else
                awful.spawn("brightness -s 100 -F") -- reset pixel values when using backlight
                awful.spawn("brightness -a 5")
            end
            awesome.emit_signal("widget::brightness")
            if _G.toggleBriOSD ~= nil then
                _G.toggleBriOSD(true)
            end
            if _G.UpdateBrOSD ~= nil then
                _G.UpdateBrOSD()
            end
        end,
        {
            description = "+10%",
            group = "Hardware"
        }
    ),
    -- #############################################################################

    awful.key(
        {},
        "XF86MonBrightnessDown",
        function()
            print("Decreasing brightness")
            if (_G.oled) then
                awful.spawn("brightness -d 5 -F")
            else
                awful.spawn("brightness -s 100 -F") -- reset pixel values when using backlight
                awful.spawn("brightness -d 5")
            end
            awesome.emit_signal("widget::brightness")
            if _G.toggleBriOSD ~= nil then
                _G.toggleBriOSD(true)
            end
            if _G.UpdateBrOSD ~= nil then
                _G.UpdateBrOSD()
            end
        end,
        {
            description = "-10%",
            group = "Hardware"
        }
    ),
    -- #############################################################################

    -- ALSA volume control
    awful.key(
        {},
        "XF86AudioRaiseVolume",
        function()
            print("Raising volume")
            volume.inc_volume()
            signals.emit_volume_update()
        end,
        {
            description = "volume up",
            group = "Hardware"
        }
    ),
    -- #############################################################################

    awful.key(
        {},
        "XF86AudioLowerVolume",
        function()
            print("Lowering volume")
            volume.dec_volume()
            signals.emit_volume_update()
        end,
        {
            description = "volume down",
            group = "Hardware"
        }
    ),
    -- #############################################################################

    awful.key(
        {},
        "XF86AudioMute",
        function()
            print("Toggeling volume")
            volume.toggle_master()
            signals.emit_volume_update()
        end,
        {
            description = "toggle mute",
            group = "Hardware"
        }
    ),
    -- #############################################################################

    awful.key(
        {},
        "XF86AudioNext",
        function()
            print("Pressed Audio Next")
        end,
        {
            description = "toggle mute",
            group = "Hardware"
        }
    ),
    -- #############################################################################
    awful.key(
        {modkey},
        "Escape",
        function()
            print("Showing exit screen")
            _G.exit_screen_show()
        end,
        {
            description = "toggle exit screen",
            group = "Hardware"
        }
    ),
    -- #############################################################################

    awful.key(
        {},
        "XF86PowerOff",
        function()
            print("Showing exit screen")
            _G.exit_screen_show()
        end,
        {
            description = "toggle exit screen",
            group = "Hardware"
        }
    ),
    -- #############################################################################

    awful.key(
        {},
        "XF86Display",
        function()
            print("Spawning arandr")
            awful.spawn("arandr")
        end,
        {description = "arandr", group = "Awesome"}
    ),
    -- #############################################################################

    -- Music player keys
    awful.key(
        {},
        "XF86AudioPlay",
        function()
            print("toggeling music")
            awful.spawn("playerctl play-pause")
        end,
        {
            description = "toggle music",
            group = "Hardware"
        }
    ),
    -- #############################################################################

    awful.key(
        {},
        "XF86AudioPause",
        function()
            print("toggeling music")
            awful.spawn("playerctl play-pause")
        end,
        {
            description = "toggle music",
            group = "Hardware"
        }
    ),
    -- #############################################################################

    awful.key(
        {},
        "XF86AudioPrev",
        function()
            print("Previous song")
            awful.spawn("playerctl previous")
        end,
        {
            description = "Previous Song",
            group = "Hardware"
        }
    ),
    -- #############################################################################

    awful.key(
        {},
        "XF86AudioNext",
        function()
            print("Next song")
            awful.spawn("playerctl next")
        end,
        {
            description = "Next Song",
            group = "Hardware"
        }
    ),
    -- #############################################################################

    awful.key(
        {},
        "Print",
        function()
            print("Taking a full screenshot")
            if not send_notification_if_maim_missing() then
                if general["window_screen_mode"] == "none" then
                    awful.spawn(apps.bins.full_blank_screenshot)
                else
                    awful.spawn(apps.bins.full_screenshot)
                end
            end
        end,
        {
            description = "Fullscreen Screenshot",
            group = "Utility"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey},
        "Print",
        function()
            print("Taking an area screenshot")
            if not send_notification_if_maim_missing() then
                if general["window_screen_mode"] == "none" then
                    awful.spawn(apps.bins.area_blank_screenshot)
                else
                    awful.spawn(apps.bins.area_screenshot)
                end
            end
        end,
        {
            description = "Area/selected Screenshot",
            group = "Utility"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey, "Shift"},
        "Print",
        function()
            print("Taking a screenshot of a window")
            if not send_notification_if_maim_missing() then
                if general["window_screen_mode"] == "none" then
                    awful.spawn(apps.bins.window_blank_screenshot)
                else
                    awful.spawn(apps.bins.window_screenshot)
                end
            end
        end,
        {
            description = "Window Screenshot",
            group = "Utility"
        }
    )
)
-- Bind all key numbers to tags.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window
    globalKeys =
        awful.util.table.join(
        globalKeys, -- View tag only.
        awful.key(
            {modkey},
            "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                print("Going to tag: " .. i)
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
            {modkey, "Control"},
            "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                print("Toggeling tag: " .. i)
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
            {modkey, "Shift"},
            "#" .. i + 9,
            function()
                print("Moving client to tag: " .. i)
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
            {modkey, "Control", "Shift"},
            "#" .. i + 9,
            function()
                print("Toggeling tag " .. i .. " focused client")
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
