-- Only allow symbols available in all Lua versions
std = "min"

-- Get rid of "unused argument self"-warnings
self = false

-- The unit tests can use busted
files["spec"].std = "+busted"

-- The default config may set global variables
files["configuration.settings.global_var"].allow_defined_top = true

-- This file itself
files[".luacheckrc"].ignore = {"111", "112", "131"}

-- ignore file max line length
-- ignore string containing trailing whitespace
-- ignore mutating of global variables
-- ignore setting global variables
files["**"].ignore = {"631", "613", "112", "122"}

exclude_files = {
	".luacheckrc",
	"lib/*",
	"lib/lib-lua/cjson/util.lua",
	"lib/lib-lua/ltn12.lua",
	"lib/lib-lua/mime.lua",
	"lib/lib-lua/posix/_base.lua",
	"lib/lib-lua/posix/compat.lua",
	"lib/lib-lua/posix/deprecated.lua",
	"lib/lib-lua/posix/init.lua",
	"lib/lib-lua/socket.lua",
	"lib/lib-lua/socket/ftp.lua",
	"lib/lib-lua/socket/http.lua",
	"lib/lib-lua/socket/smtp.lua",
	"lib/lib-lua/socket/tp.lua",
	"lib/lib-lua/socket/url.lua",
	"lib/lib-lua/ssl.lua",
	"lib/lib-lua/ssl/https.lua",
	"lib/lib-lua/cjson/util.lua",
	"lib/lib-lua/ltn12.lua",
	"lib/lib-lua/mime.lua",
	"lib/lib-lua/posix/_base.lua",
	"lib/lib-lua/posix/compat.lua",
	"lib/lib-lua/posix/deprecated.lua",
	"lib/lib-lua/posix/init.lua",
	"lib/lib-lua/socket.lua",
	"lib/lib-lua/socket/ftp.lua",
	"lib/lib-lua/socket/http.lua",
	"lib/lib-lua/socket/smtp.lua",
	"lib/lib-lua/socket/tp.lua",
	"lib/lib-lua/socket/url.lua",
	"lib/lib-lua/ssl.lua",
	"lib/lib-lua/ssl/https.lua"
	-- contains a lot of globals
}

-- Global objects defined by the C code
read_globals = {
	"ruled",
	"awesome",
	"button",
	"client",
	"config",
	"dbus",
	"drawable",
	"drawin",
	"key",
	"keygrabber",
	"mousegrabber",
	"selection",
	"tag",
	"window",
	"table.unpack",
	"math.atan2",
	"math.pow",
	"reverse",
	"center",
	"save_state",
	"dont_disturb",
	"clear_desktop_selection",
	"wibox",
	"rawlen",
	"queue",
	"menubar",
	"progressbar",
	"wibox",
	"sound",
	"common",
	"gtable"
}

globals = {
	"gtable",
	"common",
	"sound",
	"wibox",
	"progressbar",
	"menubar",
	"ruled",
	"queue",
	"screen",
	"gears",
	"gfs",
	"card",
	"tag_list",
	"rubato",
	"hotkey_popup",
	"volume",
	"apps",
	"checkbox",
	"scrollbox",
	"mat_list_item",
	"button",
	"seperator_widget",
	"mat_icon",
	"xrandr",
	"volume",
	"clickable_container",
	"delayed_timer",
	"hotkeys_popup",
	"filesystem",
	"math",
	"naughty",
	"slider",
	"spawn",
	"file",
	"signals",
	"client_keys",
	"client_buttons",
	"modkey",
	"gfs",
	"hardware",
	"dpi",
	"beautiful",
	"mouse",
	"root",
	"client",
	"timer",
	"awful",
	"i18n",
	"general",
	"plugins",
	"tags",
	"keys",
	"floating",
	"backdrop",
	"taglist_occupied",
	"print",
	"echo",
	"desktop_icons",
	"task_list",
	"wibox",
	"xresources",
	"HOME",
	"icons",
	"math",
	"cairo",
	"awesome",
	"wibox",
	"utf8",
	"ipairs",
	"tag",
	"animate"
}

-- Enable cache (uses .luacheckcache relative to this rc file).
cache = true

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
