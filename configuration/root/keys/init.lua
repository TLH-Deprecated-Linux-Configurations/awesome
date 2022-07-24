--  __  __
-- |  |/  |.-----.--.--.-----.
-- |     < |  -__|  |  |__ --|
-- |__|\__||_____|___  |_____|
--               |_____|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
return {
    mod = require('configuration.root.keys.mod'),
    global = require('configuration.root.keys.global'),
    _G.root.keys(gears.table.join(_G.root.keys(), require('configuration.root.keys.global')))
}
