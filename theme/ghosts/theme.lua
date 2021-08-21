--  _   _
-- | |_| |__   ___ _ __ ___   ___
-- | __| '_ \ / _ \ '_ ` _ \ / _ \
-- | |_| | | |  __/ | | | | |  __/
--  \__|_| |_|\___|_| |_| |_|\___|
local theme_assets = require('beautiful.theme_assets')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local gears = require('gears')
local gfs = require('gears.filesystem')
local themes_path = gfs.get_themes_dir()
local helpers = require('helpers')

-- Inherit default theme
--
local theme = dofile(themes_path .. 'default/theme.lua')
theme.wallpaper = gfs.get_configuration_dir() .. 'images/bg.png'

-- Titlebar icon path
--
local icon_path = gfs.get_configuration_dir() .. 'icons/'

-- PFP
--
theme.me = gears.surface.load_uncached(gfs.get_configuration_dir() .. 'images/me.png')

-- Distro Logo
--
theme.distro_logo = gears.surface.load_uncached(gfs.get_configuration_dir() .. 'images/distro.png')

-- Icons for Notif Center
--
theme.clear_icon = icon_path .. 'notif-center/clear.png'
theme.clear_grey_icon = icon_path .. 'notif-center/clear_grey.png'
theme.notification_icon = icon_path .. 'notif-center/notification.png'
theme.delete_icon = icon_path .. 'notif-center/delete.png'
theme.delete_grey_icon = icon_path .. 'notif-center/delete_grey.png'

-- Load ~/.Xresources colors and set fallback colors
--
theme.xbackground = xrdb.background or '#17191e'
theme.xforeground = xrdb.foreground or '#f4f4f7'
theme.xcolor0 = '#21262e'
theme.xcolor1 = '#ff28a9'
theme.xcolor2 = '#33ffdd'
theme.xcolor3 = '#f0ffaa'
theme.xcolor4 = '#0badff'
theme.xcolor5 = '#8265ff'
theme.xcolor6 = '#00eaff'
theme.xcolor7 = '#8b9cbe'
theme.xcolor8 = '#2f303d'
theme.xcolor9 = '#ff3d81'
theme.xcolor10 = '#00ffcc'
theme.xcolor11 = '#f9f871'
theme.xcolor12 = '#00caff'
theme.xcolor13 = '#6c71c4'
theme.xcolor14 = '#00fae9'
theme.xcolor15 = '#f4f4f7'
theme.xcolor16 = '#3c3f4c'
theme.xcolor17 = '#0b0c0f'
theme.xcolor18 = '#383a47'
theme.xcolor19 = '#555e70'
theme.xcolor20 = '#727f96'
theme.xcolor21 = '#555566'
theme.xcolor22 = '#22262d'
-- Fonts
--
theme.font_name = 'SFMono Nerd Font Bold '
theme.font = theme.font_name .. '10'
theme.icon_font_name = 'SFMono Nerd Font Bold '
theme.icon_font = theme.icon_font_name .. '18'
theme.font_taglist = theme.icon_font_name .. '13'

-- Background Colors
--
theme.bg_dark = theme.xcolor0
theme.bg_normal = theme.xbackground
theme.bg_focus = theme.xcolor0
theme.bg_urgent = theme.xcolor0
theme.bg_minimize = theme.xcolor0

-- Foreground Colors
--
theme.fg_normal = theme.xcolor7
theme.fg_focus = theme.xcolor4
theme.fg_urgent = theme.xcolor3
theme.fg_minimize = theme.xcolor7

theme.button_close = theme.xcolor1

-- uBorders
--
theme.border_width = dpi(3)
theme.oof_border_width = dpi(0)
theme.border_normal = theme.xbackground
theme.border_focus = theme.xcolor0
theme.border_radius = dpi(12)
theme.client_radius = dpi(12)
theme.widget_border_width = dpi(3)
theme.widget_border_color = theme.xcolor0

-- Taglist
--
-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)
theme.taglist_font = theme.font_taglist
theme.taglist_bg = theme.wibar_bg
theme.taglist_bg_focus = theme.xcolor0
theme.taglist_fg_focus = theme.xcolor1
theme.taglist_bg_urgent = theme.xcolor0
theme.taglist_fg_urgent = theme.xcolor6
theme.taglist_bg_occupied = theme.xcolor0
theme.taglist_fg_occupied = theme.xcolor6
theme.taglist_bg_empty = theme.xcolor0
theme.taglist_fg_empty = theme.xcolor7
theme.taglist_bg_volatile = '#00000000'
theme.taglist_fg_volatile = theme.xcolor11
theme.taglist_disable_icon = true
theme.taglist_shape_focus = helpers.rrect(theme.border_radius)

-- Tasklist
--
theme.tasklist_font = theme.font
theme.tasklist_plain_task_name = true
theme.tasklist_bg_focus = theme.xcolor0 .. '99'
theme.tasklist_fg_focus = theme.xcolor15

theme.tasklist_bg_minimize = theme.xcolor0 .. '99'
theme.tasklist_fg_minimize = theme.xcolor3

theme.tasklist_bg_normal = theme.xcolor0 .. '99'
theme.tasklist_fg_normal = theme.xcolor7

theme.tasklist_disable_task_name = false
theme.tasklist_disable_icon = false

theme.tasklist_bg_urgent = theme.xcolor0 .. '99'
theme.tasklist_fg_urgent = theme.xcolor1

theme.tasklist_align = 'center'

-- Titlebars
--
theme.titlebar_size = dpi(30)
theme.titlebar_height = dpi(20)
theme.titlebar_bg_focus = theme.xcolor0 .. 'cc'
theme.titlebar_bg_normal = {
    type = 'linear',
    from = {10, 10},
    to = {35, 35},
    stops = {
        {0, theme.xbackground .. '99'},
        {0.25, theme.xcolor7 .. '33'},
        {0.45, theme.xcolor8 .. '33'},
        {0.85, theme.xcolor7 .. '33'},
        {0.95, theme.xcolor18 .. '33'},
        {1, theme.xbackground .. '33'},
        {1.85, theme.xcolor0 .. '33'}
    }
}
theme.titlebar_fg_normal = theme.xcolor7
theme.titlebar_fg_focus = theme.xcolor15

-- Edge snap
--
theme.snap_bg = theme.xcolor7
theme.snap_shape = helpers.rrect(0)

-- Prompts
--
theme.prompt_bg = '#00000000'
theme.prompt_fg = theme.xforeground

-- Tooltips
--
theme.tooltip_bg = theme.xbackground .. '88'

theme.tooltip_fg = theme.xforeground
theme.tooltip_font = theme.font_name .. '12'
theme.tooltip_border_width = theme.widget_border_width
theme.tooltip_border_color = theme.xcolor0
theme.tooltip_opacity = 1
theme.tooltip_align = 'left'
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Menu
--
theme.menu_font = theme.font
theme.menu_bg_focus = theme.xcolor4 .. 70
theme.menu_fg_focus = theme.xcolor7
theme.menu_bg_normal = theme.xbackground
theme.menu_fg_normal = theme.xcolor7
theme.menu_submenu_icon = gears.filesystem.get_configuration_dir() .. 'theme/icons/submenu.png'
theme.menu_height = dpi(20)
theme.menu_width = dpi(130)
theme.menu_border_color = theme.xcolor8
theme.menu_border_width = theme.border_width / 2

-- Hotkeys Pop Up
--
theme.hotkeys_font = theme.font
theme.hotkeys_border_color = theme.xcolor0
theme.hotkeys_group_margin = dpi(40)
theme.hotkeys_shape = helpers.rrect(25)

-- Layout List
--
theme.layoutlist_border_color = theme.xcolor8
theme.layoutlist_border_width = theme.border_width
theme.layoutlist_shape_selected = gears.shape.squircle
theme.layoutlist_bg_selected = theme.xcolor7 .. 55
theme.layoutlist_fg_selected = theme.xcolor15 .. 55

-- Recolor Layout icons:
theme = theme_assets.recolor_layout(theme, theme.xforeground)

-- Gaps
--
theme.useless_gap = dpi(10)

-- Exit Screen
--
theme.exit_screen_fg = theme.xforeground
theme.exit_screen_bg = theme.xbackground .. '88'

-- Wibar
--
theme.wibar_height = dpi(43) + theme.widget_border_width
theme.wibar_margin = dpi(6)
theme.wibar_spacing = dpi(15)
theme.wibar_bg = theme.xbackground .. '88'
theme.wibar_bg_secondary = theme.xcolor0 .. '88'
-- theme.xcolor0 .. 55

-- Systray
--
theme.systray_icon_spacing = dpi(10)
theme.bg_systray = theme.xcolor0
theme.systray_icon_size = dpi(32)

-- Collision
--
theme.collision_focus_bg = theme.xcolor0
theme.collision_focus_fg = theme.xcolor6
theme.collision_focus_shape = helpers.rrect(theme.border_radius)
theme.collision_focus_border_width = theme.border_width
theme.collision_focus_border_color = theme.border_normal

theme.collision_focus_bg_center = theme.xcolor8
theme.collision_shape_width = dpi(50)
theme.collision_shape_height = dpi(50)
theme.collision_focus_shape_center = gears.shape.circle

theme.collision_max_bg = theme.xbackground
theme.collision_max_fg = theme.xcolor8
theme.collision_max_shape = helpers.rrect(0)
theme.bg_urgent = theme.xcolor1

theme.collision_resize_width = dpi(20)
theme.collision_resize_shape = theme.collision_focus_shape
theme.collision_resize_border_width = theme.collision_focus_border_width
theme.collision_resize_border_color = theme.collision_focus_border_color
theme.collision_resize_padding = dpi(5)
theme.collision_resize_bg = theme.collision_focus_bg
theme.collision_resize_fg = theme.collision_focus_fg

theme.collision_screen_shape = theme.collision_focus_shape
theme.collision_screen_border_width = theme.collision_focus_border_width
theme.collision_screen_border_color = theme.collision_focus_border_color
theme.collision_screen_padding = dpi(5)
theme.collision_screen_bg = theme.xbackground
theme.collision_screen_fg = theme.xcolor4
theme.collision_screen_bg_focus = theme.xcolor0
theme.collision_screen_fg_focus = theme.xcolor4

-- Tabs
--
theme.mstab_bar_height = dpi(60)
theme.mstab_bar_padding = dpi(0)
theme.mstab_border_radius = dpi(6)
theme.tabbar_style = 'boxes'
theme.tabbar_bg_focus = theme.xbackground
theme.tabbar_bg_normal = theme.xcolor0
theme.tabbar_fg_focus = theme.xcolor7
theme.tabbar_fg_normal = theme.xcolor15 .. '55'
theme.tabbar_position = 'left'
theme.tabbar_AA_radius = 0
theme.tabbar_size = 40
theme.mstab_bar_ontop = true

theme.notification_spacing = 10
theme.notif_border_radius = dpi(10)
theme.notif_border_width = dpi(3)

-- Weather
--
theme.weather_city = 'San_Francisco'

-- Swallowing
--
theme.dont_swallow_classname_list = {
    'firefox',
    'gimp',
    'Google-chrome',
    'Thunar'
}

-- Layout Machi
--
theme.machi_switcher_border_color = theme.xcolor4
theme.machi_switcher_border_opacity = 0.25
theme.machi_editor_border_color = theme.xcolor1
theme.machi_editor_border_opacity = 0.25
theme.machi_editor_active_opacity = 0.25

-- Tag Preview
--
theme.tag_preview_widget_border_radius = dpi(10)
theme.tag_preview_client_border_radius = dpi(7)
theme.tag_preview_client_opacity = 0.5
theme.tag_preview_client_bg = theme.xcolor0
theme.tag_preview_client_border_color = theme.xcolor0
theme.tag_preview_client_border_width = dpi(3)
theme.tag_preview_widget_bg = theme.xbackground
theme.tag_preview_widget_border_color = theme.widget_border_color
theme.tag_preview_widget_border_width = theme.widget_border_width
theme.tag_preview_widget_margin = dpi(15)

theme.fade_duration = 375

return theme
