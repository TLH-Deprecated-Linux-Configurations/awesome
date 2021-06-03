local filesystem = require("gears.filesystem")
local theme_dir = filesystem.get_configuration_dir() .. "/theme"
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi
local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()
local gtk = require("beautiful.gtk")
local config = require("theme.config")
local darklight = require("theme.icons.dark-light")
local filehandle = require("lib.file")
local file_exists = filehandle.exists

local theme = {}
theme.icons = theme_dir .. "/icons/"
theme.font = "Hurmit Nerd Font bold 10"
theme.monitor_font = "Hurmit Nerd Font bold 50"
theme.gtk = gtk.get_theme_variables()
theme.background_transparency = config["background_transparent"] or "66"

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
local function lines_from(file)
  if not file_exists(file) then
    return "/usr/share/backgrounds/5.png"
  end
  local lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end

-- Colors Pallets
-- Load ~/.Xresources colors and set fallback colors
theme.xbackground = xrdb.background
theme.background = xrdb.background
theme.xforeground = xrdb.foreground
theme.foreground = xrdb.foreground
theme.xcolor0 = xrdb.color0
theme.xcolor1 = xrdb.color1
theme.xcolor2 = xrdb.color2
theme.xcolor3 = xrdb.color3
theme.xcolor4 = xrdb.color4
theme.xcolor5 = xrdb.color5
theme.xcolor6 = xrdb.color6
theme.xcolor7 = xrdb.color7
theme.xcolor8 = xrdb.color8
theme.xcolor9 = xrdb.color9
theme.xcolor10 = xrdb.color10
theme.xcolor11 = xrdb.color11
theme.xcolor12 = xrdb.color12
theme.xcolor13 = xrdb.color13
theme.xcolor14 = xrdb.color14
theme.xcolor15 = xrdb.color15
theme.xcolor16 = "#555e70"
theme.xcolor17 = "#b2bfd9"
theme.xcolor18 = "#22262d"
theme.xcolor19 = "#727f96"
-- Custom
theme.custom = "#ffffff"

-- Primary
theme.primary = theme.foreground

-- Accent
theme.accent = theme.xcolor17

theme.text = theme.foreground

-- system stat charts in settings app
theme.cpu_bar = theme.xcolor1
theme.ram_bar = theme.xcolor2
theme.disk_bar = theme.xcolor3

