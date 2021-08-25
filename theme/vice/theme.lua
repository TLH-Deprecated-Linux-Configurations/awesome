--  ___ ___ __
-- |   |   |__|.----.-----.
-- |   |   |  ||  __|  -__|
--  \_____/|__||____|_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Theme based on and named for my custom base16 colorscheme.

-- Libraries and Modules
--
local theme_assets = require('beautiful.theme_assets')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local gears = require('gears')
local gfs = require('gears.filesystem')
local themes_path = gfs.get_themes_dir()
local helpers = require('helpers')

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Inherit default theme if present
local theme = dofile(themes_path .. 'default/theme.lua')
theme.wallpaper = gfs.get_configuration_dir() .. 'images/bg.png'
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Icons
--
local icon_path = gfs.get_configuration_dir() .. 'theme/icons/'

-- TODO remove avatar, since we all know what we look like and don't need to see it on our desktops
theme.me = gears.surface.load_uncached(gfs.get_configuration_dir() .. 'images/distro.png')

-- Distro Logo
--
theme.distro_logo = gears.surface.load_uncached(gfs.get_configuration_dir() .. 'theme/icons/ghosts/awesome.png')

-- Icons for Notif Center
--
-- TODO pull these from an icon theme
-- TODO icon theme lua file to import here and elsewhere
-- TODO move this to the notif-center itself
--
theme.clear_icon = icon_path .. 'notif-center/clear.png'
theme.clear_grey_icon = icon_path .. 'notif-center/clear_grey.png'
theme.notification_icon = icon_path .. 'notif-center/notification.png'
theme.delete_icon = icon_path .. 'notif-center/delete.png'
theme.delete_grey_icon = icon_path .. 'notif-center/delete_grey.png'
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Color theme, could have loaded from Xresources,
-- but prefer finer grain of control and extra colors (used for gradiaents)
--
theme.xbackground = xrdb.background or '#17191e'
theme.xforeground = xrdb.foreground or '#f4f4f7'
theme.xcolor0 = '#21242b'
theme.xcolor1 = '#ff28a9'
theme.xcolor2 = '#33ffdd'
theme.xcolor3 = '#f0ffaa'
theme.xcolor4 = '#0badff'
theme.xcolor5 = '#8265ff'
theme.xcolor6 = '#00eaff'
theme.xcolor7 = '#8b9cbe'
theme.xcolor8 = '#2e323d'
theme.xcolor9 = '#ff3d81'
theme.xcolor10 = '#00ffcc'
theme.xcolor11 = '#f9f871'
theme.xcolor12 = '#00caff'
theme.xcolor13 = '#6c71c4'
theme.xcolor14 = '#00fae9'
theme.xcolor15 = '#f4f4f7'
theme.xcolor16 = '#252830'
theme.xcolor17 = '#23262e'
theme.xcolor18 = '#292c36'
theme.xcolor19 = '#2d303b'
theme.xcolor20 = '#303440'
theme.xcolor21 = '#343845'
theme.xcolor22 = '#404554'
theme.xcolor23 = '#444959'
theme.xcolor24 = '#484d5e'
theme.xcolor25 = '#4c5163'
theme.xcolor26 = '#4f5569'
theme.xcolor27 = '#53596e'
theme.xcolor28 = '#575d73'
theme.xcolor29 = '#5b6278'
theme.xcolor30 = '#5f667d'
theme.xcolor31 = '#636a82'
theme.xcolor32 = '#676e87'
theme.xcolor33 = '#6a728c'
theme.xcolor34 = '#6e7691'
theme.xcolor35 = '#727b96'
theme.xcolor36 = '#767f9c'
theme.xcolor37 = '#7a83a1'
theme.xcolor38 = '#7e87a6'
theme.xcolor39 = '#828bab'
theme.xcolor40 = '#868fb0'
theme.xcolor41 = '#8994b5'
theme.xcolor42 = '#8d98ba'
theme.xcolor43 = '#919cbf'
theme.xcolor44 = '#919cbf'

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Fonts
--
theme.font_name = 'SFMono Nerd Font Bold '
theme.font = theme.font_name .. '10'
theme.icon_font_name = 'SFMono Nerd Font Bold '
theme.icon_font = theme.icon_font_name .. '18'
theme.font_taglist = theme.icon_font_name .. '13'
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Background Colors
--
theme.bg_dark = theme.xcolor0
theme.bg_normal = theme.xbackground
theme.bg_focus = theme.xcolor0
theme.bg_urgent = theme.xcolor0
theme.bg_minimize = theme.xcolor0
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Foreground Colors
--
theme.fg_normal = theme.xcolor7
theme.fg_focus = theme.xcolor4
theme.fg_urgent = theme.xcolor3
theme.fg_minimize = theme.xcolor7

