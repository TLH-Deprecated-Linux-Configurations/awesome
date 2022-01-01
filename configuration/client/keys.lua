--  ______ __ __               __
-- |      |  |__|.-----.-----.|  |_
-- |   ---|  |  ||  -__|     ||   _|
-- |______|__|__||_____|__|__||____|

--  __  __
-- |  |/  |.-----.--.--.-----.
-- |     < |  -__|  |  |__ --|
-- |__|\__||_____|___  |_____|
--               |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
require('awful.autofocus')

-- ########################################################################
-- ########################################################################
-- ########################################################################
local client_keys =
    awful.util.table.join(
    awful.key(
        {modkey},
        'm',
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = 'Toggle Maximized', group = 'Client'}
    ),
    -- ########################################################################

    awful.key(
        {modkey, 'Shift'},
        'm',
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = 'Toggle Fullscreen', group = 'Client'}
    ),
    -- ########################################################################
    awful.key(
        {modkey},
        'x',
        function(c)
            c:kill()
        end,
        {description = 'Close', group = 'Client'}
    ),
    -- ########################################################################
    awful.key(
        {modkey},
        'd',
        function()
            awful.client.focus.byidx(1)
        end,
        {description = 'Focus Next by Index', group = 'Client'}
    ),
    -- ########################################################################
    awful.key(
        {modkey},
        'a',
        function()
            awful.client.focus.byidx(-1)
        end,
        {description = 'Focus Previous by Index', group = 'Client'}
    ),
    -- ########################################################################
    awful.key(
        {modkey, 'Shift'},
        'd',
        function()
            awful.client.swap.byidx(1)
        end,
        {description = 'Swap with Next Client by Index', group = 'Client'}
    ),
    -- ########################################################################
    awful.key(
        {modkey, 'Shift'},
        'a',
        function()
            awful.client.swap.byidx(-1)
        end,
        {description = 'Swap with Next Client by Index', group = 'Client'}
    ),
    -- ########################################################################
    awful.key({modkey}, 'u', awful.client.urgent.jumpto, {description = 'Jump to Urgent Client', group = 'Client'}),
    -- ########################################################################
    awful.key(
        {modkey},
        'Tab',
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = 'Go Back', group = 'Client'}
    ),
    -- ########################################################################
    awful.key(
        {modkey},
        'n',
        function(c)
            c.minimized = true
        end,
        {description = 'Minimize Client', group = 'Client'}
    ),
    -- ########################################################################
    awful.key(
        {modkey, 'Shift'},
        'f',
        function(c)
            local focused = awful.screen.focused()

            awful.placement.centered(
                c,
                {
                    honor_workarea = true
                }
            )
        end,
        {description = 'Align a Client to the Center of the Focused Screen', group = 'client'}
    ),
    -- ########################################################################
    awful.key(
        {modkey},
        'f',
        function(c)
            c.fullscreen = false
            c.maximized = false
            c.floating = not c.floating
            c:raise()
        end,
        {description = 'Toggle Floating', group = 'client'}
    ),
    -- ########################################################################
    awful.key(
        {modkey},
        'Up',
        function(c)
            c:relative_move(0, dpi(-10), 0, 0)
        end,
        {description = 'Move Floating Client up by 10px', group = 'client'}
    ),
    -- ########################################################################
    awful.key(
        {modkey},
        'Down',
        function(c)
            c:relative_move(0, dpi(10), 0, 0)
        end,
        {description = 'Move Floating Client down by 10px', group = 'client'}
    ),
    -- ########################################################################
    awful.key(
        {modkey},
        'Left',
        function(c)
            c:relative_move(dpi(-10), 0, 0, 0)
        end,
        {description = 'Move Floating Client to the Left by 10px', group = 'client'}
    ),
    -- ########################################################################
    awful.key(
        {modkey},
        'Right',
        function(c)
            c:relative_move(dpi(10), 0, 0, 0)
        end,
        {description = 'Move Floating Client to the Right by 10px', group = 'client'}
    ),
    -- ########################################################################
    awful.key(
        {modkey, 'Shift'},
        'Up',
        function(c)
            c:relative_move(0, dpi(-10), 0, dpi(10))
        end,
        {description = 'Increase Floating Client Size Vertically by 10px up', group = 'client'}
    ),
    -- ########################################################################
    awful.key(
        {modkey, 'Shift'},
        'Down',
        function(c)
            c:relative_move(0, 0, 0, dpi(10))
        end,
        {description = 'Increase Floating Client Size Vertically by 10px down', group = 'client'}
    ),
    -- ########################################################################
    awful.key(
        {modkey, 'Shift'},
        'Left',
        function(c)
            c:relative_move(dpi(-10), 0, dpi(10), 0)
        end,
        {description = 'Increase Floating Client Size Horizontally by 10px Left', group = 'client'}
    ),
    -- ########################################################################
    awful.key(
        {modkey, 'Shift'},
        'Right',
        function(c)
            c:relative_move(0, 0, dpi(10), 0)
        end,
        {description = 'Increase Floating Client Size Horizontally by 10px Right', group = 'client'}
    ),
    -- ########################################################################
    awful.key(
        {modkey, 'Control'},
        'Up',
        function(c)
            if c.height > 10 then
                c:relative_move(0, 0, 0, dpi(-10))
            end
        end,
        {description = 'Decrease Floating Client Size Vertically by 10px up', group = 'client'}
    ),
    -- ########################################################################
    awful.key(
        {modkey, 'Control'},
        'Down',
        function(c)
            local c_height = c.height
            c:relative_move(0, 0, 0, dpi(-10))
            if c.height ~= c_height and c.height > 10 then
                c:relative_move(0, dpi(10), 0, 0)
            end
        end,
        {description = 'Decrease Floating Client Size Vertically by 10px down', group = 'client'}
    ),
    -- ########################################################################
    awful.key(
        {modkey, 'Control'},
        'Left',
        function(c)
            if c.width > 10 then
                c:relative_move(0, 0, dpi(-10), 0)
            end
        end,
        {description = 'Decrease Floating Client Size Horizontally by 10px Left', group = 'client'}
    ),
    -- ########################################################################
    awful.key(
        {modkey, 'Control'},
        'Right',
        function(c)
            local c_width = c.width
            c:relative_move(0, 0, dpi(-10), 0)
            if c.width ~= c_width and c.width > 10 then
                c:relative_move(dpi(10), 0, 0, 0)
            end
        end,
        {description = 'Decrease Floating Client Size Horizontally by 10px Right', group = 'client'}
    )
)

return client_keys
