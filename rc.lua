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
require("lib.luapath")
require("lib.logger")
print("Booting up...")
-- ########################################################################
require("global_var")
require("awful.autofocus")
-- ########################################################################
-- We load in the notifications before loading anything else so we get errors to display appropiately
require("module.notifications")
-- ########################################################################

require("module.titlebar")()
require("module.backdrop")
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
require("module.bootup_configuration")
require("module.lazy_load_boot")