theme.button_close = theme.xcolor1
-- ########################################################################
-- ########################################################################
-- ########################################################################
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
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Taglist
--
-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)
theme.taglist_font = theme.font_taglist
theme.taglist_bg = theme.wibar_bg
theme.taglist_bg_focus = theme.xbackground .. '00'
theme.taglist_fg_focus = theme.xcolor1
theme.taglist_bg_urgent = theme.xcolor0 .. '33'
theme.taglist_fg_urgent = theme.xcolor6
theme.taglist_bg_occupied = theme.xbackground .. '00'
theme.taglist_fg_occupied = theme.xcolor6
theme.taglist_bg_empty = theme.xbackground .. '00'
theme.taglist_fg_empty = theme.xcolor7
theme.taglist_bg_volatile = '#00000000'
theme.taglist_fg_volatile = theme.xcolor11
theme.taglist_disable_icon = true
theme.taglist_shape_focus = helpers.rrect(theme.border_radius)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Tasklist
--
theme.tasklist_font = theme.font
theme.tasklist_plain_task_name = true
theme.tasklist_bg_focus = {
    type = 'linear',
    from = {0, 0},
    to = {40, 40},
    stops = {
        {0, theme.xbackground .. '11'},
        {2, theme.xcolor0 .. '11'},
        {11, theme.xcolor16 .. '11'},
        {12, theme.xcolor0 .. '11'},
        {13, theme.xbackground .. '11'},
        {27, theme.xcolor0 .. '11'},
        {28, theme.xcolor16 .. '11'},
        {30, theme.xbackground .. '11'},
        {36, theme.xcolor18 .. '11'},
        {38, theme.xcolor0 .. '11'}
    }
}
theme.tasklist_fg_focus = theme.xcolor15

theme.tasklist_bg_minimize = theme.tasklist_bg_focus
theme.tasklist_fg_minimize = theme.xcolor3

theme.tasklist_bg_normal = theme.tasklist_bg_focus
theme.tasklist_fg_normal = theme.xcolor7

theme.tasklist_disable_task_name = false
theme.tasklist_disable_icon = false

theme.tasklist_bg_urgent = theme.tasklist_bg_focus
theme.tasklist_fg_urgent = theme.xcolor1

