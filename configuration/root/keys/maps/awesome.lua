--  _______
-- |   _   |.--.--.--.-----.-----.-----.--------.-----.
-- |       ||  |  |  |  -__|__ --|  _  |        |  -__|
-- |___|___||________|_____|_____|_____|__|__|__|_____|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local hotkeys_popup_custom = require('module.hotkeys-popup')
local awesomemap = {
    {
        'r',
        function(c)
            awesome.restart()
        end,
        'Restart'
    },
    -- ------------------------------------------------- --
    {
        'q',
        function(c)
            awesome.quit()
        end,
        'Quit'
    },
    -- ------------------------------------------------- --
    {
        'e',
        function(c)
            _G.exit_screen_show()
        end,
        'Exit Screen'
    },
    -- ------------------------------------------------- --
    {
        'h',
        function(c)
            hotkeys_popup_custom.show_help()
        end,
        'Hotkeys Popup'
    },
    -- ------------------------------------------------- --
    {
        'w',
        function()
            awful.menu.menu_keys.down = {'Down', 'Alt_L'}
            awful.menu.menu_keys.up = {'Up', 'Alt_R'}
            awful.menu.clients({theme = {width = 450}}, {keygrabber = true})
        end,
        'Client List'
    },
    -- ------------------------------------------------- --
    {
        'd',
        function()
            dashboard:toggle()
        end,
        'Dashboard'
    },
    -- ------------------------------------------------- --
    {'separator', ' '}
}

return awesomemap
