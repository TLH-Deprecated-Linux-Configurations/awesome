--  _______                   __ __ __
-- |     __|.----.----.-----.|  |  |  |--.-----.--.--.
-- |__     ||  __|   _|  _  ||  |  |  _  |  _  |_   _|
-- |_______||____|__| |_____||__|__|_____|_____|__.__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local wibox = require("wibox")
-- ########################################################################
-- ########################################################################
-- ########################################################################
--- Create a new scrollable widget

return function(scrollable)
    local offset = 0
    local max_scroll = 90000 -- if no max scrolling is present we set it to the max

    local widget
    local size = 20

    for s in screen do
        if ((s.geometry.height / 50) > size) then
            size = (s.geometry.height / 50)
        end
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    widget = wibox.container.margin(scrollable)

    --- Reset the scrollbox to its initial state
    widget.reset = function()
        -- reset the internal state
        offset = 0

        -- move the widget back to its original position
        widget.top = 0
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    widget:buttons(awful.util.table.join(
                       awful.button({}, 4, function(_)
            if ((offset + size) > 0) then
                offset = 0
            else
                offset = offset + size
            end
            widget.top = offset
        end), awful.button({}, 5, function(_)
            if (offset - 20 < -max_scroll) then
                offset = -max_scroll
            else
                offset = offset - size
            end
            widget.top = offset
        end)))
    return widget
end
