--  ______               __
-- |   __ \.-----.-----.|  |_
-- |      <|  _  |  _  ||   _|
-- |___|__||_____|_____||____|

--  ______         __   __
-- |   __ \.--.--.|  |_|  |_.-----.-----.-----.
-- |   __ <|  |  ||   _|   _|  _  |     |__ --|
-- |______/|_____||____|____|_____|__|__|_____|
-- ------------------------------------------------- --
-- In the awesome context, buttons refer primarily to the mouse buttons and
-- in the root context to what the mouse buttons do if used without a client
-- beneath the mouse when the button is pressed such as when looking at a
-- blank screen
-- ------------------------------------------------- --
_G.root.buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            function()
                -- if mymainmenu then
                -- mymainmenu:toggle()
                -- end
            end
        ),
        awful.button(
            {},
            2,
            function()
            end
        ),
        awful.button(
            {},
            3,
            function()
                if mymainmenu then
                    mymainmenu:toggle()
                end
            end
        ),
        -- ------------------------------------------------- --
        -- with modifier
        awful.button(
            {"Control"},
            2,
            function()
                awesome.emit_signal("module::exit_screen:show")
            end
        ),
        -- ------------------------------------------------- --
        -- buttons next to scrollwheel
        awful.button(
            {},
            8,
            function()
                awful.spawn("light -A 10", false)
                awesome.emit_signal("widget::brightness")
                awesome.emit_signal("module::brightness_osd:show", true)
            end
        ),
        awful.button(
            {},
            9,
            function()
                awful.spawn("light -U 10", false)
                awesome.emit_signal("widget::brightness")
                awesome.emit_signal("module::brightness_osd:show", true)
            end
        ),
        -- ------------------------------------------------- --
        -- With modifiers
        awful.button(
            {"Control"},
            8,
            function()
                awful.spawn("amixer sset Master 5%+", true)
                awesome.emit_signal("widget::volume")
                awesome.emit_signal("module::volume_osd:show", true)
            end
        ),
        awful.button(
            {"Control"},
            9,
            function()
                awful.spawn("amixer sset Master 5%-", true)
                awesome.emit_signal("widget::volume")
                awesome.emit_signal("module::volume_osd:show", true)
            end
        )
    )
)
