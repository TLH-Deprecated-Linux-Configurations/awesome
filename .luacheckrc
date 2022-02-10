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
    '.luacheckrc'
}

-- Global objects defined by the C code
read_globals = {
    'base',
    'math',
    'string',
    'fixed',
    'separator',
    'gshape',
    'gobject',
    'ruled',
    'awesome',
    'button',
    'client',
    'config',
    'dbus',
    'drawable',
    'drawin',
    'key',
    'keygrabber',
    'mousegrabber',
    'selection',
    'tag',
    'window',
    'table.unpack',
    'math.atan2',
    'math.pow',
    'reverse',
    'center',
    'save_state',
    'dont_disturb',
    'clear_desktop_selection',
    'wibox',
    'rawlen',
    'queue',
    'menubar',
    'progressbar',
    'wibox',
    'sound',
    'common',
    'gtable'
}

globals = {
    'awesome',
    'math',
    'root',
    'string',
    'screen',
    'mouse',
    'client',
    'beautiful',
    'awful',
    'gears',
    'filesystem',
    'config_dir',
    'utils_dir',
    'clickable_container',
    'wibox',
    'dpi',
    'naughty',
    'watch',
    'spawn',
    'icons',
    'task_list',
    'apps',
    'bottom_panel',
    'control_center',
    'info_center',
    'tag',
    'modkey',
    'cairo',
    'altkey',
    'title_table',
    'ruled',
    'client_keys',
    'client_buttons',
    'signals',
    'file',
    'menubar',
    'awful_menu',
    'menu_gen',
    'menu_utils',
    'icon_theme',
    'hotkeys_popup',
    'terminal',
    'web_browser',
    'file_manager',
    'text_editor',
    'editor_cmd'
}

-- Enable cache (uses .luacheckcache relative to this rc file).
cache = true

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
