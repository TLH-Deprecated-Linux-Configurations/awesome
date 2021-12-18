--        __ __        __           __     __
-- .----.|  |__|.----.|  |--.---.-.|  |--.|  |.-----.
-- |  __||  |  ||  __||    <|  _  ||  _  ||  ||  -__|
-- |____||__|__||____||__|__|___._||_____||__||_____|

--                    __          __
-- .----.-----.-----.|  |_.---.-.|__|.-----.-----.----.
-- |  __|  _  |     ||   _|  _  ||  ||     |  -__|   _|
-- |____|_____|__|__||____|___._||__||__|__|_____|__|

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- A suitable basis for the majority of the interactive widgets available
-- for the user to interact with. A number of files more finely grained
-- to use case adds additional layers of complexity and styling error
-- exposure making the best file one featureful enough for all use cases
-- with a consistent appearance and interaction behaviors in terms of UI effect
-- ########################################################################
-- ########################################################################
-- ########################################################################
local create_click_events = function(widget)
    local container =
        wibox.widget {
        widget,
        widget = wibox.container.background,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 4)
        end,
        bg = beautiful.bg_focus,
        border_width = dpi(2),
        border_color = '#555e7088'
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Old and new widget
    --
    local old_cursor, old_wibox
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Mouse hovers on the widget
    --
    container:connect_signal(
        'mouse::enter',
        function()
            container.bg = beautiful.accent
            -- Hm, no idea how to get the wibox from this signal's arguments...
        end
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Mouse leaves the widget
    --
    container:connect_signal(
        'mouse::leave',
        function()
            container.bg = beautiful.bg_focus
        end
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Mouse pressed the widget
    --
    container:connect_signal(
        'button::press',
        function()
            container.bg = beautiful.accent
        end
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Mouse releases the widget\
    --
    container:connect_signal(
        'button::release',
        function()
            container.bg = beautiful.bg_focus
        end
    )

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    return container
end

return create_click_events
