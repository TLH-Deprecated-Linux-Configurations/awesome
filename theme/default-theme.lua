local gears = require('gears')
local beautiful = require('beautiful')

local filesystem = gears.filesystem
local dpi = beautiful.xresources.apply_dpi
local gtk_variable = beautiful.gtk.get_theme_variables

local theme_dir = filesystem.get_configuration_dir() .. '/theme'
local titlebar_theme = 'dhumavati'
local titlebar_icon_path = theme_dir .. '/icons/titlebar/' .. titlebar_theme .. '/'
local tip = titlebar_icon_path

-- Create theme table
local theme = {}

-- Font
theme.font = 'SF Intermosaic   10'
theme.font_bold = 'SF Intermosaic B 10'

-- Menu icon theme
theme.icon_theme = 'chhinamasta'

local awesome_overrides = function(theme)
    theme.dir = theme_dir
    theme.icons = theme_dir .. '/icons/'

    -- Default wallpaper path
    theme.wallpaper = theme.dir .. '/wallpapers/10.png'

    -- Default font
    theme.font = 'SF Intermosaic B 10'

    -- Foreground
    theme.fg_normal = '#ffffffde'
    theme.fg_focus = '#e4e4e4'
    theme.fg_urgent = '#CC9393'

    theme.bg_normal = 'linear:0,0:0,21:0,#2f303d:1,#1C1E24'
    theme.bg_focus = 'linear:0,0:0,21:0,#484d5e:1,#23262e'
    theme.bg_urgent = 'linear:0,0:0,21:0,#2f303d:1,#1C1E24'

    -- System tray
    theme.bg_systray = theme.background
    theme.systray_icon_spacing = dpi(16)

    -- Titlebar
    theme.titlebar_size = dpi(24)
    theme.titlebar_bg_focus = 'linear:0,0:0,21:0,#484d5e:1,#23262e'
    theme.titlebar_bg_normal = 'linear:0,0:0,21:0,#2f303d:1,#1C1E24'
    theme.titlebar_fg_focus = gtk_variable().fg_color
    theme.titlebar_fg_normal = gtk_variable().fg_color

    -- Close Button
    theme.titlebar_close_button_normal = tip .. 'close-inactive.png'
    theme.titlebar_close_button_focus = tip .. 'close-active.png'

    -- Minimize Button
    theme.titlebar_minimize_button_normal = tip .. 'hide-inactive.png'
    theme.titlebar_minimize_button_focus = tip .. 'hide-active.png'

    -- -- Ontop Button
    -- theme.titlebar_ontop_button_normal_inactive = tip .. 'stick-inactive.png'
    -- theme.titlebar_ontop_button_focus_inactive = tip .. 'stick-prelight.png'
    -- theme.titlebar_ontop_button_normal_active = tip .. 'stick-preseed.png'
    -- theme.titlebar_ontop_button_focus_active = tip .. 'stick-active.png'

    -- -- Sticky Button
    -- theme.titlebar_sticky_button_normal_inactive = tip .. 'sticky_normal_inactive.svg'
    -- theme.titlebar_sticky_button_focus_inactive = tip .. 'sticky_focus_inactive.svg'
    -- theme.titlebar_sticky_button_normal_active = tip .. 'sticky_normal_active.svg'
    -- theme.titlebar_sticky_button_focus_active = tip .. 'sticky_focus_active.svg'

    -- -- Floating Button
    -- theme.titlebar_floating_button_normal_inactive = tip .. 'floating_normal_inactive.svg'
    -- theme.titlebar_floating_button_focus_inactive = tip .. 'floating_focus_inactive.svg'
    -- theme.titlebar_floating_button_normal_active = tip .. 'floating_normal_active.svg'
    -- theme.titlebar_floating_button_focus_active = tip .. 'floating_focus_active.svg'

    -- Maximized Button
    theme.titlebar_maximized_button_normal_inactive = tip .. 'maximize-inactive.png'
    theme.titlebar_maximized_button_focus_inactive = tip .. 'maximize-prelight.png'
    theme.titlebar_maximized_button_normal_active = tip .. 'maximize-active.png'
    theme.titlebar_maximized_button_focus_active = tip .. 'maximize-active.png'

    -- Hovered Close Button
    theme.titlebar_close_button_normal_hover = tip .. 'close-prelight.png'
    theme.titlebar_close_button_focus_hover = tip .. 'close-preseed.png'

    -- Hovered Minimize Buttin
    theme.titlebar_minimize_button_normal_hover = tip .. 'hide-prelight.png'
    theme.titlebar_minimize_button_focus_hover = tip .. 'hide-preseed.png'

    -- -- Hovered Ontop Button
    -- theme.titlebar_ontop_button_normal_inactive_hover = tip .. 'ontop_normal_inactive_hover.svg'
    -- theme.titlebar_ontop_button_focus_inactive_hover = tip .. 'ontop_focus_inactive_hover.svg'
    -- theme.titlebar_ontop_button_normal_active_hover = tip .. 'ontop_normal_active_hover.svg'
    -- theme.titlebar_ontop_button_focus_active_hover = tip .. 'ontop_focus_active_hover.svg'

    -- -- Hovered Sticky Button
    -- theme.titlebar_sticky_button_normal_inactive_hover = tip .. 'sticky_normal_inactive_hover.svg'
    -- theme.titlebar_sticky_button_focus_inactive_hover = tip .. 'sticky_focus_inactive_hover.svg'
    -- theme.titlebar_sticky_button_normal_active_hover = tip .. 'sticky_normal_active_hover.svg'
    -- theme.titlebar_sticky_button_focus_active_hover = tip .. 'sticky_focus_active_hover.svg'

    -- -- Hovered Floating Button
    -- theme.titlebar_floating_button_normal_inactive_hover = tip .. 'floating_normal_inactive_hover.svg'
    -- theme.titlebar_floating_button_focus_inactive_hover = tip .. 'floating_focus_inactive_hover.svg'
    -- theme.titlebar_floating_button_normal_active_hover = tip .. 'floating_normal_active_hover.svg'
    -- theme.titlebar_floating_button_focus_active_hover = tip .. 'floating_focus_active_hover.svg'

    -- -- Hovered Maximized Button
    -- theme.titlebar_maximized_button_normal_inactive_hover = tip .. 'maximized_normal_inactive_hover.svg'
    -- theme.titlebar_maximized_button_focus_inactive_hover = tip .. 'maximized_focus_inactive_hover.svg'
    -- theme.titlebar_maximized_button_normal_active_hover = tip .. 'maximized_normal_active_hover.svg'
    -- theme.titlebar_maximized_button_focus_active_hover = tip .. 'maximized_focus_active_hover.svg'

    -- UI Groups
    theme.groups_title_bg = '#ffffff' .. '15'
    theme.groups_bg = '#ffffff' .. '10'
    theme.groups_radius = dpi(16)

    -- UI events
    theme.leave_event = transparent
    theme.enter_event = '#ffffff' .. '10'
    theme.press_event = '#ffffff' .. '15'
    theme.release_event = '#ffffff' .. '10'

    -- Client Decorations

    -- Borders
    theme.border_focus = gtk_variable().bg_color
    theme.border_normal = gtk_variable().base_color
    theme.border_marked = '#CC9393'
    theme.border_width = dpi(0)
    theme.border_radius = dpi(12)

    -- Decorations
    theme.useless_gap = dpi(4)
    theme.client_shape_rounded = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, dpi(12))
    end

    -- Menu
    theme.menu_font = 'SF Intermosaic B  11'
    theme.menu_submenu = '' -- ➤

    theme.menu_height = dpi(34)
    theme.menu_width = dpi(200)
    theme.menu_border_width = dpi(20)
    theme.menu_bg_focus = theme.accent .. 'CC'

    theme.menu_bg_normal = 'linear:0,0:0,21:0,#2f303d:1,#1C1E24'
    theme.menu_fg_normal = '#b2bfd9'
    theme.menu_fg_focus = '#f4f4f7'
    theme.menu_border_color = 'linear:0,0:0,21:0,#2f303d:1,#1C1E24'

    -- Tooltips

    theme.tooltip_bg = theme.background
    theme.tooltip_border_color = theme.transparent
    theme.tooltip_border_width = 0
    theme.tooltip_gaps = dpi(5)
    theme.tooltip_shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, dpi(6))
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Separators
    --
    theme.separator_color = '#f2f2f244'
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
    -- Taglist
    --
    theme.taglist_font = 'awesomewm-font 16'
    theme.taglist_bg_empty = 'linear:0,0:0,21:0,#2f303d:1,#1C1E24'
    theme.taglist_bg_occupied = '#ffffff' .. '1A'
    theme.taglist_bg_urgent = '#E91E63' .. '99'
    theme.taglist_bg_focus = 'linear:0,0:0,21:0,#484d5e:1,#23262e'
    theme.taglist_spacing = dpi(0)

    -- Tasklist
    theme.tasklist_font = 'SF Intermosaic B  10'
    theme.tasklist_bg_normal = 'linear:0,0:0,21:0,#2f303d:1,#1C1E24'
    theme.tasklist_bg_focus = 'linear:0,0:0,21:0,#484d5e:1,#23262e'
    theme.tasklist_bg_urgent = '#E91E63' .. '99'
    theme.tasklist_fg_focus = '#DDDDDD'
    theme.tasklist_fg_urgent = '#ffffff'
    theme.tasklist_fg_normal = '#AAAAAA'

    -- Notification
    theme.notification_position = 'top_left'
    theme.notification_bg = theme.transparent
    theme.notification_margin = dpi(5)
    theme.notification_border_width = dpi(0)
    theme.notification_border_color = theme.transparent
    theme.notification_spacing = dpi(5)
    theme.notification_icon_resize_strategy = 'center'
    theme.notification_icon_size = dpi(32)

    -- Client Snap Theme
    theme.snap_bg = theme.background
    theme.snap_shape = gears.shape.rectangle
    theme.snap_border_width = dpi(15)

    -- Hotkey popup
    theme.hotkeys_font = 'SF Intermosaic B'
    theme.hotkeys_description_font = 'SF Intermosaic B'
    theme.hotkeys_bg = theme.background
    theme.hotkeys_group_margin = dpi(20)
end

return {
    theme = theme,
    awesome_overrides = awesome_overrides
}
