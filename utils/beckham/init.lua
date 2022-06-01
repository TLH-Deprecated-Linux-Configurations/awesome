--  ______              __     __
-- |   __ \.-----.----.|  |--.|  |--.---.-.--------.
-- |   __ <|  -__|  __||    < |     |  _  |        |
-- |______/|_____|____||__|__||__|__|___._|__|__|__|
-- ------------------------------------------------- --
-- allows automatically focusing back to the previous client
-- on window close (unmanage) or minimize.
-- from https://github.com/basaran/awesomewm-backham
-- PS name modification intentional
-- ------------------------------------------------- --

function beckham()
    local s = awful.screen.focused()
    local c = awful.client.focus.history.get(s, 0)
    if c then
        client.focus = c
        c:raise()
    end
end
-- ------------------------------------------------- --
-- signals
client.connect_signal('property::minimized', beckham)
--+ attach to minimized state

client.connect_signal('unmanage', beckham)
--+ attach to closed state

return beckham
