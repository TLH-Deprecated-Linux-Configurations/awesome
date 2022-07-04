--  _______               __ __              __   __
-- |   _   |.-----.-----.|  |__|.----.---.-.|  |_|__|.-----.-----.-----.
-- |       ||  _  |  _  ||  |  ||  __|  _  ||   _|  ||  _  |     |__ --|
-- |___|___||   __|   __||__|__||____|___._||____|__||_____|__|__|_____|
--          |__|  |__|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local drop = require("utils.dropdown")
local apps = require("config.root.apps")

-- ------------------------------------------------- --

local applicationsmap = {
    {"separator", "Applications"},
    {
        "Return",
        function(c)
            drop.toggle(apps.default.terminal, "left", "top", 0.7, 0.7)
        end,
        "Dropdown Terminal"
    },
    -- ------------------------------------------------- --
    {
        "t",
        function(c)
            awful.spawn(apps.default.terminal)
        end,
        "Terminal"
    },
    -- ------------------------------------------------- --
    {
        "b",
        function(c)
            awful.spawn(apps.default.browser)
        end,
        "Browser"
    },
    -- ------------------------------------------------- --
    {
        "f",
        function(c)
            awful.spawn(apps.default.file_manager)
        end,
        "File Manager"
    },
    -- ------------------------------------------------- --
    {
        "i",
        function(c)
            awful.spawn.easy_async_with_shell("~/.config/awesome/config/rofi/fontawesome_menu/fontawesome-menu")
        end,
        "Icon Selector"
    },
    -- ------------------------------------------------- --
    {
        "c",
        function()
            awful.spawn(apps.default.editor)
        end,
        "Code Editor"
    },
    {
        "e",
        function()
            awful.spawn(apps.default.email)
        end,
        "Email Client"
    },
    -- ------------------------------------------------- --
    {"separator", "Screenshots"},
    -- ------------------------------------------------- --
    {
        "Print",
        function(c)
            awful.spawn.easy_async_with_shell("$HOME/.config/awesome/bin/snapshot.sh area")
        end,
        "Area Screenshot"
    },
    -- To be honest, I never want or need the full screenshot but here it is
    {
        "Insert",
        function(c)
            awful.spawn.easy_async_with_shell("$HOME/.config/awesome/bin/snapshot.sh full")
        end,
        "Full Screenshot"
    },
    {"separator", " "}
}

return applicationsmap
