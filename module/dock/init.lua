--  _____              __
-- |     \.-----.----.|  |--.
-- |  --  |  _  |  __||    <
-- |_____/|_____|____||__|__|
-- ------------------------------------------------- --
-- Thanks to:
-- ------------------------------------------------- --
local dock = require('module.dock.dock')

local dockbar = function(s)
    dock.init(
        {
            screen = s,
            height = dpi(95),
            offset = dpi(1),
            inner_shape = gears.shape.rounded_rect
        }
    )
end
return dockbar
