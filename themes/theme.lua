local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local colors = require("themes").colors
local settings = require("settings")
local gears = require("gears")
local beautiful = require("beautiful")

local filesystem = gears.filesystem
local dpi = beautiful.xresources.apply_dpi
local gtk_variable = beautiful.gtk.get_theme_variables

local theme_dir = filesystem.get_configuration_dir() .. "/themes"
local titlebar_theme = "dhumavati"
local titlebar_icon_path = theme_dir .. "/icons/titlebar/" .. titlebar_theme .. "/"
local tip = titlebar_icon_path

local theme = {}

theme.useless_gap = dpi(settings.window_gaps)
theme.border_width = dpi(settings.window_border_size)

theme.hotkeys_bg = colors.colorB
theme.hotkeys_fg = colors.white
theme.hotkeys_modifiers_fg = colors.color2
theme.hotkeys_border_color = colors.color6
theme.hotkeys_group_margin = 10

client.shape_clip = 4

theme.fg_normal = "#e9efffff"
theme.fg_focus = "#f4f4f7ff"
theme.fg_urgent = "#E91E63cc"

theme.font = "Nineteen Ninety Seven Regular   11"
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Accent color
--
theme.accent = "linear:0,0:0,51:0,#555e70:1,#8b9cbe"
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Background
theme.bg_normal = "linear:0,0:0,-21:0,#323643:1,#1b1d24"
theme.bg_focus = "linear:0,0:0,21:0,#323643:1,#22252e"
theme.bg_urgent = "linear:0,0:0,21:0,#282B36:1,#1B1D24"
theme.bg_menu = "linear:0,0:0,21:0,#323643:1,#1b1d24"
theme.bg_button = "linear:0,0:0,51:0,#7F8AA1:1,#3F4859"

-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Transparent
--
theme.transparent = "#1b1d2488"
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- System tray
--
theme.bg_systray = theme.background
theme.systray_icon_spacing = dpi(16)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- UI Groups
--
theme.groups_title_bg = "linear:0,0:0,21:0,#4C5166:1,#1b1d24"
theme.groups_bg = "linear:0,0:0,21:0,#282B36:1,#1b1d24"
theme.groups_radius = dpi(16)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- UI events
-- theme.leave_event = "#1b1d24aa"
-- theme.enter_event = "#f4f4f722"
-- theme.press_event = "#f4f4f722"
-- theme.release_event = "#1b1d24aa"

theme.widget_markup = "<span color=%q><b>%s</b></span>"

