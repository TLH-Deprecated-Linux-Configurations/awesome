--  _______                         __
-- |     __|.-----.---.-.----.----.|  |--.
-- |__     ||  -__|  _  |   _|  __||     |
-- |_______||_____|___._|__| |____||__|__|
--  _______
-- |   _   |.-----.-----.
-- |       ||  _  |  _  |
-- |___|___||   __|   __|
--          |__|  |__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Provides a button to access the menu, either the list view menu or the
-- applications HUD
-- ########################################################################
-- ########################################################################
-- ########################################################################
local return_button = function()
    local widget =
        wibox.widget {
        {
            id = 'icon',
            image = icons.electric_tantra_linux,
            widget = wibox.widget.imagebox,
            resize = true,
            bg = beautiful.groups_bg
        },
        layout = wibox.layout.align.horizontal
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local widget_button =
        wibox.widget {
        {
            widget,
            margins = dpi(2),
            widget = wibox.container.margin
        },
        widget = clickable_container
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    widget_button:buttons(
        gears.table.join(
            awful.button(
                {},
                3,
                nil,
                function()
                    awful.spawn(apps.default.rofi_appmenu)
                end
            ),
            awful.button(
                {},
                1,
                function()
                    if mymainmenu then
                        mymainmenu:toggle()
                    end
                end
            )
        )
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    return widget_button
end

return return_button
