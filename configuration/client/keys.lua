--  ______ __ __               __        __  __
-- |      |  |__|.-----.-----.|  |_     |  |/  |.-----.--.--.-----.
-- |   ---|  |  ||  -__|     ||   _|    |     < |  -__|  |  |__ --|
-- |______|__|__||_____|__|__||____|    |__|\__||_____|___  |_____|
--                                                    |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
require('awful.autofocus')
local config = require('configuration.keys.mod')
local modkey = config.modKey
local dpi = require('beautiful').xresources.apply_dpi
local awful = require('awful')
-- ########################################################################
-- ########################################################################
-- ########################################################################
local clientKeys =
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
        {modkey},
        't',
        function(c)
            c.ontop = not c.ontop
            c.sticky = c.ontop
            c:raise()
        end,
        {description = 'Toggle OnTop Mode', group = 'Client'}
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
        'f',
        function(c)
            c.floating = not c.floating
            c:raise()
        end,
        {description = 'Toggle Floating', group = 'Client'}
    ),
    -- ########################################################################

    awful.key(
        {modkey, 'Shift'},
        'Up',
        function(c)
            c:relative_move(0, dpi(-10), 0, dpi(10))
        end,
        {
            description = 'increase floating client size vertically by 10 px up',
            group = 'client'
        }
    ),
    -- ########################################################################

    awful.key(
        {modkey, 'Shift'},
        'Down',
        function(c)
            c:relative_move(0, 0, 0, dpi(10))
        end,
        {
            description = 'increase floating client size vertically by 10 px down',
            group = 'client'
        }
    ),
    -- ########################################################################

    awful.key(
        {modkey, 'Shift'},
        'Left',
        function(c)
            c:relative_move(dpi(-10), 0, dpi(10), 0)
        end,
        {
            description = 'increase floating client size horizontally by 10 px left',
            group = 'client'
        }
    ),
    -- ########################################################################

    awful.key(
        {modkey, 'Shift'},
        'Right',
        function(c)
            c:relative_move(0, 0, dpi(10), 0)
        end,
        {
            description = 'increase floating client size horizontally by 10 px right',
            group = 'client'
        }
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
        {
            description = 'decrease floating client size vertically by 10 px up',
            group = 'client'
        }
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
        {
            description = 'decrease floating client size vertically by 10 px down',
            group = 'client'
        }
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
        {
            description = 'decrease floating client size horizontally by 10 px left',
            group = 'client'
        }
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
        {
            description = 'decrease floating client size horizontally by 10 px right',
            group = 'client'
        }
    ),
    -- ########################################################################

    awful.key(
        {modkey, 'Shift'},
        'Up',
        function(c)
            c:relative_move(0, dpi(-10), 0, dpi(10))
        end,
        {
            description = 'increase floating client size vertically by 10 px up',
            group = 'client'
        }
    ),
    -- ########################################################################

    awful.key(
        {modkey, 'Shift'},
        'Down',
        function(c)
            c:relative_move(0, 0, 0, dpi(10))
        end,
        {
            description = 'increase floating client size vertically by 10 px down',
            group = 'client'
        }
    ),
    -- ########################################################################

    awful.key(
        {modkey, 'Shift'},
        'Left',
        function(c)
            c:relative_move(dpi(-10), 0, dpi(10), 0)
        end,
        {
            description = 'increase floating client size horizontally by 10 px left',
            group = 'client'
        }
    ),
    -- ########################################################################

    awful.key(
        {modkey, 'Shift'},
        'Right',
        function(c)
            c:relative_move(0, 0, dpi(10), 0)
        end,
        {
            description = 'increase floating client size horizontally by 10 px right',
            group = 'client'
        }
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
        {
            description = 'decrease floating client size vertically by 10 px up',
            group = 'client'
        }
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
        {
            description = 'decrease floating client size vertically by 10 px down',
            group = 'client'
        }
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
        {
            description = 'decrease floating client size horizontally by 10 px left',
            group = 'client'
        }
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
        {
            description = 'decrease floating client size horizontally by 10 px right',
            group = 'client'
        }
    )
)

return clientKeys
