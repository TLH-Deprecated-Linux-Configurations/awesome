--  ______               ___ __                          __   __
-- |      |.-----.-----.'  _|__|.-----.--.--.----.---.-.|  |_|__|.-----.-----.
-- |   ---||  _  |     |   _|  ||  _  |  |  |   _|  _  ||   _|  ||  _  |     |
-- |______||_____|__|__|__| |__||___  |_____|__| |___._||____|__||_____|__|__|
--                              |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- "Configuration" in this context means modifying the behavior of the
-- modules that come with Awesome in some way.
-- ########################################################################
-- ########################################################################
-- ########################################################################
return {
    keys = require('configuration.keys'),
    apps = require('configuration.apps'),
    require('configuration.client'),
    require('configuration.root'),
    require('configuration.tags'),
    require('configuration.garbage_collection'),
    root.keys(require('configuration.keys.global'))
}
