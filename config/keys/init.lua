return {
    mod = require('config.keys.mod'),
    global = require('config.keys.global'),
    _G.root.keys(gears.table.join(_G.root.keys(), require('config.keys.global')))
}
