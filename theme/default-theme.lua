-- ########################################################################
--  _____         ___               __ __
-- |     \.-----.'  _|.---.-.--.--.|  |  |_
-- |  --  |  -__|   _||  _  |  |  ||  |   _|
-- |_____/|_____|__|  |___._|_____||__|____|
--  _______ __
-- |_     _|  |--.-----.--------.-----.
--   |   | |     |  -__|        |  -__|
--   |___| |__|__|_____|__|__|__|_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Instead of having a file for consistent defaults and another providing color
-- configurations as is a standard site in Awesomewm configs, I have settled on a
-- single theme because I don't really need to switch between themes anyway so having
-- such tooling is just another thing that can cause debugging nightmares for me YMMV
--
local filesystem = require 'gears.filesystem'
local theme_dir = filesystem.get_configuration_dir() .. '/theme'
local dpi = require 'beautiful'.xresources.apply_dpi
local gtk = require 'beautiful.gtk'
local theme_assets = require 'beautiful.theme_assets'
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Theming Function Boilerplate
--
local theme = {}
local awesome_overrides = function(theme)
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- GTK Theme
    --
    theme.gtk = gtk.get_theme_variables()
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Colors Pallets
    -- Load ~/.Xresources colors and set fallback colors
    --
    theme.xbackground = theme.gtk.bg_color
    theme.background = theme.gtk.bg_color
    theme.xforeground = theme.gtk.fg_color
    theme.foreground = theme.gtk.fg_color
    theme.xcolor0 = '#17191e'
    theme.xcolor1 = '#ff28a9'
    theme.xcolor2 = '#44ffdd'
    theme.xcolor3 = '#f0ffaa'
    theme.xcolor4 = '#0badff'
    theme.xcolor5 = '#8265ff'
    theme.xcolor6 = '#00eaff'
    theme.xcolor7 = '#8b9cbe'
    theme.xcolor8 = '#555e70'
    theme.xcolor9 = '#ff3d81'
    theme.xcolor10 = '#00ffcc'
    theme.xcolor11 = '#f9f871'
    theme.xcolor12 = '#00caff'
    theme.xcolor13 = '#6c71c4'
    theme.xcolor14 = '#00fae9'
    theme.xcolor15 = '#f4f4f7'
    theme.xcolor16 = '#0e0f12'
    theme.xcolor51 = '#1C1E24'
    theme.xcolor17 = '#121418'
    theme.xcolor18 = '#22262d'
    theme.xcolor19 = '#23262e'
    theme.xcolor20 = '#484d5e'
    theme.xcolor21 = '#636a82'
    theme.xcolor22 = '#767f9c'
    theme.xcolor23 = '#919cbf'
    theme.xcolor24 = '#C1C1E0'
    theme.xcolor25 = '#b2bfd9'
    theme.background_transparency = 'cc'
    -- ########################################################################
    -- Custom
    --
    theme.custom = theme.xcolor15
    theme.transparent = '#00000000'

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Basic Theme Set Up
    --
    theme.dir = theme_dir

    theme.icons = theme.dir .. '/icons/'
    theme.wallpaper = theme_dir .. '/wallpapers/13.png'
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Fonts
    --
    theme.taglist_font = 'awesomewm-font 18'
    theme.font = 'Commodore 64 Rounded Regular '
    theme.monitor_font = 'Commodore 64 Rounded Regular 50'
    theme.title_font = 'Commodore 64 Rounded Regular 18'

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Modal variables
    theme.modal_width = dpi(1.2e3)
    theme.modal_height = dpi(800)

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Foreground Colors
    --
    theme.text = theme.foreground
    theme.fg_white = theme.xcolo15
    theme.fg_normal = theme.xcolor15
    theme.fg_focus = theme.xcolor15
    theme.fg_urgent = theme.xcolor9
    theme.bat_fg_critical = theme.xcolor9
    theme.fg_minimize = theme.foreground
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Background colors (where the magic happens for the skeuomorphic thing)
    --
    theme.bg_focus = 'linear:0,0:0,21:0,#555e70:1,#22262d'
    theme.bg_urgent = theme.xcolor1
    theme.bg_systray = 'linear:0,0:0,32:0,#484d5e:1,#22262d'
    theme.bg_modal = 'linear:0,0:0,21:0,#484d5ecc:1,#22262dcc'
    theme.bg_modal_title = 'linear:0,0:0,21:0,#484d5e:1,#22262d'
    theme.bg_settings_display_number = theme.xbackground .. 'cc'
    theme.bg_normal = 'linear:0,0:0,21:0,#484d5e:1,#22262d'
    theme.bg_button = 'linear:0,0:0,21:0,#7786A3:1,#22262d'
    theme.bg_button_press = 'linear:0,0:0,21:0,#7786A3:1,#484d5e'
    theme.bg_widget = 'linear:0,0:0,11:0,#484d5ecc:1,#22262dcc'

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Notification
    --
    theme.notification_position = 'top_right'
    theme.notification_bg = 'linear:0,0:0,21:0,#484d5e:1,#22262d'
    theme.notification_margin = dpi(5)
    theme.notification_border_width = dpi(0)
    theme.notification_border_color = theme.xcolor21 .. 'aa'
    theme.notification_spacing = dpi(0)
    theme.notification_icon_resize_strategy = 'center'
    theme.notification_icon_size = dpi(32)

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Gap
    --
    theme.useless_gap = dpi(6)
    theme.gap_single_client = true

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- UI Groups
    --
    theme.groups_title_bg = 'linear:0,0:0,21:0,#484d5e:1,#22262d'
    theme.groups_bg = theme.bg_modal
    theme.groups_radius = dpi(9)

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Menu
    --
    theme.menu_height = dpi(16)
    theme.menu_width = dpi(160)
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Tooltips
    --
    theme.tooltip_bg = 'linear:0,0:0,21:0,#484d5e:1,#22262d'
    theme.tooltip_border_color = theme.border_focus
    theme.tooltip_border_width = 0
    theme.tooltip_shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, dpi(6))
    end

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Layout
    --
    theme.layout_max = theme.icons .. 'layouts/arrow-expand-all.png'
    theme.layout_tile = theme.icons .. 'layouts/view-quilt.png'
    theme.layout_dwindle = theme.icons .. 'layouts/dwindle.png'
    theme.layout_floating = theme.icons .. 'layouts/floating.png'
    theme.layout_fairv = theme.icons .. 'layouts/fair.png'
    theme.layout_fairh = theme.icons .. 'layouts/fairh.png'
    theme.layout_magnifier = theme.icons .. 'layouts/magnifier.png'
    theme.layout_mstab = theme.icons .. 'layouts/mstab.png'

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Buttons
    --
    theme.border_button = theme.xcolor21 .. 'bb'
    theme.button_active = theme.xcolor21 .. 'dd'

    theme.button_active_alt = theme.xcolor7 .. 'cc'

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Tasklist
    -- Background
    --
    theme.tasklist_font = theme.font
    theme.tasklist_bg_normal = 'linear:0,0:0,21:0,#2f303d:1,#1C1E24'
    theme.tasklist_bg_focus = 'linear:0,0:0,21:0,#484d5e:1,#23262e'
    theme.tasklist_bg_urgent = 'linear:0,0:0,21:0,#2f303d:1,#1C1E24'
    -- ########################################################################
    -- Foreground
    --
    theme.tasklist_fg_focus = theme.xcolor15
    theme.tasklist_fg_urgent = theme.xcolor1
    theme.tasklist_fg_normal = theme.foreground
    -- ########################################################################
    -- Shape
    --
    theme.tasklist_shape = function(cr, height, width)
        gears.shape.rounded_rect(cr, height, width, 8)
    end
    theme.tasklist_shape_border_color = theme.xcolor21 .. '66'
    theme.tasklist_shape_border_width = dpi(2)
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Taglist
    --
    theme.taglist_spacing = dpi(8)
    -- ########################################################################
    -- Background
    --
    theme.taglist_bg_empty = 'linear:0,0:0,21:0,#484d5e:1,#22262d'
    theme.taglist_bg_occupied = 'linear:0,0:0,21:0,#484d5e:1,#22262d'
    theme.taglist_bg_urgent = 'linear:0,0:0,21:0,#484d5e:1,#22262d'
    theme.taglist_bg = 'linear:0,0:0,21:0,#484d5e:1,#22262d'

    theme.taglist_border_color = theme.xcolor21 .. '66'

    -- ########################################################################
    -- Foreground
    --
    theme.taglist_fg_empty = theme.xcolor22
    theme.taglist_fg_focus = theme.xcolor15
    theme.taglist_fg_occupied = theme.xforeground

    -- ########################################################################
    -- Shape
    --
    theme.taglist_shape = theme.btn_md_shape

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Misc
    --
    local taglist_square_size = dpi(0)
    theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.xforeground)
    theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Icons
    --
    theme.icon_theme = 'chhinamasta'

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Borders
    --
    theme.border_radius = dpi(12)
    theme.maximized_hide_border = true
    theme.border_width = dpi(0)
    theme.border_normal = theme.xcolor21 .. '55'
    theme.border_focus = theme.xcolor7 .. '55'
    theme.border_marked = theme.xcolor21 .. '55'
    theme.btn_border_width = dpi(4)
    theme.widget_border_width = dpi(1)
    theme.border_color = theme.xcolor21 .. '55'

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Margins and paddings
    --
    theme.notification_margin = dpi(2)
    theme.widget_margin = dpi(12)
    theme.btn_xs_margin = dpi(2)
    theme.btn_md_margin = dpi(4)
    theme.widget_margin = dpi(6)

    -- ####################################################################
    -- ####################################################################
    -- ####################################################################
    -- shapes for buttons and beyond
    --
    theme.btn_xs_shape = function(cr, height, width)
        gears.shape.rounded_rect(cr, height, width, 1)
    end
    theme.btn_sm_shape = function(cr, height, width)
        gears.shape.rounded_rect(cr, height, width, 4)
    end
    theme.btn_md_shape = function(cr, height, width)
        gears.shape.rounded_rect(cr, height, width, 8)
    end
    theme.btn_lg_shape = function(cr, height, width)
        gears.shape.rounded_rect(cr, height, width, 12)
    end
    theme.widget_shape = function(cr, height, width)
        gears.shape.rounded_rect(cr, height, width, 8)
    end
    theme.panel_button_shape = function(cr, height, width)
        gears.shape.rounded_rect(cr, height, width, 6)
    end
    theme.window_shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 24)
    end

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Snap area
    --
    theme.snap_bg = theme.bg_button
    theme.snap_shape = function(cr, height, width)
        gears.shape.rounded_rect(cr, height, width, 8)
    end
    theme.snap_border_width = dpi(6)
    theme.snapper_gap = dpi(12)

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Notification
    --
    theme.notification_font = theme.font
    theme.notification_bg = 'linear:0,0:0,21:0,#484d5e:1,#22262d'
    theme.notification_fg = theme.fg_normal
    theme.notification_shape = theme.btn_md_shape
    theme.notification_width = dpi(165)
    theme.notification_max_width = dpi(265)
    theme.notification_icon_size = 64
    theme.notification_spacing = dpi(8)
    theme.notification_border_width = 0
    theme.notification_border_color = theme.taglist_fg_focus

    -- #########################################################################
    -- #########################################################################
    -- #########################################################################
    -- systray
    --
    theme.bg_systray = 'linear:0,0:0,21:0,#2f303d:1,#22262d'

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Generate Awesome icon:
    --
    theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Layout Icons
    --
    theme.layout_centermaster = theme_dir .. '/icons/layouts/centermaster.png'
    theme.layout_cornerne = theme_dir .. '/icons/layouts/cornerne.png'
    theme.layout_cornernw = theme_dir .. '/icons/layouts/cornernw.png'
    theme.layout_cornerse = theme_dir .. '/icons/layouts/cornerse.png'
    theme.layout_cornersw = theme_dir .. '/icons/layouts/cornersw.png'

    theme.layout_stackLeft = theme_dir .. '/icons/layouts/stack_left.png'
    theme.layout_stack = theme_dir .. '/icons/layouts/stack.png'

    theme.layout_empathy = theme_dir .. '/icons/layouts/empathy.png'
    theme.layout_max = theme_dir .. '/icons/layouts/max.png'
    theme.layout_tile = theme_dir .. '/icons/layouts/tile.png'
    theme.layout_tilebottom = theme_dir .. '/icons/layouts/tilebottom.png'
    theme.layout_tileleft = theme_dir .. '/icons/layouts/tileleft.png'
    theme.layout_tiletop = theme_dir .. '/icons/layouts/tiletop.png'
    theme.layout_dwindle = theme_dir .. '/icons/layouts/dwindle.png'
    theme.layout_floating = theme_dir .. '/icons/layouts/floating.png'
    theme.layout_magnifier = theme_dir .. '/icons/layouts/magnifier.png'
    theme.layout_fairv = theme_dir .. '/icons/layouts/fairv.png'
    theme.layout_fairh = theme_dir .. '/icons/layouts/fairh.png'
    theme.layout_thrizen = theme_dir .. '/icons/layouts/thrizen.png'
    theme.layout_fullscreen = theme_dir .. '/icons/layouts/fullscreen.png'
    theme.layout_spiral = theme_dir .. '/icons/layouts/spiral.png'
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Titlebar
    --

    awful.titlebar.enable_tooltip = true
    theme.titlebar_size = dpi(21)
    theme.titlebar_fg_normal = theme.xcolor15
    theme.titlebar_bg_normal = theme.bg_normal
    theme.titlebar_fg_focus = theme.xcolor15
    theme.titlebar_bg_focus = theme.bg_focus

    -- Titlebar Icons
    --
    local icon_path = gears.filesystem.get_configuration_dir() .. 'theme/icons/'
    local titlebar_icon_path = icon_path .. 'titlebar/dhumavati/'
    theme.titlebar_close_button_normal = titlebar_icon_path .. 'close-preseed.png'
    theme.titlebar_close_button_focus = titlebar_icon_path .. 'close-active.png'
    theme.titlebar_minimize_button_normal = titlebar_icon_path .. 'hide-preseed.png'
    theme.titlebar_minimize_button_focus = titlebar_icon_path .. 'hide-active.png'
    -- theme.titlebar_ontop_button_normal_inactive = titlebar_icon_path .. 'ontop_normal_inactive.png'
    -- theme.titlebar_ontop_button_focus_inactive = titlebar_icon_path .. 'ontop_focus_inactive.png'
    -- theme.titlebar_ontop_button_normal_active = titlebar_icon_path .. 'ontop_normal_active.png'
    -- theme.titlebar_ontop_button_focus_active = titlebar_icon_path .. 'ontop_focus_active.png'
    -- theme.titlebar_sticky_button_normal_inactive = titlebar_icon_path .. 'sticky_normal_inactive.png'
    -- theme.titlebar_sticky_button_focus_inactive = titlebar_icon_path .. 'sticky_focus_inactive.png'
    -- theme.titlebar_sticky_button_normal_active = titlebar_icon_path .. 'sticky_normal_active.png'
    -- theme.titlebar_sticky_button_focus_active = titlebar_icon_path .. 'sticky_focus_active.png'
    -- theme.titlebar_floating_button_normal_inactive = titlebar_icon_path .. 'go-left.png'
    -- theme.titlebar_floating_button_focus_inactive = titlebar_icon_path .. 'go-left.png'
    -- theme.titlebar_floating_button_normal_active = titlebar_icon_path .. 'go-left.png'
    -- theme.titlebar_floating_button_focus_active = titlebar_icon_path .. 'go-left.png'
    theme.titlebar_maximized_button_normal_inactive = titlebar_icon_path .. 'maximize-preseed.png'
    theme.titlebar_maximized_button_focus_inactive = titlebar_icon_path .. 'maximize-active.png'
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Hot Keys Popup
    theme.hotkeys_modifiers_fg = theme.xcolor15
    theme.hotkeys_bg = theme.bg_normal
    theme.hotkeys_border_width = dpi(4)
    theme.hotkeys_border_color = theme.xcolor8
    theme.hotkeys_shape = theme.widget_shape
    theme.hotkeys_fg = theme.xcolor25
    theme.hotkeys_label_bg = theme.xcolor2
    theme.hotkeys_group_margin = dpi(4)
    theme.hotkeys_font = theme.font .. '11'

    theme.hotkeys_description_font = theme.font .. ' 9'
    theme.hotkeys_label_fg = theme.xcolor0
end

-- ########################################################################
return {
    theme = theme,
    awesome_overrides = awesome_overrides
}
