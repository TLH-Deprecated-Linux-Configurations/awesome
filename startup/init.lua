--  _______ __               __
-- |     __|  |_.---.-.----.|  |_.--.--.-----.
-- |__     |   _|  _  |   _||   _|  |  |  _  |
-- |_______|____|___._|__|  |____|_____|   __|
--                                     |__|
-- ------------------------------------------------- --
pcall(require, "luarocks.loader")
-- ------------------------------------------------- --
-- ------------ Necessary Preliminaries ------------ --
filesystem = require("gears.filesystem")
require("lgi")
config_dir = filesystem.get_configuration_dir()
require("awful.autofocus")
require("startup.screen")
