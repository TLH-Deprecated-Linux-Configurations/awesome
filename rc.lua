--  _______                                             ________ _______
-- |   _   |.--.--.--.-----.-----.-----.--------.-----.|  |  |  |   |   |
-- |       ||  |  |  |  -__|__ --|  _  |        |  -__||  |  |  |       |
-- |___|___||________|_____|_____|_____|__|__|__|_____||________|__|_|__|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Flying Spaghetti Monster of Code & Core of the Electric Tantra Linux
-- by Thomas Leon Highbaugh
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- If LuaRocks is installed, make sure that packages installed through it
-- are found (e.g. lgi). If LuaRocks is not installed, do nothing.
--
pcall(require, 'luarocks.loader')

-- Insure these are called, they are needed before the rest of configuration
require('configuration.root.global_variables')
require('configuration.root.garbage_collection')
require('module.notifications')
-- necessary libraru not called in global_variables
require('awful.autofocus')
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Theme
--
beautiful.init(require('theme'))
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Layout
--
require('layout')

-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Modules
--
require('module')

-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Configuration
--
require('configuration')

-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Library
--
require('library.application-switcher')
