--  _______ __               __
-- |     __|  |_.---.-.----.|  |_.--.--.-----.
-- |__     |   _|  _  |   _||   _|  |  |  _  |
-- |_______|____|___._|__|  |____|_____|   __|
--                                     |__|
-- ------------------------------------------------- --
-- call lua dependencies
pcall(require, 'luarocks.loader')
pcall(require, 'luajit.bin.activate')
pcall(require, 'luajit.bin.lua')
pcall(require, 'luajit.bin.luarocks')

-- ------------------------------------------------- --
-- ------------ Necessary Preliminaries ------------ --
filesystem = require('gears.filesystem')
require('lgi')
config_dir = filesystem.get_configuration_dir()
require('awful.autofocus')
require('startup.screen')
require('settings')
