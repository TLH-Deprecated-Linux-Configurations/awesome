--  ______               ___ __
-- |      |.-----.-----.'  _|__|.-----.
-- |   ---||  _  |     |   _|  ||  _  |
-- |______||_____|__|__|__| |__||___  |
--                              |_____|
return {
  keys = require('configuration.keys'),
  apps = require('configuration.root.apps'),
  require('settings.global_variables'),
  require('configuration.root')
}
