--  _______                                       ________ _______
-- |   _   |.--.--.--.-----.-----.--------.-----.|  |  |  |   |   |
-- |       ||  |  |  |  -__|  _  |        |  -__||  |  |  |       |
-- |___|___||________|_____|_____|__|__|__|_____||________|__|_|__|
-- ------------------------------------------------- --
-- load luarocks modules, or not
pcall(require, "luarocks.loader")
-- ------------------------------------------------- --
-- define vital global variables, first here, then
-- in their own file
filesystem = require("gears.filesystem")
config_dir = filesystem.get_configuration_dir()
require("settings.global_variables")
-- ------------------------------------------------- --
-- set up Lua's internal garbage collector to
-- keep memory footprint under control
require("settings.garbage_collection")
-- ------------------------------------------------- --
-- startup configuration
require("startup")
-- ------------------------------------------------- --
-- Relating to clients and their control, tiling layouts, etc
require("config")
require("layout")
require("config.client")
_G.root.keys(gears.table.join(_G.root.keys(), require("config.keys.global")))
-- ------------------------------------------------- --
-- the appearance variables and styling
require("themes")
-- ------------------------------------------------- --
-- various utilities reused throughout
require("utils")
-- ------------------------------------------------- --
-- daemons, aka scripts running in the background
require("signal")
-- ------------------------------------------------- --
-- UI menus and bar
require("module")
