-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Instead of having a file for consistent defaults and another providing color
-- configurations as is a standard site in Awesomewm configs, I have settled on a
-- single theme because I don't really need to switch between themes anyway so having
-- such tooling is just another thing that can cause debugging nightmares for me YMMV
local filesystem = require('gears.filesystem')
local theme_dir = filesystem.get_configuration_dir() .. '/theme'

local dpi = require('beautiful').xresources.apply_dpi
local gtk = require('beautiful.gtk')
local gfs = require('gears.filesystem')
local theme_assets = require('beautiful.theme_assets')

-- ########################################################################
-- ########################################################################
-- ########################################################################
local theme = {}
local awesome_overrides = function(theme)
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################

    -- Colors Pallets
    -- Load ~/.Xresources colors and set fallback colors
    theme.xbackground = '#17191e'
    theme.background = '#17191e'
    theme.xforeground = '#b2bfd9'
    theme.foreground = '#b2bfd9'
    theme.xcolor0 = '#22262d'
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
    theme.background_transparency = '33'

    -- Custom
    theme.custom = theme.xcolor15

    theme.transparent = '#00000000'

    -- gtk theme
    theme.gtk = gtk.get_theme_variables()

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################

    -- system stat charts in settings app
    theme.cpu_bar = theme.xcolor1
    theme.ram_bar = theme.xcolor2
    theme.disk_bar = theme.xcolor3

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################

    -- Basic Theme Set Up
    theme.dir = theme_dir
    theme.titlebar_size = 24
    theme.icons = theme.dir .. '/icons/'
    theme.wallpaper = theme_dir .. '/wallpapers/wp33.png'

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################

    -- Fonts
    theme.font = 'SF Mono Powerline Bold '
    theme.monitor_font = 'SF Mono Powerline Bold 50'
    theme.title_font = 'SF Mono Powerline Bold 18'
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################

    -- Modal variables
    theme.modal_width = dpi(1200)
    theme.modal_height = dpi(800)

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################

    -- Foreground Colors
    theme.text = theme.foreground
    theme.fg_white = theme.xcolo15
    theme.fg_black = theme.xcolor17
    theme.fg_normal = theme.xcolor15
    theme.fg_focus = theme.xcolor15
    theme.fg_urgent = theme.xcolor9
    theme.bat_fg_critical = theme.xcolor9
    theme.fg_minimize = theme.foreground

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################

    -- Background colors (cannot be linear gradients for whatever reason)
    theme.bg_focus = theme.xcolor18
    theme.bg_urgent = theme.xcolor1
    theme.bg_systray = theme.xcolor18
    theme.bg_modal = theme.xbackground .. '88'
    theme.bg_modal_title = theme.xbackground .. '88'
    theme.bg_settings_display_number = theme.xbackground .. '88'
    theme.bg_normal = theme.background
    theme.bg_button = theme.xbackground
    theme.bg_widget = theme.xcolor0

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################

    -- Notification
    theme.notification_position = 'top_right'
    theme.notification_bg = theme.transparent
    theme.notification_margin = dpi(5)
    theme.notification_border_width = dpi(0)
    theme.notification_border_color = theme.transparent
    theme.notification_spacing = dpi(0)
    theme.notification_icon_resize_strategy = 'center'
    theme.notification_icon_size = dpi(32)
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################

    -- Gap
    theme.useless_gap = dpi(6)
    theme.gap_single_client = true

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- UI Groups

    theme.groups_title_bg = theme.bg_modal_title
    theme.groups_bg = theme.bg_modal
    theme.groups_radius = dpi(9)

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################

    -- Menu
    theme.menu_height = dpi(16)
    theme.menu_width = dpi(160)
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################

    -- Tooltips
    theme.tooltip_bg = {
        type = 'linear',
        from = {0, 0},
        to = {95, 95},
        stops = {
            {0, theme.xbackground .. '88'},
            {33, theme.xcolor8 .. '88'},
            {70, theme.xcolor18 .. '88'},
            {80, theme.xcolor22 .. '88'},
            {90, theme.xbackground .. '88'}
        }
    }

    theme.tooltip_border_color = theme.xcolor0 .. '88'
    theme.tooltip_border_width = 0
    theme.tooltip_shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, dpi(6))
    end

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################

    -- Layout
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
    -- TODO eliminate this section
    -- Buttons
    theme.border_button = theme.xcolor0
    theme.button_active = theme.color5
    theme.button_active_alt = theme.xcolor4

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################

    -- Tasklist
    -- Background
    theme.tasklist_font = theme.font
    theme.tasklist_bg_normal = {
        type = 'linear',
        from = {0, 0},
        to = {15, 15},
        stops = {
            {0, theme.xbackground .. '88'},
            {3, theme.xcolor18 .. '88'},
            {7, theme.xcolor8 .. '88'},
            {12, theme.xbackground .. '88'},
            {15, theme.xcolor0 .. '88'}
        }
    }

    theme.tasklist_bg_focus = {
        type = 'linear',
        from = {0, 0},
        to = {65, 65},
        stops = {
            {0, theme.xbackground .. '88'},
            {15, theme.xcolor0 .. '88'},
            {30, theme.xcolor8 .. '88'},
            {45, theme.xcolor17 .. '88'},
            {60, theme.xcolor19 .. '88'}
        }
    }

    theme.tasklist_bg_urgent = {
        type = 'linear',
        from = {0, 0},
        to = {65, 65},
        stops = {
            {0, theme.xbackground .. '88'},
            {30, theme.xcolor9 .. '88'},
            {40, theme.xcolor21 .. '88'},
            {65, theme.xcolor19 .. '88'}
        }
    }
    -- foreground
    theme.tasklist_fg_focus = theme.xcolor15
    theme.tasklist_fg_urgent = theme.xcolor1
    theme.tasklist_fg_normal = theme.foreground

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Taglist
    theme.taglist_spacing = 1
    -- colors
    -- theme.taglist_bg_empty = {
    --     type = 'linear',
    --     from = {0, 0},
    --     to = {-85, -85},
    --     stops = {
    --         {0, theme.xbackground .. '88'},
    --         {0.45, theme.xcolor7 .. '88'},
    --         {0.85, theme.xcolor21 .. '88'},
    --         {1, theme.xcolor19 .. '88'}
    --     }
    -- }
    -- theme.taglist_bg_occupied = {
    --     type = 'linear',
    --     from = {0, 0},
    --     to = {-35, -35},
    --     stops = {
    --         {0, theme.xcolor0 .. '88'},
    --         {0.45, theme.xcolor7 .. '88'},
    --         {0.85, theme.xcolor21 .. '88'},
    --         {1, theme.xcolor19 .. '88'}
    --     }
    -- }
    -- theme.taglist_bg_urgent = {
    --     type = 'linear',
    --     from = {0, 0},
    --     to = {35, 35},
    --     stops = {
    --         {0, theme.xcolor0 .. '88'},
    --         {0.45, theme.xcolor7 .. '88'},
    --         {0.85, theme.xcolor16 .. '88'},
    --         {1, theme.xcolor19 .. '88'}
    --     }
    -- }
    -- theme.taglist_bg_focus = {
    --     type = 'linear',
    --     from = {0, 0},
    --     to = {115, 15},
    --     stops = {
    --         {0, theme.xbackground .. '88'},
    --         {0.45, theme.xcolor7 .. '88'},
    --         {0.85, theme.xforeground .. '88'},
    --         {1, theme.xcolor18 .. '88'}
    --     }
    -- }
    -- theme.taglist_bg = {
    --     type = 'linear',
    --     from = {0, 0},
    --     to = {65, 65},
    --     stops = {
    --         {0, theme.xbackground .. '88'},
    --         {0.45, theme.xcolor7 .. '88'},
    --         {0.85, theme.xcolor18 .. '88'},
    --         {1, theme.xbackground .. '88'}
    --    }
    -- }
    theme.taglist_bg = theme.xbackground .. '00'
    theme.taglist_fg_focus = theme.xforeground
    theme.taglist_fg_urgent = theme.xcolor1
    theme.taglist_fg_occupied = theme.xcolor7
    theme.taglist_fg_empty = theme.xcolor15

    theme.taglist_fg_volatile = theme.xcolor9
    theme.taglist_font = 'awesomewm-font 16'
    local taglist_square_size = dpi(0)
    theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.xforeground)
    theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    theme.icon_theme = 'chhinamasta'
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Borders
    theme.border_radius = dpi(12)
    theme.maximized_hide_border = true
    theme.border_width = dpi(0)
    theme.border_normal = theme.xcolor18 .. '00'
    theme.border_focus = theme.xcolor18 .. '00'
    theme.border_marked = theme.xcolor8 .. '00'
    theme.btn_border_width = dpi(1)
    theme.widget_border_width = dpi(1)
    theme.border_color = theme.xcolor0 .. '00'

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################

    -- Margins and paddings
    theme.notification_margin = dpi(2)
    theme.widget_margin = dpi(1)
    theme.btn_xs_margin = dpi(1)
    theme.btn_md_margin = dpi(1)
    theme.widget_margin = dpi(1)
    theme.is_enable_titlebar = true

    -- ####################################################################
    -- ####################################################################
    -- TODO use beautiful.[whatever from below] over other shape solutions present in configuration
    theme.btn_xs_shape = function(cr, height, width)
        gears.shape.rounded_rect(cr, height, width, 2)
    end

    theme.btn_lg_shape = function(cr, height, width)
        gears.shape.rounded_rect(cr, height, width, 3)
    end

    theme.widget_shape = function(cr, height, width)
        gears.shape.rounded_rect(cr, height, width, 8)
    end
    theme.panel_button_shape = function(cr, height, width)
        gears.shape.rounded_rect(cr, height, width, 8)
    end

    theme.window_shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 24)
    end

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Snap area
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
    theme.notification_font = theme.font
    theme.notification_bg = {
        type = 'linear',
        from = {0, 0},
        to = {125, 125},
        stops = {
            {0, theme.xbackground .. '88'},
            {0.45, theme.xcolor0 .. '88'},
            {0.85, theme.xbackground .. '88'},
            {1, theme.xcolor19 .. '88'}
        }
    }
    theme.notification_fg = theme.fg_normal
    theme.notification_shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 8)
    end

    theme.notification_width = dpi(165)
    theme.notification_max_width = dpi(265)
    theme.notification_icon_size = 64
    theme.notification_spacing = dpi(8)
    theme.notification_border_width = 0
    theme.notification_border_color = theme.fg_focus

    -- ####################################################################
    -- systray
    -- ####################################################################
    theme.bg_systray = {
        type = 'linear',
        from = {0, 0},
        to = {-55, -55},
        stops = {
            {0, theme.xbackground .. '88'},
            {0.45, theme.xcolor0 .. '88'},
            {0.85, theme.xbackground .. '88'},
            {1, theme.xcolor19 .. '88'}
        }
    }

    -- Generate Awesome icon:
    theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

    -- Titlebar
    theme.titlebar_size = dpi(24)

    -- UI Groups

    theme.layout_stackLeft = theme_dir .. '/icons/layouts/stack_left.png'
    theme.layout_stack = theme_dir .. '/icons/layouts/stack.png'
    theme.layout_centermaster = theme_dir .. '/icons/layouts/centermaster.png'
    theme.layout_empathy = theme_dir .. '/icons/layouts/empathy.png'
    theme.layout_max = theme_dir .. '/icons/layouts/max.png'
    theme.layout_tile = theme_dir .. '/icons/layouts/tile.png'
    theme.layout_dwindle = theme_dir .. '/icons/layouts/dwindle.png'
    theme.layout_floating = theme_dir .. '/icons/layouts/floating.png'
    theme.layout_magnifier = theme_dir .. '/icons/layouts/magnifier.png'
    theme.layout_fairv = theme_dir .. '/icons/layouts/fairv.png'
    theme.layout_fairh = theme_dir .. '/icons/layouts/fairh.png'
    theme.layout_cornernw = theme_dir .. '/icons/layouts/cornernw.png'
end
return {
    theme = theme,
    awesome_overrides = awesome_overrides
}
