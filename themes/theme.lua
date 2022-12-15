--  _______ __
-- |_     _|  |--.-----.--------.-----.
--   |   | |     |  -__|        |  -__|
--   |___| |__|__|_____|__|__|__|_____|
-- ------------------------------------------------- --
--                       Setup                       --
-- ------------------------------------------------- --
-- NOTE:throws error without these despite global-settings file
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi
local colors = require('themes.schemes.vice')
local settings = require('settings')
local gears = require('gears')
local beautiful = require('beautiful')
local filesystem = gears.filesystem
local dpi = beautiful.xresources.apply_dpi
-- ------------------------------------------------- --
-- --------------------- Paths --------------------- --
local theme_dir = filesystem.get_configuration_dir() .. '/themes'
local titlebar_theme = 'dhumavati'
local titlebar_icon_path = theme_dir .. '/icons/titlebar/' .. titlebar_theme .. '/'
local tip = titlebar_icon_path
-- ------------------------------------------------- --
-- declear object
local theme = {}

-- ------------------------------------------------- --
--                   General Decor                   --
-- ------------------------------------------------- --
theme.useless_gap = dpi(settings.window_gaps)
theme.border_width = dpi(settings.window_border_size)
-- ------------------------------------------------- --
-- ----------------- Client Shapes ----------------- --
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
-- --------------------- Markup -------------------- --
theme.widget_markup = '<span color=%q><b>%s</b></span>'
-- ------------------------------------------------- --
-- --------------------- Fonts --------------------- --
theme.font = 'Operator SSm  '
theme.display_font = 'Nineteen Ninety Seven '
theme.icon_font = 'Font Awesome 6 Pro '
theme.icon_theme = 'chhinamasta'

-- ------------------------------------------------- --
-- --------------------- Accent -------------------- --
-- NOTE used for the button hover bg
theme.accent = 'linear:0,0:0,21:0,' .. colors.alpha(colors.colorK, 'cc') .. ':1,' .. colors.alpha(colors.colorP, 'cc')
-- ------------------------------------------------- --
-- ------------------- Foreground ------------------ --
theme.fg_normal = colors.white
theme.fg_color = colors.white
theme.fg_focus = colors.lesswhite
theme.fg_urgent = colors.alpha(colors.color15, 'cc')
-- ------------------------------------------------- --
-- ------------------ Backgrounds ------------------ --
theme.bg_normal =
    'radial:0,21:0,56:0,' .. colors.alpha(colors.colorS, 'dd') .. ':1,' .. colors.alpha(colors.colorD, 'ee')

theme.bg_focus =
    'radial:0,56:0,21:0,' .. colors.alpha(colors.colorK, 'cc') .. ':1,' .. colors.alpha(colors.colorB, 'ee')

theme.bg_urgent =
    'linear:0,0:0,21:0,' .. colors.alpha(colors.colorD, 'cc') .. ':1,' .. colors.alpha(colors.colorM, 'cc')

theme.bg_menu = 'linear:0,0:0,21:0,' .. colors.alpha(colors.colorY, 'cc') .. ':1,' .. colors.alpha(colors.colorK, 'cc')

theme.bg_button =
    'linear:0,0:0,32:0,' .. colors.alpha(colors.colorS, 'ee') .. ':1,' .. colors.alpha(colors.colorK, 'ee')

theme.bg_panel = 'linear:0,0:0,21:0,' .. colors.alpha(colors.colorN, 'ee') .. ':1,' .. colors.alpha(colors.colorF, 'ee')
-- ------------------------------------------------- --
-- -------------------- Hot Keys ------------------- --

theme.hotkeys_description_font = theme.font .. ' Bold 11'
theme.hotkeys_font = theme.font .. ' Bold 11'

