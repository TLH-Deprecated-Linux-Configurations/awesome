--  ______               ___ __
-- |      |.-----.-----.'  _|__|.-----.
-- |   ---||  _  |     |   _|  ||  _  |
-- |______||_____|__|__|__| |__||___  |
--                              |_____|
return {
  keys = require("config.keys"),
  apps = require("config.root.apps"),
  require("settings.global_variables"),
  require("config.root")
}
