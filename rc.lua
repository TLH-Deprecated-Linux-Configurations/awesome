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
pcall(require, 'luarocks.loader')
-- ########################################################################
-- First get logging ready
--
require('module.functions.luapath')
require('module.functions.logger')
-- An example of how that works
--
print('Booting up...')
-- ########################################################################
-- Function for garbage collection to keep memory use stable
require('configuration.garbage')
-- ########################################################################
require('configuration.global_var')

-- ########################################################################
-- Pull in this for focus following the mouse
--
require('awful.autofocus')
-- ########################################################################
-- Load the notifications & errors early to get the messages when things go wrong
--
require('module.settings.notifications')
-- ########################################################################
-- Titlebar with custom icons
--
require('widget.titlebar')
-- ########################################################################
-- Backdrop for when left and right bar are displayed
--
require('module.interface.backdrop')

-- ########################################################################
-- Layout which features the bars
--
require('layout')
-- ########################################################################
-- Modules
--
require('module')
-- ########################################################################
-- Setup configurations of client, keys and tags
--
require('configuration.client')
require('configuration.tags')
_G.root.keys(require('configuration.keys.global'))

-- ########################################################################
-- Other bootup functions
--
require('module.settings.bootup_configuration')
require('module.settings.lazy_load_boot')
