require("awful.autofocus")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local has_package_installed = require("lib.hardware-check").has_package_installed
require("awful.hotkeys_popup.keys")

local config = require("configuration.keys.mod")
local modkey = config.modKey
local altkey = config.altKey
local apps = require("configuration.apps")
local xrandr = require("lib.xrandr")
local signals = require("lib.signals")
local volume = require("lib.volume")

-- returns true if we cannot create a screenshot
local function send_notification_if_maim_missing()
  if not has_package_installed("maim") then
    require("naughty").notification(
      {
        title = i18n.translate("Cannot create screenshot"),
        message = i18n.translate("maim is not installed, install it using tde-contrib package"),
        app_name = i18n.translate("tde package notifier")
      }
    )
    return true
  end
  return false
end

-- Key bindings
local globalKeys =
  awful.util.table.join(
  -- Hotkeys
  awful.key(
    {modkey},
    "F1",
    hotkeys_popup.show_help,
    {description = i18n.translate("show help"), group = i18n.translate("awesome")}
  ),
  --#############################################################################

  -- Custom Keys
  awful.key(
    {modkey},
    "y",
    function()
      xrandr.xrandr()
    end,
    {description = i18n.translate("Launch screen layout mode"), group = i18n.translate("Launcher")}
  ),
  --#############################################################################

  awful.key(
    {modkey},
    "Return",
    function()
      print("Spawning terminal")
      awful.spawn(apps.default.terminal)
    end,
    {description = i18n.translate("Open Terminal"), group = i18n.translate("Launcher")}
  ),
  --#############################################################################

  awful.key(
    {modkey},
    "b",
    function()
      print("Spawning rofi window switcher")
      awful.spawn(apps.default.rofiwindowswitch)
    end,
    {description = i18n.translate("Open a Window Switcher"), group = i18n.translate("launcher")}
  ),
  --#############################################################################

  -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  awful.key(
    {modkey, "Control"},
    "Escape",
    function()
      print("Spawning rofi app menu")
      awful.spawn(apps.default.rofiappmenu)
    end,
    {description = i18n.translate("Open Rofi"), group = i18n.translate("Launcher")}
  ),
  --#############################################################################

  --#############################################################################
  awful.key(
    {modkey},
    "F2",
    function()
      awful.spawn("firefox")
    end,
    {
      description = "Launch Firefox",
      group = "Launcher"
    }
  ),
  --#############################################################################
  awful.key(
    {modkey, "Shift"},
    "F2",
    function()
      awful.spawn("buku_run")
    end,
    {
      description = "Launch Buku Rofi Menu",
      group = "Launcher"
    }
  ),
  --#############################################################################

  awful.key(
    {modkey, "Control"},
    "F2",
    function()
      awful.spawn("chrome")
    end,
    {
      description = "Launch Chrome",
      group = "Launcher"
    }
  ),
  --#############################################################################

  --#############################################################################

  awful.key(
    {modkey},
    "F3",
    function()
      awful.spawn("thunar")
    end,
    {
      description = "Launch File Manager",
      group = "Launcher"
    }
  ),
  --#############################################################################

  awful.key(
    {modkey, "Control"},
    "F3",
    function()
      awful.spawn("gksu caja")
    end,
    {
      description = "Launch File Manager as Root",
      group = "Launcher"
    }
  ),
  --#############################################################################

  awful.key(
    {modkey, "Shift"},
    "F3",
    function()
      awful.spawn("kitty -e ranger")
    end,
    {
      description = "Launch Terminal File Manager",
      group = "Launcher"
    }
  ),
  --#############################################################################
  awful.key(
    {modkey},
    "F4",
    function()
      awful.spawn.easy_async_with_shell("~/.config/awesome/configuration/rofi/fontawesome_menu/fontawesome-menu")
    end,
    {
      description = "Copy Font - Awesome Icons to Clipboard",
      group = "Launcher"
    }
  ), --#############################################################################
  awful.key(
    {modkey, "Control"},
    "F4",
    function()
      awful.spawn.easy_async_with_shell("emojipick")
    end,
    {
      description = "Copy Emojis to Clipboard",
      group = "Launcher"
    }
  ),
  --#############################################################################
  awful.key(
    {modkey},
    "F5",
    function()
      awful.spawn("arandr")
    end,
    {description = "open display configuration application", group = "function"}
  ),
  --#############################################################################

  -- Dropdown application
  awful.key(
    {modkey},
    "F12",
    function()
      _G.toggle_quake()
    end,
    {description = i18n.translate("dropdown terminal"), group = i18n.translate("Launcher")}
  ),
  --#############################################################################

  awful.key(
    {"Control", "Mod1"},
    "Delete",
    function()
      print("Opening system monitor")
      awful.spawn("gnome-system-monitor")
    end,
    {description = i18n.translate("Open system monitor"), group = i18n.translate("Launcher")}
  ),
  --#############################################################################

  awful.key(
    {"Mod1"},
    "Tab",
    function()
      print("Tabbing between applications")
      _G.switcher.switch(1, "Mod1", "Alt_L", "Shift", "Tab")
    end,
    {description = i18n.translate("Tab between applications"), group = i18n.translate("Laucher")}
  ),
  --#############################################################################

  awful.key(
    {"Mod1", "Shift"},
    "Tab",
    function()
      print("Reverse tabbing between applications")
      _G.switcher.switch(-1, "Mod1", "Alt_L", "Shift", "Tab")
    end,
    {description = i18n.translate("Tab between applications in reverse order"), group = i18n.translate("Laucher")}
  ),
  --#############################################################################
  --#############################################################################
  -- Client resize master
  awful.key(
    {modkey},
    "Right",
    function()
      awful.tag.incmwfact(0.05)
    end,
    {description = "increase master width factor", group = "layout"}
  ),
  --#############################################################################
  awful.key(
    {modkey},
    "Left",
    function()
      awful.tag.incmwfact(-0.05)
    end,
    {description = "decrease master width factor", group = "layout"}
  ),
  --#############################################################################
  -- Increase/Decrease numbers of master
  awful.key(
    {modkey},
    "Up",
    function()
      awful.tag.incnmaster(1, nil, true)
    end,
    {description = "increase the number of master clients", group = "layout"}
  ),
  --#############################################################################
  awful.key(
    {modkey},
    "Down",
    function()
      awful.tag.incnmaster(-1, nil, true)
    end,
    {description = "decrease the number of master clients", group = "layout"}
  ),
  --#############################################################################

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
  --#############################################################################

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
  --#############################################################################

  -- Toggle System Tray
  awful.key(
    {modkey},
    "=",
    function()
      print("Toggeling systray visibility")
      awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
    end,
    {description = i18n.translate("Toggle systray visibility"), group = i18n.translate("custom")}
  ),
  --#############################################################################

  -- Tag browsing
  awful.key(
    {modkey},
    "w",
    awful.tag.viewprev,
    {description = i18n.translate("view previous"), group = i18n.translate(i18n.translate("tag"))}
  ),
  --#############################################################################

  awful.key(
    {modkey},
    "a",
    awful.tag.viewnext,
    {description = i18n.translate("view next"), group = i18n.translate(i18n.translate("tag"))}
  ),
  --#############################################################################

  -- Default client focus
  awful.key(
    {modkey, "Shift"},
    "w",
    function()
      awful.client.focus.byidx(1)
    end,
    {description = i18n.translate("focus next by index"), group = i18n.translate("client")}
  ),
  --#############################################################################

  awful.key(
    {modkey, "Shift"},
    "a",
    function()
      awful.client.focus.byidx(-1)
    end,
    {description = i18n.translate("focus previous by index"), group = i18n.translate("client")}
  ),
  --#############################################################################

  awful.key(
    {modkey},
    "g",
    function()
      print("Showing action center")
      _G.screen.primary.left_panel:toggle(true)
    end,
    {description = i18n.translate("Open Control panel"), group = i18n.translate("Launcher")}
  ),
  --#############################################################################

  awful.key({modkey}, "u", awful.client.urgent.jumpto, {description = "jump to urgent client", group = "client"}),
  awful.key(
    {modkey},
    config.toggleFocus,
    function()
      awful.client.focus.history.previous()
      if _G.client.focus then
        _G.client.focus:raise()
      end
    end,
    {description = i18n.translate("go back"), group = i18n.translate("client")}
  ),
  --#############################################################################

  -- Programs
  awful.key(
    {modkey},
    "l",
    function()
      print("Locking screen")
      awful.spawn(apps.default.lock)
    end,
    {description = i18n.translate("lock the screen"), group = i18n.translate("hotkeys")}
  ),
  --#############################################################################

  awful.key(
    {modkey},
    "h",
    function()
      print("Toggeling right panel")
      if _G.screen.primary.right_panel ~= nil then
        _G.screen.primary.right_panel:toggle()
      end
    end,
    {description = i18n.translate("Open Notification Center"), group = i18n.translate("Launcher")}
  ),
  --#############################################################################

  -- Standard program
  awful.key(
    {modkey},
    "r",
    _G.awesome.restart,
    {description = i18n.translate("reload awesome"), group = i18n.translate("awesome")}
  ),
  --#############################################################################

  awful.key(
    {modkey, "Control"},
    "x",
    _G.awesome.quit,
    {description = i18n.translate("quit awesome"), group = i18n.translate("awesome")}
  ),
  --#############################################################################

  awful.key(
    {altkey, "Shift"},
    "l",
    function()
      awful.tag.incmwfact(0.05)
    end,
    {description = i18n.translate("increase master width factor"), group = i18n.translate("layout")}
  ),
  --#############################################################################

  awful.key(
    {altkey, "Shift"},
    "h",
    function()
      awful.tag.incmwfact(-0.05)
    end,
    {description = i18n.translate("decrease master width factor"), group = i18n.translate("layout")}
  ),
  --#############################################################################

  awful.key(
    {modkey, "Shift"},
    "h",
    function()
      awful.tag.incnmaster(1, nil, true)
    end,
    {description = i18n.translate("increase the number of master clients"), group = i18n.translate("layout")}
  ),
  --#############################################################################

  awful.key(
    {modkey, "Shift"},
    "l",
    function()
      awful.tag.incnmaster(-1, nil, true)
    end,
    {description = i18n.translate("decrease the number of master clients"), group = i18n.translate("layout")}
  ),
  --#############################################################################

  awful.key(
    {modkey, "Control"},
    "h",
    function()
      awful.tag.incnplugplug(1, nil, true)
    end,
    {description = i18n.translate("increase the number of columns"), group = i18n.translate("layout")}
  ),
  --#############################################################################

  awful.key(
    {modkey, "Control"},
    "l",
    function()
      awful.tag.incncol(-1, nil, true)
    end,
    {description = i18n.translate("decrease the number of columns"), group = i18n.translate("layout")}
  ),
  --#############################################################################

  awful.key(
    {modkey},
    "space",
    function()
      awful.layout.inc(1)
    end,
    {description = i18n.translate("select next"), group = i18n.translate("layout")}
  ),
  --#############################################################################

  awful.key(
    {modkey, "Shift"},
    "space",
    function()
      awful.layout.inc(-1)
    end,
    {description = i18n.translate("select previous"), group = i18n.translate("layout")}
  ),
  --#############################################################################
  awful.key(
    {modkey},
    "n",
    function()
        -- The client currently has the input focus, so it cannot be
        -- minimized, since minimized clients can't have the focus.
        local c = client.focus
        if c then
          c.minimized=true
        end
          end,
    {description = "minimize", group = "client"}
),
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
    {description = i18n.translate("restore minimized"), group = i18n.translate("client")}
  ),
  --#############################################################################

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
    {description = i18n.translate("+10%"), group = i18n.translate(i18n.translate("hardware"))}
  ),
  --#############################################################################

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
    {description = i18n.translate("-10%"), group = i18n.translate(i18n.translate("hardware"))}
  ),
  --#############################################################################

  -- ALSA volume control
  awful.key(
    {},
    "XF86AudioRaiseVolume",
    function()
      print("Raising volume")
      volume.inc_volume()
      signals.emit_volume_update()
    end,
    {description = i18n.translate("volume up"), group = i18n.translate(i18n.translate("hardware"))}
  ),
  --#############################################################################

  awful.key(
    {},
    "XF86AudioLowerVolume",
    function()
      print("Lowering volume")
      volume.dec_volume()
      signals.emit_volume_update()
    end,
    {description = i18n.translate("volume down"), group = i18n.translate(i18n.translate("hardware"))}
  ),
  --#############################################################################

  awful.key(
    {},
    "XF86AudioMute",
    function()
      print("Toggeling volume")
      volume.toggle_master()
      signals.emit_volume_update()
    end,
    {description = i18n.translate("toggle mute"), group = i18n.translate(i18n.translate("hardware"))}
  ),
  --#############################################################################

  awful.key(
    {},
    "XF86AudioNext",
    function()
      print("Pressed Audio Next")
    end,
    {description = "toggle mute", group = i18n.translate("hardware")}
  ),
  --#############################################################################

  awful.key(
    {modkey},
    "Escape",
    function()
      print("Showing exit screen")
      _G.exit_screen_show()
    end,
    {description = i18n.translate("toggle exit screen"), group = i18n.translate(i18n.translate("hardware"))}
  ),
  --#############################################################################

  awful.key(
    {},
    "XF86PowerOff",
    function()
      print("Showing exit screen")
      _G.exit_screen_show()
    end,
    {description = i18n.translate("toggle exit screen"), group = i18n.translate(i18n.translate("hardware"))}
  ),
  --#############################################################################

  awful.key(
    {},
    "XF86Display",
    function()
      print("Spawning arandr")
      awful.spawn("arandr")
    end,
    {description = i18n.translate("arandr"), group = "hotkeys"}
  ),
  --#############################################################################

  -- Music player keys
  awful.key(
    {},
    "XF86AudioPlay",
    function()
      print("toggeling music")
      awful.spawn("playerctl play-pause")
    end,
    {description = i18n.translate("toggle music"), group = i18n.translate("hardware")}
  ),
  --#############################################################################

  awful.key(
    {},
    "XF86AudioPause",
    function()
      print("toggeling music")
      awful.spawn("playerctl play-pause")
    end,
    {description = i18n.translate("toggle music"), group = i18n.translate("hardware")}
  ),
  --#############################################################################

  awful.key(
    {},
    "XF86AudioPrev",
    function()
      print("Previous song")
      awful.spawn("playerctl previous")
    end,
    {description = i18n.translate("go to the previous song"), group = i18n.translate("hardware")}
  ),
  --#############################################################################

  awful.key(
    {},
    "XF86AudioNext",
    function()
      print("Next song")
      awful.spawn("playerctl next")
    end,
    {description = i18n.translate("go to the next song"), group = i18n.translate("hardware")}
  ),
  --#############################################################################

  -- keys for keyboards without xf86 keys
  awful.key(
    {modkey},
    config.toggleMusic,
    function()
      print("toggeling music")
      awful.spawn("playerctl play-pause")
    end,
    {description = i18n.translate("toggle music"), group = i18n.translate("hardware")}
  ),
  --#############################################################################

  awful.key(
    {modkey},
    config.prevMusic,
    function()
      print("Previous song")
      awful.spawn("playerctl previous")
    end,
    {description = i18n.translate("go to the previous song"), group = i18n.translate("hardware")}
  ),
  --#############################################################################

  awful.key(
    {modkey},
    config.nextMusic,
    function()
      print("Next song")
      awful.spawn("playerctl next")
    end,
    {description = i18n.translate("go to the next song"), group = i18n.translate("hardware")}
  ),
  --#############################################################################

  awful.key(
    {},
    config.printscreen,
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
    {description = i18n.translate("fullscreen screenshot"), group = i18n.translate("Utility")}
  ),
  --#############################################################################

  awful.key(
    {modkey},
    config.snapArea,
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
    {description = i18n.translate("area/selected screenshot"), group = i18n.translate("Utility")}
  ),
  --#############################################################################

  awful.key(
    {modkey, "Shift"},
    config.windowSnapArea,
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
    {description = i18n.translate("window screenshot"), group = i18n.translate("Utility")}
  ),
  --#############################################################################

  awful.key(
    {modkey},
    config.clipboard,
    function()
      print("Opening rofi clipboard")
      awful.spawn(apps.default.roficlipboard)
    end,
    {description = i18n.translate("Show clipboard history"), group = i18n.translate("Utility")}
  ),
  --#############################################################################

  awful.key(
    {modkey},
    "s",
    function()
      print("Opening settings application")
      root.elements.settings.enable_view_by_index(-1, mouse.screen)
    end,
    {description = i18n.translate("Open settings application"), group = "Launcher"}
  )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
  globalKeys =
    awful.util.table.join(
    globalKeys,
    -- View tag only.
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
    --#############################################################################

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
    --#############################################################################

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
    --#############################################################################

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
