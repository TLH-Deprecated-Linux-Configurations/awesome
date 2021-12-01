-- ########################################################################
--        __ __               __
-- .----.|  |__|.-----.-----.|  |_
-- |  __||  |  ||  -__|     ||   _|
-- |____||__|__||_____|__|__||____|
--  __           __   __
-- |  |--.--.--.|  |_|  |_.-----.-----.
-- |  _  |  |  ||   _|   _|  _  |     |
-- |_____|_____||____|____|_____|__|__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Buttons for client windows, enabling grabbing the titlebar to move the
-- window without additional key presses and other goodies
-- Scrollwheel swithching tags is definitely set to off, because it makes
-- things go wrong more than right, not sure why people like this
-- ########################################################################
-- #######################################################################
-- ########################################################################
local function getButtons()
    return awful.util.table.join(
        awful.button(
            {},
            1,
            function(c)
                -- only raise the focus if the app is not present
                --
                if c.name ~= " " and c.name ~= "onboard" then
                    _G.client.focus = c
                    c:raise()
                end
            end
        ),
        awful.button(
            {modkey},
            1,
            function(c)
                c:activate {context = "mouse_click", action = "mouse_move"}
            end
        ),
        awful.button(
            {modkey},
            3,
            function(c)
                c:activate {context = "mouse_click", action = "mouse_resize"}
            end
        )
    )
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
client.connect_signal(
    "request::default_mousebindings",
    function()
        awful.mouse.append_client_mousebindings(
            {
                awful.button(
                    {modkey},
                    1,
                    function(c)
                        c:activate {context = "mouse_click", action = "mouse_move"}
                    end
                ),
                awful.button(
                    {modkey},
                    3,
                    function(c)
                        c:activate {context = "mouse_click", action = "mouse_resize"}
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
