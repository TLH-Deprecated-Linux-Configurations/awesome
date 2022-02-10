--  ______               ___ __                          __   __
-- |      |.-----.-----.'  _|__|.-----.--.--.----.---.-.|  |_|__|.-----.-----.
-- |   ---||  _  |     |   _|  ||  _  |  |  |   _|  _  ||   _|  ||  _  |     |
-- |______||_____|__|__|__| |__||___  |_____|__| |___._||____|__||_____|__|__|
--                              |_____|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- "Configuration" in this context means modifying the behavior of the
-- modules that come with Awesome in some way.
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
return {
    keys = require(... .. '.keys'),
    apps = require(... .. '.root.apps'),
    require(... .. '.client'),
    require(... .. '.root'),
    require(... .. '.tags'),
    root.keys(require(... .. '.keys.global'))
}