-- ------------------------------------------------- --
-- ------------------ Transparent ------------------ --
theme.transparent = colors.alpha(colors.black, '00')
-- ------------------------------------------------- --
-- -------------------- Borde`rs -------------------- --

theme.border_focus = colors.colorB
theme.border_normal = colors.colorM
theme.border_marked = colors.colorX
theme.border_width = dpi(0)
theme.border_radius = dpi(12)

-- ------------------------------------------------- --
-- ---------- Section: Client Decorations ---------- --
-- ------------------------------------------------- --
-- hotkeys
theme.hotkeys_bg = colors.alpha(colors.colorB, 'cc')
theme.hotkeys_fg = colors.white
theme.hotkeys_modifiers_fg = colors.color2
theme.hotkeys_border_color = colors.color6
theme.hotkeys_group_margin = dpi(10)

-- ------------------------------------------------- --
-- System tray
--
theme.bg_systray = theme.background
theme.systray_icon_spacing = dpi(16)
-- ------------------------------------------------- --
-- UI Groups
--
theme.groups_title_bg =
    'linear:0,0:0,21:0,' .. colors.alpha(colors.colorV, 'cc') .. ':1,' .. colors.alpha(colors.colorM, 'cc')
theme.groups_bg = 'linear:0,0:0,21:0,' .. colors.alpha(colors.colorM, 'cc') .. ':1,' .. colors.alpha(colors.black, 'cc')
theme.groups_radius = dpi(16)

theme.sliders_fg =
    'linear:0,0:0,21:0,' .. colors.alpha(colors.color1, 'cc') .. ':1,' .. colors.alpha(colors.white, 'cc')
-- ------------------------------------------------- --
-- ------------------- UI events ------------------- --
theme.leave_event = colors.alpha(colors.black, '22')
theme.enter_event = colors.alpha(colors.white, '22')
theme.press_event = colors.alpha(colors.white, '22')
theme.release_event = colors.alpha(colors.black, '22')

-- ------------------------------------------------- --
-- ---------------------- Menu --------------------- --
theme.menu_font = theme.font .. '9'
theme.menu_submenu = '➤' -- ➤
theme.menu_height = dpi(34)
theme.menu_width = dpi(350)
theme.menu_border_width = dpi(2)
theme.menu_bg_focus = colors.alpha(colors.white, '99')
theme.menu_accent = colors.colorM
theme.menu_bg_normal =
    'linear:0,0:0,21:0,' .. colors.alpha(colors.colorM, '88') .. ':1,' .. colors.alpha(colors.black, 'cc')
theme.menu_fg_normal = colors.colorY
theme.menu_fg_focus = colors.white
theme.menu_border_color =
    'linear:0,0:0,21:0,' .. colors.alpha(colors.colorM, '88') .. ':1,' .. colors.alpha(colors.black, '88')
-- ------------------------------------------------- --
-- -------------------- Tooltips ------------------- --

theme.tooltip_bg = theme.background
theme.tooltip_border_color = colors.alpha(colors.black, 'cc')
theme.tooltip_border_width = 0
theme.tooltip_gaps = dpi(5)
theme.tooltip_shape = theme.client_shape_rounded
-- ------------------------------------------------- --
-- ------------------- Separators ------------------ --
--
theme.separator_color = colors.colorP
-- ------------------------------------------------- --
-- -------------------- Titlebar ------------------- --
theme.titlebar_size = dpi(18)
theme.titlebar_bg_focus =
    'linear:0,0:0,21:0,' .. colors.alpha(colors.colorH, 'dd') .. ':1,' .. colors.alpha(colors.colorB, 'dd')
theme.titlebar_bg_normal =
    'linear:0,0:0,21:0,' .. colors.alpha(colors.colorE, 'dd') .. ':1,' .. colors.alpha(colors.colorA, 'dd')
theme.titlebar_fg_focus = theme.fg_normal
theme.titlebar_fg_normal = colors.colorY
-- ------------------------------------------------- --
-- ------------------ Client Snap ------------------ --
-- theme.snap_border_color = colors.alpha(colors.colorL, '99')
theme.snap_shape = theme.client_shape_rounded_xl
theme.snap_border_width = dpi(32)
-- ------------------------------------------------- --
-- ------------------ Exit Screen ------------------ --
theme.exit_screen_bg = colors.alpha(colors.black, 'cc')
theme.exit_screen_font = theme.font .. ' Bold 22'
-- ------------------------------------------------- --
-- -------------------- Taglist -------------------- --
theme.taglist_font = 'awesomewm-font 24'
theme.taglist_fg_focus = colors.white
theme.taglist_bg_focus = colors.alpha(colors.lesswhite, 'cc')
theme.taglist_border_focus = colors.white
theme.taglist_fg_empty = colors.white

theme.taglist_fg = colors.white
theme.taglist_fg = colors.black
theme.taglist_fg_occupied = colors.colorY
theme.taglist_bg_occupied = colors.alpha(colors.colorA, 'cc')
theme.taglist_bg_urgent = colors.alpha(colors.color15, 'cc')
theme.taglist_spacing = dpi(6)
theme.taglist_shape = theme.client_shape_rounded_lg

-- ------------------------------------------------- --
-- -------------------- Tasklist ------------------- --
theme.tasklist_font = theme.font .. ' 12'
theme.tasklist_bg_normal = theme.bg_button
theme.tasklist_bg_focus = theme.bg_focus
theme.tasklist_bg_urgent = colors.alpha(colors.color15, 'cc')
theme.tasklist_fg_focus = colors.white
theme.tasklist_fg_urgent = colors.white
theme.tasklist_fg_normal = colors.colorY
theme.tasklist_plain_task_name = true

-- ------------------------------------------------- --
-- ------------------ Notification ----------------- --

theme.notification_margin = dpi(5)
theme.notification_border_width = dpi(0)
theme.notification_border_color = colors.alpha(colors.black, 'cc')
theme.notification_spacing = dpi(5)
theme.notification_icon_resize_strategy = 'center'
theme.notification_icon_size = dpi(32)
-- ------------------------------------------------- --
-- ------------------ Layout List ------------------ --
theme.layoutlist_bg_selected = colors.colorB
theme.layoutlist_shape_border_width_selected = dpi(4)
theme.layoutlist_border_color_selected = colors.colorC

-- ------------------------------------------------- --
-- ----------------- Section: Icons ---------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------ Close Button ----------------- --
theme.titlebar_close_button_normal = tip .. 'close-inactive.png'
theme.titlebar_close_button_focus = tip .. 'close-active.png'
theme.titlebar_close_button_focus_hover = tip .. 'close-alt.png'
theme.titlebar_close_button_normal_hover = tip .. 'close-alt.png'
theme.titlebar_close_button_normal_press = tip .. 'close-alt.png'
theme.titlebar_close_button_focus_press = tip .. 'close-alt.png'

-- ------------------------------------------------- --
-- ---------------- Minimize Button ---------------- --
theme.titlebar_minimize_button_normal = tip .. 'hide-inactive.png'
theme.titlebar_minimize_button_focus = tip .. 'hide-active.png'

-- ------------------------------------------------- --
-- ------------------ Ontop Button ----------------- --
theme.titlebar_ontop_button_normal_inactive = tip .. 'stick-inactive.png'
theme.titlebar_ontop_button_focus_inactive = tip .. 'stick-prelight.png'
theme.titlebar_ontop_button_normal_active = tip .. 'stick-preseed.png'
theme.titlebar_ontop_button_focus_active = tip .. 'stick-active.png'
-- ------------------------------------------------- --
-- ----------------- Sticky Button ----------------- --
-- theme.titlebar_sticky_button_normal_inactive = tip .. 'sticky_normal_inactive.svg'
-- theme.titlebar_sticky_button_focus_inactive = tip .. 'sticky_focus_inactive.svg'
-- theme.titlebar_sticky_button_normal_active = tip .. 'sticky_normal_active.svg'
-- theme.titlebar_sticky_button_focus_active = tip .. 'sticky_focus_active.svg'
-- ------------------------------------------------- --
-- ---------------- Floating Button ---------------- --

theme.titlebar_floating_button_normal_inactive = tip .. 'shade-inactive.svg'
theme.titlebar_floating_button_focus_inactive = tip .. 'shade-prelight.svg'
theme.titlebar_floating_button_normal_active = tip .. 'shade-preseed.svg'
theme.titlebar_floating_button_focus_active = tip .. 'shade-active.svg'
-- ------------------------------------------------- --
-- ---------------- Maximize Button ---------------- --
--
theme.titlebar_maximized_button_normal_inactive = tip .. 'maximize-inactive.png'
theme.titlebar_maximized_button_focus_inactive = tip .. 'maximize-prelight.png'
theme.titlebar_maximized_button_normal_active = tip .. 'maximize-active.png'
theme.titlebar_maximized_button_focus_active = tip .. 'maximize-active.png'
-- ------------------------------------------------- --
-- -------------- Hovered Close Button ------------- --
--
theme.titlebar_close_button_normal_hover = tip .. 'close-prelight.png'
theme.titlebar_close_button_focus_hover = tip .. 'close-preseed.png'
-- ------------------------------------------------- --
-- ------------ Hovered Minimize Button ------------ --
--
theme.titlebar_minimize_button_normal_hover = tip .. 'hide-prelight.png'
theme.titlebar_minimize_button_focus_hover = tip .. 'hide-preseed.png'
-- ------------------------------------------------- --
-- -------------- Hovered Ontop Button ------------- --
--
-- theme.titlebar_ontop_button_normal_inactive_hover = tip .. 'ontop_normal_inactive_hover.svg'
-- theme.titlebar_ontop_button_focus_inactive_hover = tip .. 'ontop_focus_inactive_hover.svg'
-- theme.titlebar_ontop_button_normal_active_hover = tip .. 'ontop_normal_active_hover.svg'
-- theme.titlebar_ontop_button_focus_active_hover = tip .. 'ontop_focus_active_hover.svg'
-- ------------------------------------------------- --
-- ------------- Hovered Sticky Button ------------- --
--
-- theme.titlebar_sticky_button_normal_inactive_hover = tip .. 'sticky_normal_inactive_hover.svg'
-- theme.titlebar_sticky_button_focus_inactive_hover = tip .. 'sticky_focus_inactive_hover.svg'
-- theme.titlebar_sticky_button_normal_active_hover = tip .. 'sticky_normal_active_hover.svg'
-- theme.titlebar_sticky_button_focus_active_hover = tip .. 'sticky_focus_active_hover.svg'
-- ------------------------------------------------- --
-- ------------ Hovered Floating Button ------------ --
--
-- theme.titlebar_floating_button_normal_inactive_hover = tip .. 'floating_normal_inactive_hover.svg'
-- theme.titlebar_floating_button_focus_inactive_hover = tip .. 'floating_focus_inactive_hover.svg'
-- theme.titlebar_floating_button_normal_active_hover = tip .. 'floating_normal_active_hover.svg'
-- theme.titlebar_floating_button_focus_active_hover = tip .. 'floating_focus_active_hover.svg'
-- ------------------------------------------------- --
-- ------------ Hovered Maximized Button ----------- --
--
-- theme.titlebar_maximized_button_normal_inactive_hover = tip .. 'maximized_normal_inactive_hover.svg'
-- theme.titlebar_maximized_button_focus_inactive_hover = tip .. 'maximized_focus_inactive_hover.svg'
-- theme.titlebar_maximized_button_normal_active_hover = tip .. 'maximized_normal_active_hover.svg'
-- theme.titlebar_maximized_button_focus_active_hover = tip .. 'maximized_focus_active_hover.svg'
-- ------------------------------------------------- --
-- ------------------ Layout Icons ----------------- --
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
theme.layout_horizon = theme_dir .. '/icons/layouts/horizon.png'
theme.layout_fullscreen = theme_dir .. '/icons/layouts/fullscreen.png'
theme.layout_spiral = theme_dir .. '/icons/layouts/spiral.png'
theme.layout_equalarea = theme_dir .. '/icons/layouts/equalarea.png'
theme.layout_deck = theme_dir .. '/icons/layouts/deck.png'
-- ------------------------------------------------- --

theme.application_switcher_widget_bg = theme.bg_focus
theme.application_switcher_widget_border_width = dpi(2)
theme.application_switcher_widget_border_radius = dpi(8)
theme.application_switcher_widget_border_color = colors.alpha(colors.colorM, '33')
theme.application_switcher_clients_spacing = dpi(50)
theme.application_switcher_client_icon_horizontal_spacing = dpi(5)
theme.application_switcher_client_width = dpi(650)
theme.application_switcher_client_height = dpi(500)
theme.application_switcher_client_margins = dpi(35)
theme.application_switcher_thumbnail_margins = dpi(5)
theme.thumbnail_scale = false
theme.application_switcher_name_margins = dpi(5)
theme.application_switcher_name_valign = 'center'
theme.application_switcher_name_forced_width = dpi(250)
theme.application_switcher_name_font = theme.font .. '14'
theme.application_switcher_name_normal_color = colors.color1
theme.application_switcher_name_focus_color = theme.fg_normal
theme.application_switcher_icon_valign = 'center'
theme.application_switcher_icon_width = dpi(80)

return theme
