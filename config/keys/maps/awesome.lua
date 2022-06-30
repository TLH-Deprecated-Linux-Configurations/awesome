--  _______
-- |   _   |.--.--.--.-----.-----.-----.--------.-----.
-- |       ||  |  |  |  -__|__ --|  _  |        |  -__|
-- |___|___||________|_____|_____|_____|__|__|__|_____|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --

local awesomemap = {
    {
        "r",
        function(c)
            awesome.restart()
        end,
        "Restart"
    },
    -- ------------------------------------------------- --
    {
        "q",
        function(c)
            awesome.quit()
        end,
        "Quit"
    },
    -- ------------------------------------------------- --
    {
        "e",
        function(c)
            _G.exit_screen_show()
        end,
        "Exit Screen"
    },
    -- ------------------------------------------------- --
    {
        "d",
        function(c)
            dashboard:toggle()
        end,
        "Dashboard"
    },
    -- ------------------------------------------------- --
    {
        "Print",
        function(c)
            awful.spawn.easy_async_with_shell("$HOME/.config/awesome/bin/snapshot.sh area")
        end,
        "Area Screenshot"
    },
    -- ------------------------------------------------- --
    {
        "p",
        function(c)
            awful.spawn.easy_async_with_shell("$HOME/.config/awesome/bin/snapshot.sh full")
        end,
        "Full Screenshot"
    },
    -- ------------------------------------------------- --
    {
        "w",
        function()
            awful.menu.menu_keys.down = {"Down", "Alt_L"}
            awful.menu.menu_keys.up = {"Up", "Alt_R"}
            awful.menu.clients({theme = {width = 450}}, {keygrabber = true})
        end,
        "Client List"
    },
    -- ------------------------------------------------- --
    {"separator", " "}
}

return awesomemap
