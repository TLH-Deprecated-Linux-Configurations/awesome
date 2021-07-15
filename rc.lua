--  _______                                             ________ _______
-- |   _   |.--.--.--.-----.-----.-----.--------.-----.|  |  |  |   |   |
-- |       ||  |  |  |  -__|__ --|  _  |        |  -__||  |  |  |       |
-- |___|___||________|_____|_____|_____|__|__|__|_____||________|__|_|__|
-- ########################################################################
--  By Thomas Leon Highbaugh
--  As part of the Electric Tantra Linux
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")
-- ########################################################################
require("module.functions.luapath")
require("module.functions.logger")
print("Booting up...")
-- ########################################################################
require("configuration.global_var")
require("awful.autofocus")
-- ########################################################################
-- We load in the notifications before loading anything else so we get errors to display appropiately
require("module.settings.notifications")
-- ########################################################################

require("widget.titlebar")()
require("module.ui-components.backdrop")

local bling = require("lib.bling")
bling.module.window_swallowing.start() -- activates window swallowing
--bling.module.window_swallowing.stop()    -- deactivates window swallowing
--bling.module.window_swallowing.toggle()  -- toggles window swallowing
bling.module.flash_focus.enable()
-- ########################################################################
-- Layout
require("layout")
-- ########################################################################
require("module")
-- ########################################################################
-- Setup configurations
require("configuration.client")
require("configuration.tags")
_G.root.keys(require("configuration.keys.global"))

-- ########################################################################
require("module.settings.bootup_configuration")
require("module.settings.lazy_load_boot")

-- remove all images from memory (to save memory space at expense of the CPU so don't go hammer time too hard)
collectgarbage("collect")
collectgarbage("setpause", 100)
collectgarbage("setstepmul", 400)