-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Section: Icons
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Close Button
--
theme.titlebar_close_button_normal = tip .. "close-inactive.png"
theme.titlebar_close_button_focus = tip .. "close-active.png"
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Minimize Button
--+
theme.titlebar_minimize_button_normal = tip .. "hide-inactive.png"
theme.titlebar_minimize_button_focus = tip .. "hide-active.png"
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Ontop Button
--
-- theme.titlebar_ontop_button_normal_inactive = tip .. 'stick-inactive.png'
-- theme.titlebar_ontop_button_focus_inactive = tip .. 'stick-prelight.png'
-- theme.titlebar_ontop_button_normal_active = tip .. 'stick-preseed.png'
-- theme.titlebar_ontop_button_focus_active = tip .. 'stick-active.png'
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Sticky Button
--
-- theme.titlebar_sticky_button_normal_inactive = tip .. 'sticky_normal_inactive.svg'
-- theme.titlebar_sticky_button_focus_inactive = tip .. 'sticky_focus_inactive.svg'
-- theme.titlebar_sticky_button_normal_active = tip .. 'sticky_normal_active.svg'
-- theme.titlebar_sticky_button_focus_active = tip .. 'sticky_focus_active.svg'
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Floating Button
--
-- theme.titlebar_floating_button_normal_inactive = tip .. 'floating_normal_inactive.svg'
-- theme.titlebar_floating_button_focus_inactive = tip .. 'floating_focus_inactive.svg'
-- theme.titlebar_floating_button_normal_active = tip .. 'floating_normal_active.svg'
-- theme.titlebar_floating_button_focus_active = tip .. 'floating_focus_active.svg'
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Maximized Button
--
theme.titlebar_maximized_button_normal_inactive = tip .. "maximize-inactive.png"
theme.titlebar_maximized_button_focus_inactive = tip .. "maximize-prelight.png"
theme.titlebar_maximized_button_normal_active = tip .. "maximize-active.png"
theme.titlebar_maximized_button_focus_active = tip .. "maximize-active.png"
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Hovered Close Button
--
theme.titlebar_close_button_normal_hover = tip .. "close-prelight.png"
theme.titlebar_close_button_focus_hover = tip .. "close-preseed.png"
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Hovered Minimize Buttin
--
theme.titlebar_minimize_button_normal_hover = tip .. "hide-prelight.png"
theme.titlebar_minimize_button_focus_hover = tip .. "hide-preseed.png"
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Hovered Ontop Button
--
-- theme.titlebar_ontop_button_normal_inactive_hover = tip .. 'ontop_normal_inactive_hover.svg'
-- theme.titlebar_ontop_button_focus_inactive_hover = tip .. 'ontop_focus_inactive_hover.svg'
-- theme.titlebar_ontop_button_normal_active_hover = tip .. 'ontop_normal_active_hover.svg'
-- theme.titlebar_ontop_button_focus_active_hover = tip .. 'ontop_focus_active_hover.svg'
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Hovered Sticky Button
--
-- theme.titlebar_sticky_button_normal_inactive_hover = tip .. 'sticky_normal_inactive_hover.svg'
-- theme.titlebar_sticky_button_focus_inactive_hover = tip .. 'sticky_focus_inactive_hover.svg'
-- theme.titlebar_sticky_button_normal_active_hover = tip .. 'sticky_normal_active_hover.svg'
-- theme.titlebar_sticky_button_focus_active_hover = tip .. 'sticky_focus_active_hover.svg'
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Hovered Floating Button
--
-- theme.titlebar_floating_button_normal_inactive_hover = tip .. 'floating_normal_inactive_hover.svg'
-- theme.titlebar_floating_button_focus_inactive_hover = tip .. 'floating_focus_inactive_hover.svg'
-- theme.titlebar_floating_button_normal_active_hover = tip .. 'floating_normal_active_hover.svg'
-- theme.titlebar_floating_button_focus_active_hover = tip .. 'floating_focus_active_hover.svg'
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Hovered Maximized Button
--
-- theme.titlebar_maximized_button_normal_inactive_hover = tip .. 'maximized_normal_inactive_hover.svg'
-- theme.titlebar_maximized_button_focus_inactive_hover = tip .. 'maximized_focus_inactive_hover.svg'
-- theme.titlebar_maximized_button_normal_active_hover = tip .. 'maximized_normal_active_hover.svg'
-- theme.titlebar_maximized_button_focus_active_hover = tip .. 'maximized_focus_active_hover.svg'
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Layout Icons
--
theme.layout_centermaster = theme_dir .. "/icons/layouts/centermaster.png"
theme.layout_cornerne = theme_dir .. "/icons/layouts/cornerne.png"
theme.layout_cornernw = theme_dir .. "/icons/layouts/cornernw.png"
theme.layout_cornerse = theme_dir .. "/icons/layouts/cornerse.png"
theme.layout_cornersw = theme_dir .. "/icons/layouts/cornersw.png"

theme.layout_stackLeft = theme_dir .. "/icons/layouts/stack_left.png"
theme.layout_stack = theme_dir .. "/icons/layouts/stack.png"

theme.layout_empathy = theme_dir .. "/icons/layouts/empathy.png"
theme.layout_max = theme_dir .. "/icons/layouts/max.png"
theme.layout_tile = theme_dir .. "/icons/layouts/tile.png"
theme.layout_tilebottom = theme_dir .. "/icons/layouts/tilebottom.png"
theme.layout_tileleft = theme_dir .. "/icons/layouts/tileleft.png"
theme.layout_tiletop = theme_dir .. "/icons/layouts/tiletop.png"
theme.layout_dwindle = theme_dir .. "/icons/layouts/dwindle.png"
theme.layout_floating = theme_dir .. "/icons/layouts/floating.png"
theme.layout_magnifier = theme_dir .. "/icons/layouts/magnifier.png"
theme.layout_fairv = theme_dir .. "/icons/layouts/fairv.png"
theme.layout_fairh = theme_dir .. "/icons/layouts/fairh.png"
theme.layout_thrizen = theme_dir .. "/icons/layouts/thrizen.png"
theme.layout_fullscreen = theme_dir .. "/icons/layouts/fullscreen.png"
theme.layout_spiral = theme_dir .. "/icons/layouts/spiral.png"

