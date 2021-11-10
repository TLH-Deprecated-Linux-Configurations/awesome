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
--
pcall(require, "luarocks.loader")
pcall(require, "lua53.luarocks.loader")
-- ########################################################################
-- First get logging ready
--
require("widget.functions.luapath")
require("widget.functions.logger")

-- An example of how that works
--
print("Booting up...")
-- ########################################################################
-- Function for garbage collection to keep memory use stable
require("configuration.settings.garbage")
-- ########################################################################
require("configuration.settings.global_var")

-- ########################################################################
-- Pull in this for focus following the mouse
--
require("awful.autofocus")
-- ########################################################################
-- Load the notifications & errors early to get the messages when things go wrong
--
require("configuration.settings")
-- ########################################################################
-- Titlebar with custom icons
--
require("widget.interface.titlebar")

-- ########################################################################
-- Layout which features the bars
--
require("layout")
-- ########################################################################
--
require("configuration.settings")
require("widget.interface.exit-screen")
require("widget.hardware")

require("widget.hardware.battery.battery-notifier")

-- ########################################################################
-- Setup configurations of client, keys and tags
--
require("configuration.client")
require("configuration.tags")
_G.root.keys(require("configuration.keys.global"))

require("sound")
-- ########################################################################
-- Other bootup functions
--
require("configuration.settings.bootup_configuration")
require("configuration.settings")
require("widget")
