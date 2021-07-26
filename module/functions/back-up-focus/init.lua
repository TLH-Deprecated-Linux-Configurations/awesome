
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- From https://github.com/basaran/awesomewm-backham/blob/master/init.lua
--+ allows automatically focusing back to the previous client
--> on window close (unmanage) or minimize.

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Function
-- ########################################################################
local function backup()
    local s = awful.screen.focused()
    local c = awful.client.focus.history.get(s, 0)
    if c then
        client.focus = c
        c:raise()
    end
end

-- ########################################################################
-- ########################################################################
-- ########################################################################

--+ attach to minimized state

client.connect_signal("property::minimized", backup)


--+ attach to closed state

client.connect_signal("unmanage", backup)

return backup