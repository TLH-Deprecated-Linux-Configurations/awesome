--  _____                    ______         __   __
-- |     |_.--.--.---.-.    |   __ \.---.-.|  |_|  |--.
-- |       |  |  |  _  |    |    __/|  _  ||   _|     |
-- |_______|_____|___._|    |___|   |___._||____|__|__|

-- ########################################################################
-- ########################################################################
-- ########################################################################
local exists = require("module.functions.file").dir_exists
local home = os.getenv("HOME")
-- Used to enable custom widgets as a plugin mechanism for TDE
package.path = os.getenv("HOME") .. "/.config/awesome/?/init.lua;" .. package.path
package.path = os.getenv("HOME") .. "/.config/awesome/?.lua;" .. package.path
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Setup custom lua scripts (libraries)
-- If the user dir exists then use that
-- Otherwise use the system files
if exists(os.getenv("HOME") .. "/.config/awesome") then
    package.path =
        os.getenv("HOME") ..
        "/.config/awesome/?.lua;" .. os.getenv("HOME") .. "/.config/awesome/?/?.lua;" .. package.path
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
if exists(os.getenv("HOME") .. "/.config/awesome/lib/lib-lua") then
    package.path =
        package.path ..
        ";" ..
            os.getenv("HOME") ..
                "/.config/awesome/lib/lib-lua/?/?.lua;" .. os.getenv("HOME") .. "/.config/awesome/lib/lib-lua/?.lua"
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
if exists(os.getenv("HOME") .. "/.config/awesome/lib/translations") then
    package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/awesome/lib/translations/?.lua"
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
package.path =
    package.path .. ";" .. home .. ".config/awesome/lib/lib-lua/?/?.lua;" .. home .. ".config/awesome/lib/lib-lua/?.lua"
package.path = package.path .. ";" .. home .. ".config/awesome/lib/translations/?.lua"
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- same applies for the c libraries
if exists(os.getenv("HOME") .. "/.config/awesome/lib/lib-so") then
    package.cpath =
        package.cpath ..
        ";" ..
            os.getenv("HOME") ..
                "/.config/awesome/lib/lib-so/?/?.so;" .. os.getenv("HOME") .. "/.config/awesome/lib/lib-so/?.so"
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
package.cpath =
    package.cpath .. ";" .. home .. ".config/awesome/lib/lib-so/?/?.so;" .. home .. ".config/awesome/lib/lib-so/?.so"
