-- Only allow symbols available in all Lua versions
std = "min"

-- Get rid of "unused argument self"-warnings
self = false

-- The unit tests can use busted
files["spec"].std = "+busted"

-- The default config may set global variables
files["awesomerc.lua"].allow_defined_top = true

-- This file itself
files[".luacheckrc"].ignore = {"111", "112", "131"}

-- ignore file max line length
-- ignore string containing trailing whitespace
-- ignore mutating of global variables
-- ifnore setting global variables
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
    "lib/lib-lua/ssl/https.lua",
    -- contains a lot of globals
    "tests/**"
    --"plugins/**",
}

-- Global objects defined by the C code
read_globals = {
    "awesome",
    "button",
    "client",
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
    "rawlen"
}

-- screen may not be read-only, because newer luacheck versions complain about
-- screen[1].tags[1].selected = true.
-- The same happens with the following code:
-- client may not be read-only due to client.focus.
globals = {
    "screen",
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
    "awesome"
}

-- Enable cache (uses .luacheckcache relative to this rc file).
cache = true

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
