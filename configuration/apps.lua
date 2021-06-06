local filesystem = require("gears.filesystem")
local config = require("config")
local hardware = require("lib.hardware-check")

-- lib to retrieve current theme
local beautiful = require("beautiful")
local color = beautiful.xforeground
local HOME = os.getenv("HOME")
local picom = "picom -b --dbus --experimental-backends --config " .. config.getComptonFile()
-- if the user has weak hardware then don't use picom with it's blur effects
if general["weak_hardware"] == "1" or hardware.isWeakHardware() then
  picom = ""
end

return {
  -- List of apps to start by default on some actions
  default = {
    terminal = "kitty",
    editor = "nvim",
    web_browser = "firefox",
    file_manager = "thunar",
    rofi = "rofi -dpi " ..
      screen.primary.dpi ..
        ' -show "Global Search" -modi "Global Search":' ..
          HOME ..
            "/.config/awesome/external/rofi/sidebar/rofi-spotlight.sh -theme " ..
              HOME .. "/.config/awesome/external/rofi/sidebar/rofi.rasi",
    web = "rofi -dpi " ..
      screen.primary.dpi ..
        " -show Search -modi Search:" ..
          HOME .. "/external/rofi/search.py" .. " -theme " .. HOME .. "/.config/awesome/external/rofi/sidebar/rofi.rasi",
    rofiappmenu = "bash " ..
      HOME .. "/.config/awesome/applauncher.sh " .. screen.primary.dpi .. " " .. filesystem.get_configuration_dir(),
    rofiemojimenu = "bash " .. HOME .. "/.config/awesome/emoji.sh " .. screen.primary.dpi,
    rofiwindowswitch = "bash " .. HOME .. "/.config/awesome/application-switch.sh" .. " " .. screen.primary.dpi,
    roficlipboard = "rofi -dpi " ..
      screen.primary.dpi ..
        ' -modi "clipboard:greenclip print" -show clipboard -theme ' ..
          HOME .. "/.config/awesome/external/rofi/appmenu/drun.rasi",
    rofidpimenu = "bash " .. HOME .. "dpi.sh",
    rofiwifimenu = "bash " .. HOME .. "wifi.sh" .. " " .. screen.primary.dpi,
    lock = "$HOME/.config/awesome/external/i3lock/blur.sh",
    --lock = "dm-tool lock",
    quake = (os.getenv("TERMINAL") or "kitty") .. " -T QuakeTerminal",
    duplicate_screens = "bash " .. HOME .. "xrandr-duplicate.sh"
  },
  -- List of apps to start once on start-up
  run_on_start_up = {
    "picom -b --experimental-backends --config $HOME/.config/awesome/external/picom.conf",
    --"blueman-applet", -- Bluetooth tray icon
    "xfce4-power-manager", -- Power manager
    "xfsettingsd",
    "xrdb $HOME/.Xresources",
    "xsetroot -cursor_name left_ptr",
    'xcape -e "Super_L=Super_L|Control_L|Escape"'
  },
  bins = {
    coverUpdate = require("lib.extractcover").extractalbum,
    full_screenshot = 'sh /.config/awesome/snapshot.sh full "' .. color .. '"',
    full_blank_screenshot = "sh " .. HOME .. " /.config/awesome/snapshot.sh full_blank",
    area_screenshot = "sh " .. HOME .. "/.config/awesome/snapshot.sh area " .. color .. '"',
    area_blank_screenshot = "sh " .. HOME .. "/.config/awesome/snapshot.sh area_blank",
    window_screenshot = "sh " .. HOME .. '/.config/awesome/snapshot.sh" window ' .. color .. '"',
    window_blank_screenshot = "sh " .. HOME .. "/.config/awesome/snapshot.sh window_blank"
  }
}
