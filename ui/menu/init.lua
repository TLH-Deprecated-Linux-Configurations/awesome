-- Create a launcher widget and a main menu
awesomemenu = {
    {
        'Key Binds',
        function()
            hotkeys_popup.show_help(nil, awful.screen.focused())
        end
    },
    {'Manual', terminal .. ' start man awesome'},
    {'Edit Config', editor .. ' ' .. awesome.conffile},
    {'Restart', awesome.restart},
    {
        'Quit',
        function()
            awesome.quit()
        end
    }
}

appmenu = {{'Terminal', terminal}, {'Editor', editor}, {'Browser', browser}, {'Menu', launcher}}

mymainmenu =
    awful.menu(
    {
        items = {
            {'AwesomeWM', awesomemenu, beautiful.awesome_icon},
            {'Apps', appmenu}
        }
    }
)

awful.mouse.append_global_mousebindings(
    {
        awful.button(
            {},
            3,
            function()
                mymainmenu:toggle()
            end
        )
    }
)
