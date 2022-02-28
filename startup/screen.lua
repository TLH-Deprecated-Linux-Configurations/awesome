--  _______
-- |     __|.----.----.-----.-----.-----.
-- |__     ||  __|   _|  -__|  -__|     |
-- |_______||____|__| |_____|_____|__|__|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Called screen because originally this file also handled the
-- setting of the wallpaper, but feh is doing that as you can
-- see in the authostart applications portion.

-- left here in case dependency minimalization later requires it
--[[
local function set_wallpaper(s)
  local wallpaper = backgrounds.archkraken
  gears.wallpaper.maximized(wallpaper, s, true)
end

screen.connect_signal("property::geometry", set_wallpaper)


awful.screen.connect_for_each_screen(
  function(s)
    set_wallpaper(s)
  end
)
]]
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Autostart Applications

local function run_once(cmd)
  local findme = cmd
  local firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace - 1)
  end
  awful.spawn.easy_async_with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
end
-- ------------------------------------------------- --
-- LuaFormatter off
-- Add apps to autostart here
autostart_apps = {
  -- Disable Bell
  "xset -b", -- Bluetooth
  "blueman-applet", -- Screens
  "xsettingsd &",
  'xrdb "$HOME"/.Xresources &',
  "pnmixer &",
  --"dropbox start &",
  "sudo pkill /usr/libexec/xfce-polkit && /usr/libexec/xfce-polkit &",
  -- 	'xinput set-prop "ELAN1301:00 04F3:30C6 Touchpad" "libinput Tapping Enabled" 1 &',
  ' eval "$(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)" &',
  'xcape -e "Super_L=Super_L|Control_L|Escape" &',
  "greenclip daemon &",
  "udiskie &",
  "picom -b --experimental-backends &",
  "xautolock -time 5 -locker /home/tlh/.config/awesome/bin/blur.sh & ",
  "dbus-daemon --session --address=unix:path=$XDG_RUNTIME_DIR/bus &",
  "xfce4-power-manager &",
  " gpg-agent --daemon",
  "feh --bg-fill ~/.config/awesome/themes/backgrounds/" .. settings.background
}
-- LuaFormatter on
-- ------------------------------------------------- --
for app = 1, #autostart_apps do
  run_once(autostart_apps[app])
end
