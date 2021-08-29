--        __ __               __        __           __   __
-- .----.|  |__|.-----.-----.|  |_     |  |--.--.--.|  |_|  |_.-----.-----.-----.
-- |  __||  |  ||  -__|     ||   _|    |  _  |  |  ||   _|   _|  _  |     |__ --|
-- |____||__|__||_____|__|__||____|    |_____|_____||____|____|_____|__|__|_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Buttons for client windows, enabling grabbing the titlebar to move the
-- window without additional key presses and other goodies
local function getButtons()
    return awful.util.table.join(
        awful.button(
            {},
            1,
            function(c)
                -- only raise the focus if the app is not onboard
                if c.name ~= 'Onboard' and c.name ~= 'onboard' then
                    _G.client.focus = c
                    c:raise()
                end
            end
        ),
        awful.button(
            {modkey},
            1,
            function(c)
                c:activate {context = 'mouse_click', action = 'mouse_move'}
            end
        ),
        awful.button(
            {modkey},
            3,
            function(c)
                c:activate {context = 'mouse_click', action = 'mouse_resize'}
            end
        )
    )
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
client.connect_signal(
    'request::default_mousebindings',
    function()
        awful.mouse.append_client_mousebindings(
            {
                awful.button(
                    {modkey},
                    1,
                    function(c)
                        c:activate {context = 'mouse_click', action = 'mouse_move'}
                    end
                ),
                awful.button(
                    {modkey},
                    3,
                    function(c)
                        c:activate {context = 'mouse_click', action = 'mouse_resize'}
                    end
                )
            }
        )
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
return getButtons()
