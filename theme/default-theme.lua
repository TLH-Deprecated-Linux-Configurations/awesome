-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Instead of having a file for consistent defaults and another providing color
-- configurations as is a standard site in Awesomewm configs, I have settled on a
-- single theme because I don't really need to switch between themes anyway so having
-- such tooling is just another thing that can cause debugging nightmares for me YMMV
local filesystem = require "gears.filesystem"
local theme_dir = filesystem.get_configuration_dir() .. "/theme"
local dpi = require "beautiful".xresources.apply_dpi
local gtk = require "beautiful.gtk"
local theme_assets = require "beautiful.theme_assets"
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
    theme.xbackground = "#17191e"
    theme.background = "#17191e"
    theme.xforeground = "#b2bfd9"
    theme.foreground = "#b2bfd9"
    theme.xcolor0 = "#17191e"
    theme.xcolor1 = "#ff28a9"
    theme.xcolor2 = "#44ffdd"
    theme.xcolor3 = "#f0ffaa"
    theme.xcolor4 = "#0badff"
    theme.xcolor5 = "#8265ff"
    theme.xcolor6 = "#00eaff"
    theme.xcolor7 = "#8b9cbe"
    theme.xcolor8 = "#555e70"
    theme.xcolor9 = "#ff3d81"
    theme.xcolor10 = "#00ffcc"
    theme.xcolor11 = "#f9f871"
    theme.xcolor12 = "#00caff"
    theme.xcolor13 = "#6c71c4"
    theme.xcolor14 = "#00fae9"
    theme.xcolor15 = "#f4f4f7"
    theme.xcolor16 = "#0e0f12"
    theme.xcolor51 = "#1C1E24"
    theme.xcolor17 = "#121418"
    theme.xcolor18 = "#22262d"
    theme.xcolor19 = "#23262e"
    theme.xcolor20 = "#484d5e"
    theme.xcolor21 = "#636a82"
    theme.xcolor22 = "#767f9c"
    theme.xcolor23 = "#919cbf"

    theme.background_transparency = "cc"
    -- Custom
    theme.custom = theme.xcolor15
    theme.transparent = "#00000000"
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
    theme.icons = theme.dir .. "/icons/"
    theme.wallpaper = theme_dir .. "/wallpapers/10.png"
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Fonts
    theme.taglist_font = "awesomewm-font 16"
    theme.font = "Commodore 64 Rounded Regular "
    theme.monitor_font = "Commodore 64 Rounded Regular 50"
    theme.title_font = "Commodore 64 Rounded Regular 18"
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
    theme.bg_modal = theme.xbackground .. "cc"
    theme.bg_modal_title = theme.xcolor8 .. "cc"
    theme.bg_settings_display_number = theme.xbackground .. "cc"
    theme.bg_normal = theme.background
    theme.bg_button = theme.xbackground
    theme.bg_widget = theme.xcolor0
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Notification
    theme.notification_position = "top_right"
    theme.notification_bg = theme.transparent
    theme.notification_margin = dpi(5)
    theme.notification_border_width = dpi(0)
    theme.notification_border_color = theme.xcolor7 .. "aa"
    theme.notification_spacing = dpi(0)
    theme.notification_icon_resize_strategy = "center"
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
    theme.tooltip_bg = "radial:960,540,20:960,540,500:0,#22262daa:0.2,#3c3f4c88:0.65,#17191e88:1,#272a3488"
    theme.tooltip_border_color = theme.xcolor0 .. "cc"
    theme.tooltip_border_width = 0
    theme.tooltip_shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, dpi(6))
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Layout
    theme.layout_max = theme.icons .. "layouts/arrow-expand-all.png"
    theme.layout_tile = theme.icons .. "layouts/view-quilt.png"
    theme.layout_dwindle = theme.icons .. "layouts/dwindle.png"
    theme.layout_floating = theme.icons .. "layouts/floating.png"
    theme.layout_fairv = theme.icons .. "layouts/fair.png"
    theme.layout_fairh = theme.icons .. "layouts/fairh.png"
    theme.layout_magnifier = theme.icons .. "layouts/magnifier.png"
    theme.layout_mstab = theme.icons .. "layouts/mstab.png"
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################

    -- Buttons
    theme.border_button = theme.xcolor7 .. "66"
    theme.button_active = theme.xcolor7 .. "dd"
    theme.button_active_alt = theme.xcolor4
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Tasklist
    -- Background
    theme.tasklist_font = theme.font
    theme.tasklist_bg_normal = "radial:960,540,20:960,540,500:0,#22262daa:0.2,#3c3f4c88:0.65,#17191e88:1,#272a3488"
    theme.tasklist_bg_focus = "radial:960,540,10:0,0,10:0,##17191ecc:0.34,#3c3f4caa:0.65,#22262d88:1,#22262d88"
    theme.tasklist_bg_urgent = "radial:960,540,10:0,0,10:0,##17191ecc:0.34,#3c3f4caa:0.65,#22262d88:1,#22262d88"
    -- foreground
    theme.tasklist_fg_focus = theme.xcolor15
    theme.tasklist_fg_urgent = theme.xcolor1
    theme.tasklist_fg_normal = theme.foreground
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Taglist
    theme.taglist_spacing = 8
    -- colors
    -- theme.taglist_bg_empty = "radial:960,540,10:0,0,10:0,##17191ecc:0.34,#3c3f4caa:0.65,#12141888:1,#12141888"
    -- theme.taglist_bg_occupied = "radial:960,540,10:0,0,10:0,##17191ecc:0.34,#3c3f4caa:0.65,#12141888:1,#12141888"
    -- theme.taglist_bg_urgent = "radial:960,540,10:0,0,10:0,##17191ecc:0.34,#3c3f4caa:0.65,#12141888:1,#12141888"
    -- theme.taglist_bg = "radial:960,540,10:0,0,10:0,#343a50cc:0.34,#3c3f4caa:0.65,#12141888:1,#12141888"
    theme.taglist_fg_empty = theme.xcolor8 .. "aa"
    theme.taglist_fg_focus = theme.xcolor15
    theme.taglist_fg_occupied = theme.xcolor7
    theme.taglist_border_color = theme.xcolor7 .. "66"

    -- theme.taglist_border_width = dpi(2)
    -- theme.taglist_fg_urgent = theme.xcolor1
    -- theme.taglist_fg_occupied = theme.xcolor7
    -- theme.taglist_fg_empty = theme.xcolor7
    -- theme.taglist_fg_volatile = theme.xcolor9
    theme.taglist_shape = theme.btn_lg_shape

    local taglist_square_size = dpi(0)
    theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.xforeground)
    theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    theme.icon_theme = "chhinamasta"
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Borders
    theme.border_radius = dpi(12)
    theme.maximized_hide_border = true
    theme.border_width = dpi(0)
    theme.border_normal = theme.xcolor7 .. "88"
    theme.border_focus = theme.xcolor7 .. "aa"
    theme.border_marked = theme.xcolor7 .. "cc"
    theme.btn_border_width = dpi(4)
    theme.widget_border_width = dpi(1)
    theme.border_color = theme.xcolor7 .. "cc"
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Margins and paddings
    theme.notification_margin = dpi(2)
    theme.widget_margin = dpi(12)
    theme.btn_xs_margin = dpi(2)
    theme.btn_md_margin = dpi(4)
    theme.widget_margin = dpi(6)
    theme.is_enable_titlebar = true
    -- ####################################################################
    -- ####################################################################

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
    theme.notification_bg =  "radial:960,540,20:960,540,500:0,#22262daa:0.2,#3c3f4c88:0.65,#17191e88:1,#272a3488"
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
        type = "linear",
        from = {0, 0},
        to = {-55, -55},
        stops = {
            {0, theme.xbackground .. "cc"},
            {0.45, theme.xcolor0 .. "cc"},
            {0.85, theme.xbackground .. "cc"},
            {1, theme.xcolor19 .. "cc"}
        }
    }
    -- Generate Awesome icon:
    theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)
    -- Titlebar
    theme.titlebar_size = dpi(28)
    -- UI Groups
    theme.layout_stackLeft = theme_dir .. "/icons/layouts/stack_left.png"
    theme.layout_stack = theme_dir .. "/icons/layouts/stack.png"
    theme.layout_centermaster = theme_dir .. "/icons/layouts/centermaster.png"
    theme.layout_empathy = theme_dir .. "/icons/layouts/empathy.png"
    theme.layout_max = theme_dir .. "/icons/layouts/max.png"
    theme.layout_tile = theme_dir .. "/icons/layouts/tile.png"
    theme.layout_dwindle = theme_dir .. "/icons/layouts/dwindle.png"
    theme.layout_floating = theme_dir .. "/icons/layouts/floating.png"
    theme.layout_magnifier = theme_dir .. "/icons/layouts/magnifier.png"
    theme.layout_fairv = theme_dir .. "/icons/layouts/fairv.png"
    theme.layout_fairh = theme_dir .. "/icons/layouts/fairh.png"
    theme.layout_cornernw = theme_dir .. "/icons/layouts/cornernw.png"
    theme.layout_thrizen = theme_dir .. "/icons/layouts/thrizen.png"
end
return {theme = theme, awesome_overrides = awesome_overrides}
