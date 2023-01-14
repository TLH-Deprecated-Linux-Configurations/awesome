--  _____                     __                __
-- |     |_.--.--.---.-.----.|  |--.-----.----.|  |--.----.----.
-- |       |  |  |  _  |  __||     |  -__|  __||    <|   _|  __|
-- |_______|_____|___._|____||__|__|_____|____||__|__|__| |____|
-- ------------------------------------------------- --
-- NOTE: this configures the lua language linting
-- application luacheck. Critically for our purposes
-- it is providing relief from the "undeclared global"
-- warnings that would litter the configuration as
-- a settings file provides global scoping to the
-- various libraries and such in one file called
-- early instead of including redundant calls at
-- each file's head.
-- ------------------------------------------------- --
-- Only allow symbols available in all Lua versions
std = 'min'

-- Get rid of "unused argument self"-warnings
self = false

-- The unit tests can use busted
files['spec'].std = '+busted'

-- The default config may set global variables
files['configuration.settings.global_var'].allow_defined_top = true

-- This file itself
files['.luacheckrc'].ignore = {'111', '112', '131'}

-- ignore file max line length
-- ignore string containing trailing whitespace
-- ignore mutating of global variables
-- ignore setting global variables
files['**'].ignore = {'631', '613', '112', '122'}

exclude_files = {
    '.luacheckrc',
    'luajit/*'
}

-- Global objects defined by the C code
read_globals = {
    'altkey',
    'apps',
    'arrange',
    'awesome',
    'awestore',
    'awful_menu',
    'awful',
    'backdrop',
    'base',
    'beautiful',
    'bottom_panel',
    'button',
    'cache',
    'cairo',
    'card',
    'cc_toggle',
    'center',
    'clear_desktop_selection',
    'clickable_container',
    'client_buttons',
    'client_keys',
    'client',
    'colorize_text',
    'colors',
    'common',
    'config_dir',
    'config',
    'connections',
    'control_c',
    'control_center',
    'dashboard',
    'date',
    'dbus',
    'detect',
    'dont_disturb',
    'dpi',
    'drawable',
    'drawin',
    'editor_cmd',
    'file_manager',
    'file',
    'filehandle',
    'files',
    'filesystem',
    'fixed',
    'format_item',
    'freedesktop',
    'gears',
    'gfs',
    'gobject',
    'gshape',
    'gstring',
    'gtable',
    'gtimer',
    'gtk_variable',
    'hardware',
    'HOME',
    'hotkeys_popup',
    'icon_theme',
    'icons',
    'info_center',
    'inspect',
    'key',
    'keygrabber',
    'logger',
    'math.atan2',
    'math.pow',
    'math',
    'menu_gen',
    'menu_utils',
    'menubar',
    'modkey',
    'mouse',
    'mousegrabber',
    'name',
    'naughty',
    'overflow',
    'panel_hold',
    'percentage',
    'popup',
    'progressbar',
    'prompt',
    'queue',
    'rawlen',
    'remember',
    'restore',
    'reverse',
    'root',
    'rubato',
    'ruled',
    's',
    'save_state',
    'scan',
    'screen_geometry',
    'screen',
    'scrollbox',
    'selection',
    'separator_widget',
    'separator',
    'seperator_widget',
    'settings',
    'signals',
    'snap_edge',
    'sound',
    'spawn',
    'string',
    'table.unpack',
    'tag',
    'task_list',
    'taskbar',
    'terminal',
    'text_editor',
    'theme_dir',
    'tip',
    'title_table',
    'titlebar_icon_path',
    'titlebar_theme',
    'utils_dir',
    'watch',
    'web_browser',
    'wibox',
    'window',
    'xresources'
}
globals = {
    'altkey',
    'apps',
    'arrange',
    'awesome',
    'awestore',
    'awful_menu',
    'awful',
    'backdrop',
    'beautiful',
    'bottom_panel',
    'cache',
    'cairo',
    'card',
    'cc_toggle',
    'clickable_container',
    'client_buttons',
    'client_keys',
    'client',
    'colorize_text',
    'colors',
    'config_dir',
    'connections',
    'control_c',
    'control_center',
    'dashboard',
    'date',
    'detect',
    'dpi',
    'editor_cmd',
    'file_manager',
    'file',
    'filehandle',
    'files',
    'filesystem',
    'format_item',
    'freedesktop',
    'gears',
    'gfs',
    'gobject',
    'gstring',
    'gtable',
    'gtimer',
    'gtk_variable',
    'hardware',
    'HOME',
    'hotkeys_popup',
    'icon_theme',
    'icons',
    'info_center',
    'inspect',
    'logger',
    'math',
    'menu_gen',
    'menu_utils',
    'menubar',
    'modkey',
    'mouse',
    'mousegrabber',
    'name',
    'naughty',
    'overflow',
    'panel_hold',
    'percentage',
    'popup',
    'prompt',
    'remember',
    'restore',
    'root',
    'rubato',
    'ruled',
    's',
    'scan',
    'screen_geometry',
    'screen',
    'scrollbox',
    'separator_widget',
    'seperator_widget',
    'settings',
    'signals',
    'snap_edge',
    'spawn',
    'string',
    'tag',
    'task_list',
    'taskbar',
    'terminal',
    'text_editor',
    'theme_dir',
    'tip',
    'title_table',
    'titlebar_icon_path',
    'titlebar_theme',
    'utils_dir',
    'watch',
    'web_browser',
    'wibox',
    'xresources'
}

-- Enable cache (uses .luacheckcache relative to this rc file).
cache = true

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
