require("lib-tde.luapath")
require("lib-tde.logger")

print("Booting up...")

require("global_var")

require("awful.autofocus")

-- We load in the notifications before loading in the plugins, this is because if an error occurred during plugin loading it will be displayed correctly
--require("module.notifications")

    require("module.titlebar")()

    require("module.backdrop")

    -- Layout
    require("layout")

    require("module")

    -- Setup all configurations
    require("configuration.client")
    require("configuration.tags")
    _G.root.keys(require("configuration.keys.global"))

    require("module.bootup_configuration")
    require("module.lazy_load_boot")