local awesome_overrides = function(awesome_theme)
  awesome_theme.dir = theme_dir

  awesome_theme.icons = awesome_theme.dir .. "/icons/"

  local resultset = lines_from(os.getenv("HOME") .. "/.config/awesome/electric-tantra/theme")
  awesome_theme.wallpaper = "/usr/share/backgrounds/background.png"
  awesome_theme.font = "Hurmit Nerd Font Mono bold 10"
  awesome_theme.title_font = "Hurmit Nerd Font Mono bold 18"

  awesome_theme.fg_white = theme.xcolor7
  awesome_theme.fg_black = theme.xcolor0
  awesome_theme.fg_normal = theme.xcolor15

  awesome_theme.fg_focus = theme.xcolor15
  awesome_theme.fg_urgent = theme.xcolor9
  awesome_theme.bat_fg_critical = theme.xcolor9

  awesome_theme.bg_normal = theme.background
  awesome_theme.bg_focus = theme.xcolor18
  awesome_theme.bg_urgent = theme.xcolor1
  awesome_theme.bg_systray = theme.xcolor18

  awesome_theme.bg_modal = theme.xcolor18
  awesome_theme.bg_modal_title = theme.xcolor18
  awesome_theme.bg_settings_display_number = "#00000070"

  -- Borders
  awesome_theme.border_width = dpi(2)
  awesome_theme.border_normal = theme.background
  awesome_theme.border_focus = awesome_theme.primary.hue_300
  awesome_theme.border_marked = theme.xcolor7

  -- Notification
  awesome_theme.transparent = "#00000000"
  awesome_theme.notification_position = "top_right"
  awesome_theme.notification_bg = awesome_theme.transparent
  awesome_theme.notification_margin = dpi(5)
  awesome_theme.notification_border_width = dpi(0)
  awesome_theme.notification_border_color = awesome_theme.transparent
  awesome_theme.notification_spacing = dpi(0)
  awesome_theme.notification_icon_resize_strategy = "center"
  awesome_theme.notification_icon_size = dpi(32)

  -- UI Groups

  awesome_theme.groups_title_bg = awesome_theme.bg_modal_title
  awesome_theme.groups_bg = awesome_theme.bg_modal
  awesome_theme.groups_radius = dpi(9)

  -- Menu

  awesome_theme.menu_height = dpi(16)
  awesome_theme.menu_width = dpi(160)

  -- Tooltips
  awesome_theme.tooltip_bg = theme.background .. "aa"
  --awesome_theme.tooltip_border_color = '#232323'
  awesome_theme.tooltip_border_width = 0
  awesome_theme.tooltip_shape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, dpi(6))
  end

  -- Layout

  awesome_theme.layout_max = awesome_theme.icons .. "layouts/arrow-expand-all.png"
  awesome_theme.layout_tile = awesome_theme.icons .. "layouts/view-quilt.png"
  awesome_theme.layout_dwindle = awesome_theme.icons .. "layouts/dwindle.png"
  awesome_theme.layout_floating = awesome_theme.icons .. "layouts/floating.png"
  awesome_theme.layout_fairv = awesome_theme.icons .. "layouts/fair.png"
  awesome_theme.layout_fairh = awesome_theme.icons .. "layouts/fairh.png"
  awesome_theme.layout_magnifier = awesome_theme.icons .. "layouts/magnifier.png"
  awesome_theme.layout_mstab = awesome_theme.icons .. "layouts/mstab.png"
  -- Taglist
  local taglist_occupied = theme.xcolor17
  awesome_theme.taglist_bg_empty = theme.background .. "99"
  awesome_theme.taglist_bg_occupied =
    "linear:0," ..
    dpi(48) ..
      ":0,0:0," ..
        taglist_occupied .. ":0.11," .. taglist_occupied .. ":0.11," .. theme.background .. "99" .. theme.background
  awesome_theme.taglist_bg_urgent =
    "linear:0," ..
    dpi(48) ..
      ":0,0:0," ..
        theme.xcolor16 .. ":0.11," .. theme.xcolor16 .. ":0.11," .. theme.background .. ":1," .. theme.background
  awesome_theme.taglist_bg_focus =
    "linear:0,0:0," ..
    dpi(48) ..
      ":0," .. theme.background .. "bb," .. theme.background .. "bb," .. theme.xcolor8 .. "22," .. theme.xcolor16

  -- Tasklist

  awesome_theme.tasklist_font = theme.font
  awesome_theme.tasklist_bg_normal = theme.background .. "00"
  awesome_theme.tasklist_bg_focus =
    "linear:0,0:0," ..
    dpi(48) ..
      ":0," .. theme.background .. "bb," .. theme.background .. "bb," .. theme.xcolor8 .. "22," .. theme.xcolor16
  awesome_theme.tasklist_bg_urgent = theme.background
  awesome_theme.tasklist_fg_focus = theme.xcolor15
  awesome_theme.tasklist_fg_urgent = theme.xcolor1
  awesome_theme.tasklist_fg_normal = theme.foreground

  awesome_theme.icon_theme = "chhinamasta"
  -- ####################################################################
  -- Taglist
  -- ####################################################################
  --- Generate taglist squares:
  awesome_theme.taglist_spacing = 1
  --colors
  awesome_theme.taglist_fg_focus = theme.xcolor15
  awesome_theme.taglist_fg_urgent = theme.xcolor1
  awesome_theme.taglist_fg_occupied = theme.xcolor17
  awesome_theme.taglist_fg_empty = theme.xcolor19
  awesome_theme.taglist_bg_empty = theme.xbackground .. "00"
  awesome_theme.taglist_bg = theme.xbackground .. "00"

  awesome_theme.taglist_fg_volatile = theme.xcolor11
  --####################################################################
  -- MStab Configuration
  -- ####################################################################
  theme.mstab_tabbar_style = "modern"
  theme.mstab_bar_ontop = true -- whether you want to allow the bar to be ontop of clients
  theme.mstab_bar_padding = dpi(0) -- how much padding there should be between clients and your tabbar
  theme.mstab_dont_resize_slaves = true
  theme.mstab_bar_height = 21
  theme.layout_mstab = awesome_theme.icons .. "layouts/mstab.png"

  theme.taglist_font = "awesomewm-font 20"
  -- TODO: use native functions instead of a shell script
  local out =
    io.popen(
    "if [ -f ~/.config/gtk-3.0/settings.ini ]; " ..
      [[then grep "gtk-icon-theme-name" ~/.config/gtk-3.0/settings.ini | awk -F= '{printf $2}'; fi]]
  ):read("*all")
  if out ~= nil then
    awesome_theme.icon_theme = out
  end
  --Client
  awesome_theme.border_width = dpi(0)
  awesome_theme.border_focus = theme.xcolor18
  awesome_theme.border_normal = theme.xcolor0
  awesome_theme.border_color = theme.xcolor0
  awesome_theme.snap_bg = theme.xbackground .. "99"
end
return {
  theme = theme,
  awesome_overrides = awesome_overrides
}
