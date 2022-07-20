--  __  __
-- |  |/  |.-----.--.--.-----.
-- |     < |  -__|  |  |__ --|
-- |__|\__||_____|___  |_____|
--               |_____|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
return {
    mod = require('configuration.keys.mod'),
    global = require('configuration.keys.global'),
    _G.root.keys(gears.table.join(_G.root.keys(), require('configuration.keys.global')))
}
