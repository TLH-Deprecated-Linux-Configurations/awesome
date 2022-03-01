pcall(require, "luarocks.loader")
filesystem = require("gears.filesystem")
config_dir = filesystem.get_configuration_dir()

require("settings.global_variables")
require("settings.garbage_collection")

require("awful.autofocus")

require("startup")
require("config")
require("layout")
require("config.client")
_G.root.keys(require("config.keys.global"))
require("themes")

require("utils")
require("signal")
require("module")