theme.tasklist_align = 'center'
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Titlebars
--
theme.titlebar_size = dpi(30)
theme.titlebar_height = dpi(20)
theme.titlebar_bg_focus = theme.xcolor0 .. 'cc'
theme.titlebar_bg_normal = {
    type = 'linear',
    from = {0, 0},
    to = {35, 35},
    stops = {
        {0, theme.xbackground .. '88'},
        {2, theme.xcolor16 .. '88'},
        {8, theme.xcolor20 .. '88'},
        {12, theme.xcolor25 .. '88'},
        {18, theme.xcolor16 .. '88'},
        {22, theme.xbackground .. '88'},
        {26, theme.xcolor0 .. '88'}
    }
}
theme.titlebar_fg_normal = theme.xcolor7
theme.titlebar_fg_focus = theme.xcolor15
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Edge snap
--
theme.snap_bg = theme.xcolor7
theme.snap_shape = helpers.rrect(0)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Prompts
--
theme.prompt_bg = '#00000000'
theme.prompt_fg = theme.xforeground
-- ########################################################################
-- ########################################################################
-- ########################################################################
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
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Hotkeys Pop Up
--
theme.hotkeys_font = theme.font
theme.hotkeys_border_color = theme.xcolor0
theme.hotkeys_group_margin = dpi(40)
theme.hotkeys_shape = helpers.rrect(25)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Layout List
--
theme.layoutlist_border_color = theme.xcolor8
theme.layoutlist_border_width = theme.border_width
theme.layoutlist_shape_selected = gears.shape.squircle
theme.layoutlist_bg_selected = theme.xcolor7 .. 55
theme.layoutlist_fg_selected = theme.xcolor15 .. 55
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Recolor Layout icons:
theme = theme_assets.recolor_layout(theme, theme.xcolor7)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Gaps
--
theme.useless_gap = dpi(10)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Exit Screen
--
theme.exit_screen_fg = theme.xforeground
theme.exit_screen_bg = theme.xbackground .. '88'
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Wibar
--
theme.wibar_height = dpi(43) + theme.widget_border_width
theme.wibar_margin = dpi(6)
theme.wibar_spacing = dpi(15)
theme.wibar_bg = {
    type = 'linear',
    from = {0, 0},
    to = {40, 40},
    stops = {
        {0, theme.xbackground .. '88'},
        {2, theme.xcolor0 .. '88'},
        {11, theme.xcolor16 .. '88'},
        {12, theme.xcolor0 .. '88'},
        {13, theme.xbackground .. '88'},
        {27, theme.xcolor0 .. '88'},
        {28, theme.xcolor16 .. '88'},
        {30, theme.xbackground .. '88'},
        {36, theme.xcolor18 .. '88'},
        {38, theme.xcolor0 .. '88'}
    }
}
theme.wibar_bg_secondary = {
    type = 'linear',
    from = {0, 0},
    to = {40, 40},
    stops = {
        {0, theme.xcolor0 .. '88'},
        {2, theme.xcolor16 .. '88'},
        {11, theme.xcolor18 .. '88'},
        {12, theme.xcolor22 .. '88'},
        {13, theme.xcolor25 .. '88'},
        {27, theme.xcolor27 .. '88'},
        {28, theme.xcolor22 .. '88'},
        {30, theme.xcolor23 .. '88'},
        {36, theme.xcolor20 .. '88'},
        {38, theme.xcolor16 .. '88'}
    }
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Systray
--
theme.systray_icon_spacing = dpi(10)
theme.systray_icon_size = dpi(32)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Collision
--
theme.collision_focus_bg = {
    type = 'linear',
    from = {0, 0},
    to = {40, 40},
    stops = {
        {0, theme.xbackground .. '88'},
        {2, theme.xcolor0 .. '88'},
        {11, theme.xcolor16 .. '88'},
        {12, theme.xcolor0 .. '88'},
        {13, theme.xbackground .. '88'},
        {27, theme.xcolor0 .. '88'},
        {28, theme.xcolor16 .. '88'},
        {30, theme.xbackground .. '88'},
        {36, theme.xcolor18 .. '88'},
        {38, theme.xcolor0 .. '88'}
    }
}
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
theme.collision_screen_bg = {
    type = 'linear',
    from = {0, 0},
    to = {40, 40},
    stops = {
        {0, theme.xcolor0 .. '88'},
        {2, theme.xcolor16 .. '88'},
        {11, theme.xcolor18 .. '88'},
        {12, theme.xcolor22 .. '88'},
        {13, theme.xcolor25 .. '88'},
        {27, theme.xcolor27 .. '88'},
        {28, theme.xcolor22 .. '88'},
        {30, theme.xcolor23 .. '88'},
        {36, theme.xcolor20 .. '88'},
        {38, theme.xcolor16 .. '88'}
    }
}
theme.collision_screen_fg = theme.xcolor4
theme.collision_screen_bg_focus = {
    type = 'linear',
    from = {0, 0},
    to = {40, 40},
    stops = {
        {0, theme.xcolor0 .. '88'},
        {2, theme.xcolor16 .. '88'},
        {11, theme.xcolor18 .. '88'},
        {12, theme.xcolor22 .. '88'},
        {13, theme.xcolor25 .. '88'},
        {27, theme.xcolor27 .. '88'},
        {28, theme.xcolor22 .. '88'},
        {30, theme.xcolor23 .. '88'},
        {36, theme.xcolor20 .. '88'},
        {38, theme.xcolor16 .. '88'}
    }
}
theme.collision_screen_fg_focus = theme.xcolor4
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Tabs
--
theme.mstab_bar_height = dpi(60)
theme.mstab_bar_padding = dpi(0)
theme.mstab_border_radius = dpi(6)
theme.tabbar_style = 'boxes'
theme.tabbar_bg_focus = theme.xcolor0 .. '88'
theme.tabbar_bg_normal = theme.xbackground .. '88'
theme.tabbar_fg_focus = theme.xcolor7
theme.tabbar_fg_normal = theme.xcolor15 .. '55'
theme.tabbar_position = 'top'
theme.tabbar_AA_radius = 0
theme.tabbar_size = 40
theme.mstab_bar_ontop = true

theme.notification_spacing = 10
theme.notif_border_radius = dpi(10)
theme.notif_border_width = dpi(3)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Weather
--
theme.weather_city = 'San_Francisco'
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Swallowing
--
theme.dont_swallow_classname_list = {
    'firefox',
    'gimp',
    'Google-chrome',
    'Thunar'
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Tag Preview
--
theme.tag_preview_widget_border_radius = dpi(10)
theme.tag_preview_client_border_radius = dpi(7)
theme.tag_preview_client_opacity = 0.5
theme.tag_preview_client_bg = theme.xcolor0 .. 'aa'
theme.tag_preview_client_border_color = theme.xcolor7 .. '88'
theme.tag_preview_client_border_width = dpi(3)
theme.tag_preview_widget_bg = theme.xbackground .. '88'
theme.tag_preview_widget_border_color = theme.widget_border_color
theme.tag_preview_widget_border_width = theme.widget_border_width
theme.tag_preview_widget_margin = dpi(15)

theme.fade_duration = 375

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Layout
--

theme.layout_stackLeftRaw = gfs.get_configuration_dir() .. 'theme/icons/layouts/stack_left.svg'
theme.layout_stackLeft = gears.color.recolor_image(theme.layout_stackLeftRaw, theme.xcolor7)

theme.layout_stackRaw = gfs.get_configuration_dir() .. 'theme/icons/layouts/stack.svg'
theme.layout_stack = gears.color.recolor_image(theme.layout_stackRaw, theme.xcolor7)

theme.layout_centermasterRaw = gfs.get_configuration_dir() .. 'theme/icons/layouts/centermaster.svg'
theme.layout_centermaster = gears.color.recolor_image(theme.layout_centermasterRaw, theme.xcolor7)

theme.layout_empathyRaw = gfs.get_configuration_dir() .. 'theme/icons/layouts/empathy.svg'
theme.layout_empathy = gears.color.recolor_image(theme.layout_empathyRaw, theme.xcolor7)

-- ########################################################################
-- ########################################################################
-- ########################################################################

return theme
