--  ______               ___ __
-- |      |.-----.-----.'  _|__|.-----.
-- |   ---||  _  |     |   _|  ||  _  |
-- |______||_____|__|__|__| |__||___  |
--                              |_____|
-- ------------------------------------------------- --
-- NOTE: This provides the keys and apps objects, while
-- also calling the root and global_variables objects to
-- enable the rest of the configuration to load properly.
-- ------------------------------------------------- --

return {
  keys = require('configuration.root.keys'),
  apps = require('configuration.root.apps'),
  require('settings.global_variables'),
  require('configuration.root')
}
