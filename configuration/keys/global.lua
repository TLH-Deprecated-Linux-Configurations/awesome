--  _______ __         __           __      __  __
-- |     __|  |.-----.|  |--.---.-.|  |    |  |/  |.-----.--.--.-----.
-- |    |  |  ||  _  ||  _  |  _  ||  |    |     < |  -__|  |  |__ --|
-- |_______|__||_____||_____|___._||__|    |__|\__||_____|___  |_____|
--                                                       |_____|
local drop = require("lib.attachdrop")
-- ########################################################################
-- ########################################################################

-- ########################################################################
-- ########################################################################
-- ########################################################################

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Key bindings
local globalKeys =
    awful.util.table.join( -- Hotkeys
    --#####################################################################
    awful.key(
        {"Mod1"},
        "Escape",
        function()
            -- If you want to always position the menu on the same place set coordinates
            awful.menu.menu_keys.down = {"Down", "Alt_L"}
            awful.menu.clients({theme = {width = 450}}, {keygrabber = true, coords = {x = 525, y = 330}})
        end,
        {
            description = "Open Window Menu",
            group = "Launcher"
        }
    ),
    --#####################################################################
    awful.key(
        {modkey},
        "Return",
        function()
            print("Spawning Scratch Terminal")
            drop.toggle("kitty", "left", "top", 0.9, 0.9)
            --awful.spawn(apps.default.terminal)
        end,
        {
            description = "Open Scratch Terminal",
            group = "Launcher"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey, "Shift"},
        "Return",
        function()
            print("Spawning terminal")
            -- drop.toggle('kitty', 'left', 'top', 0.8, 0.8)
            awful.spawn(apps.default.terminal)
        end,
        {
            description = "Open Terminal",
            group = "Launcher"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey, "Mod1"},
        "Return",
        function()
            print("Showing all scratch windows")
            drop.showall()
        end,
        {
            description = "Show all scratchpad windows on screen",
            group = "Launcher"
        }
    ),
    -- #############################################################################
    awful.key(
        {modkey, "Control"},
        "Escape",
        function()
            print("Spawning Rofi App Menu")
            awful.spawn(apps.default.rofiappmenu)
        end,
        {
            description = "Open App Menu",
            group = "Launcher"
        }
    ),
    -- #############################################################################
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
    awful.key(
        {modkey},
        "F2",
        function()
            print("Spawning Firefox Instance")
            awful.spawn("firefox")
        end,
        {
            description = "Launch New Firefox Instance",
            group = "Launcher"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey, "Control"},
        "F2",
        function()
            print("Spawning Chrome")

            awful.spawn("chromium")
        end,
        {
            description = "Launch New Chromium Instance",
            group = "Launcher"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey},
        "F3",
        function()
            print("Spawning caja in Scratchpad")
            drop.toggle("caja", "left", "top", 0.7, 0.7)

            -- awful.spawn('caja')
        end,
        {
            description = "Launch caja in Scratchpad",
            group = "Launcher"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey, "Control"},
        "F3",
        function()
            print("Spawning caja as Root")

            awful.spawn("gksu caja")
        end,
        {
            description = "Launch file Manager as Root",
            group = "Launcher"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey, "Shift"},
        "F3",
        function()
            print("Spawning New caja Instance")

            awful.spawn("caja")
        end,
        {
            description = "Launch New caja Instance",
            group = "Launcher"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey, "Mod1"},
        "F3",
        function()
            print("Spawning New Ranger Instance")

            awful.spawn("ranger")
        end,
        {
            description = "Launch New Ranger Instance",
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
            description = "Copy FontAwesome Icons to Clipboard",
            group = "Launcher"
        }
    ), -- #############################################################################
    awful.key(
        {modkey, "Control"},
        "F4",
        function()
            print("Spawning Emoji Picker")

            awful.spawn.easy_async_with_shell("rofimoji -a copy ")
        end,
        {description = "Copy bin/emojis to Clipboard", group = "Launcher"}
    ),
    -- #############################################################################

    awful.key(
        {modkey},
        "F5",
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
        {modkey, "Control"},
        "F5",
        function()
            print("Spawning Arandr")

            awful.spawn("arandr")
        end,
        {
            description = "Open Display Configuration Application",
            group = "Launcher"
        }
    ),
    -- #############################################################################

    awful.key(
        {"Control", "Mod1"},
        "Delete",
        function()
            print("Opening System Monitor")
            awful.spawn.easy_async_with_shell("htop")
        end,
        {
            description = "Open System Monitor",
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
            description = "Tab Between Applications",
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
            description = "Tab Between Applications In Reverse Order",
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
            description = "Increase Master Width Factor",
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
            description = "Decrease Master Width Factor",
            group = "Layout"
        }
    ),
    -- #############################################################################
    -- Increase/Decrease numbers of master
    awful.key(
        {modkey},
        "Up",
        function()
            print("Increasing Number of Master Clients")

            awful.tag.incnmaster(1, nil, true)
        end,
        {
            description = "Increase The Number Of Master Clients",
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
            description = "Decrease The Number Of Master Clients",
            group = "Layout"
        }
    ),
    -- #############################################################################

    -- Tag browsing
    awful.key(
        {modkey},
        "w",
        awful.tag.viewprev,
        {
            description = "View Previous",
            group = "tag"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey},
        "a",
        awful.tag.viewnext,
        {
            description = "View Next",
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
            description = "Focus Next by Index",
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
            description = "Focus Previous by Index",
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
            print("Toggeling Right Panel")
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
            description = "Jump To Urgent Client",
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
            description = "Go Back",
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
            description = "Lock The Screen",
            group = "Awesome"
        }
    ),
    -- #############################################################################

    -- Standard program
    awful.key(
        {modkey},
        "r",
        _G.awesome.restart,
        {
            description = "Reload Awesome",
            group = "Awesome"
        }
    ),
    -- #############################################################################

    awful.key(
        {modkey, "Control"},
        "x",
        _G.awesome.quit,
        {
            description = "Quit Awesome",
            group = "Awesome"
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
            description = "Increase The Number Of Columns",
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
            description = "Decrease The Number Of Columns",
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
            description = "Select Next",
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
            description = "Select Previous",
            group = "Layout"
        }
    ),
    -- #############################################################################
    awful.key(
        {modkey},
        "n",
        function()
            local c = client.focus
            if c then
                c.minimized = true
            end
        end,
        {description = "Minimize", group = "Client"}
    ),
    -- #############################################################################

    awful.key(
        {modkey, "Control"},
        "n",
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                _G.client.focus = c
                c:raise()
            end
        end,
        {
            description = "Restore Minimized",
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

            naughty.notify({title = "System", text = "The rofi clipboard is now opening on your screen", timeout = 10})

            awful.spawn(apps.default.roficlipboard)
        end,
        {
            description = "Show Clipboard History",
            group = "Utility"
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
            description = "Volume Up",
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
            description = "Volume Down",
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
            description = "Toggle Mute",
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
            description = "Toggle Mute",
            group = "Hardware"
        }
    ),
    -- #############################################################################
    awful.key(
        {modkey},
        "Escape",
        function()
            print("Showing Exit Screen")
            _G.exit_screen_show()
        end,
        {
            description = "Toggle Exit Screen",
            group = "Hardware"
        }
    ),
    -- #############################################################################

    awful.key(
        {},
        "XF86PowerOff",
        function()
            print("Showing Exit Screen")
            _G.exit_screen_show()
        end,
        {
            description = "Toggle Exit Screen",
            group = "Hardware"
        }
    ),
    -- #############################################################################

    awful.key(
        {},
        "XF86Display",
        function()
            print("Spawning Arandr")
            awful.spawn("Arandr")
        end,
        {description = "Spawn Arandr", group = "Awesome"}
    ),
    -- #############################################################################

    -- Music player keys
    awful.key(
        {},
        "XF86AudioPlay",
        function()
            print("Toggeling Music")
            awful.spawn("playerctl play-pause")
        end,
        {
            description = "Toggle Music",
            group = "Hardware"
        }
    ),
    -- #############################################################################

    awful.key(
        {},
        "XF86AudioPause",
        function()
            print("Toggeling Music")
            awful.spawn("playerctl play-pause")
        end,
        {
            description = "Toggle Music",
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
            print("Next Song")
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
            print("Taking A Full Screenshot")

            awful.spawn("bash " .. HOME .. "/.config/awesome/bin/snapshot.sh full")
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
            print("Taking An Area Screenshot")
            awful.spawn("bash " .. HOME .. "/.config/awesome/bin/snapshot.sh area ")
            client.drawBackdrop = false
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
            print("Taking A Screenshot Of A Window")
            awful.spawn(apps.bins.window_blank_screenshot)
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
                print("Going To Tag: " .. i)
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
                print("Toggeling Tag: " .. i)
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
                print("Moving Client To Tag: " .. i)
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
                print("Toggeling Tag " .. i .. " Focused Client")
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
