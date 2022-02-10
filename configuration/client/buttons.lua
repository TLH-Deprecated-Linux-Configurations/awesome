--  ______ __ __               __
-- |      |  |__|.-----.-----.|  |_
-- |   ---|  |  ||  -__|     ||   _|
-- |______|__|__||_____|__|__||____|

--  ______         __   __
-- |   __ \.--.--.|  |_|  |_.-----.-----.-----.
-- |   __ <|  |  ||   _|   _|  _  |     |__ --|
-- |______/|_____||____|____|_____|__|__|_____|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --

return awful.util.table.join(
    awful.button(
        {},
        1,
        function(c)
            c:emit_signal('request::activate')
            c:raise()
        end
    ),
    awful.button({modkey}, 1, awful.mouse.client.move),
    awful.button({modkey}, 3, awful.mouse.client.resize),
    awful.button(
        {modkey},
        8,
        function()
            awful.layout.inc(1)
        end
    ),
    awful.button(
        {modkey},
        9,
        function()
            awful.layout.inc(-1)
        end
    )
)