-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Section: Client Decorations
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Borders
--
theme.border_focus = "linear:0,0:0,51:0,#7B8394:1,#5b6270"
theme.border_normal = "linear:0,0:0,51:0,#555e70:1,#8b9cbe"
theme.border_marked = "linear:0,0:0,51:0,#555e70:1,#3c3f4c"
theme.border_width = dpi(0)
theme.border_radius = dpi(12)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Decorations
theme.client_shape_rounded_xl = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, dpi(12))
end
theme.client_shape_rounded_lg = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, dpi(8))
end
theme.client_shape_rounded = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, dpi(4))
end
theme.client_shape_rounded_medium = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, dpi(2))
end
theme.client_shape_rounded_small = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, dpi(1))
end

-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Menu
theme.menu_font = "Nineteen Ninety Seven Regular   11"
theme.menu_submenu = "" -- ➤

theme.menu_height = dpi(34)
theme.menu_width = dpi(200)
theme.menu_border_width = dpi(2)
theme.menu_bg_focus = theme.accent .. "CC"
theme.menu_accent = "#282B36"
theme.menu_bg_normal = "linear:0,0:0,21:0,#282B36:1,#1B1D24"

theme.menu_fg_normal = "#b2bfd9"
theme.menu_fg_focus = "#f4f4f7"
theme.menu_border_color = "linear:0,0:0,21:0,#282B36:1,#1B1D24"
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Tooltips

theme.tooltip_bg = theme.background
theme.tooltip_border_color = "linear:0,0:0,21:0,#4C5166:1,#282B36"
theme.tooltip_border_width = 0
theme.tooltip_gaps = dpi(5)
theme.tooltip_shape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, dpi(6))
end
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Separators
--
theme.separator_color = "#4C5166"
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Titlebar
--
theme.titlebar_size = dpi(22)
theme.titlebar_bg_focus = "linear:0,0:0,21:0,#4C5166:1,#282B36"
theme.titlebar_bg_normal = "linear:0,0:0,21:0,#282B36:1,#1B1D24"
theme.titlebar_fg_focus = "#b2bfd9"
theme.titlebar_fg_normal = "#f4f4f7"

-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Taglist
--
theme.taglist_font = "awesomewm-font 19"

theme.taglist_fg_focus = "#b2bfd9"
theme.taglist_border_focus = "#f4f4f7"
theme.taglist_fg_empty = "#f4f4f7"
theme.taglist_fg = "#f4f4f7"
theme.taglist_fg_occupied = "#282b36"
theme.taglist_bg_urgent = "#E91E63cc"
theme.taglist_spacing = dpi(6)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Tasklist
--
theme.tasklist_font = "Nineteen Ninety Seven Regular  10"
theme.tasklist_font_focus = "Nineteen Ninety Seven Bold 10"
theme.tasklist_bg_normal = "linear:0,0:0,21:0,#282B36:1,#1B1D24"
theme.tasklist_bg_focus = "linear:0,0:0,21:0,#4C5166:1,#282B36"
theme.tasklist_bg_urgent = "#E91E63" .. "99"
theme.tasklist_fg_focus = "#f4f4f7"
theme.tasklist_fg_urgent = "#f4f4f7"
theme.tasklist_fg_normal = "#b2bfd9"
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Notification
--
theme.notification_position = "bottom_right"
theme.notification_bg = "linear:0,0:0,21:0,#4C5166:1,#282B36"
theme.notification_margin = dpi(5)
theme.notification_border_width = dpi(0)
theme.notification_border_color = "linear:0,0:0,21:0,#4C5166:1,#282B36"
theme.notification_spacing = dpi(5)
theme.notification_icon_resize_strategy = "center"
theme.notification_icon_size = dpi(32)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Client Snap Theme
--
theme.snap_border_color = theme.bg_normal
theme.snap_shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 12)
end
theme.snap_border_width = dpi(6)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Exit Screen
theme.exit_screen_bg = "#1B1D24cc"
theme.exit_screen_font = "Nineteen Ninety Seven Regular  22"

return theme
