--  ______              __         _______             _______
-- |   __ \.---.-.----.|  |--.    |   |   |.-----.    |    ___|.-----.----.--.--.-----.
-- |   __ <|  _  |  __||    <     |   |   ||  _  |    |    ___||  _  |  __|  |  |__ --|
-- |______/|___._|____||__|__|    |_______||   __|    |___|    |_____|____|_____|_____|                                        |__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- From https://github.com/basaran/awesomewm-backham/blob/master/init.lua
--+ allows automatically focusing back to the previous client
--> on window close (unmanage) or minimize.

-------------------------------------------------------------------> methods ;

function backup()
    local s = awful.screen.focused()
    local c = awful.client.focus.history.get(s, 0)
    if c then
        client.focus = c
        c:raise()
    end
end

--------------------------------------------------------------------> signal ;

client.connect_signal("property::minimized", backup)
--+ attach to minimized state

client.connect_signal("unmanage", backup)
--+ attach to closed state
