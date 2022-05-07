--  _______ __ __
-- |    ___|__|  |.-----.
-- |    ___|  |  ||  -__|
-- |___|   |__|__||_____|

--  _______
-- |   |   |.---.-.-----.---.-.-----.-----.----.
-- |       ||  _  |     |  _  |  _  |  -__|   _|
-- |__|_|__||___._|__|__|___._|___  |_____|__|
--                            |_____|
--  ______         __   __
-- |   __ \.--.--.|  |_|  |_.-----.-----.
-- |   __ <|  |  ||   _|   _|  _  |     |
-- |______/|_____||____|____|_____|__|__|
-- ------------------------------------------------- --
local apps = require("config.root.apps")
local widget_icon =
    wibox.widget {
    layout = wibox.layout.align.vertical,
    expand = "none",
    nil,
    {
        id = "icon",
        image = icons.file_manager,
        resize = true,
        widget = wibox.widget.imagebox,
        forced_width = dpi(80),
        forced_height = dpi(80),
        valign = "center",
        align = "center"
    },
    nil
}
-- ------------------------------------------------- --
local widget =
    wibox.widget {
    {
        {
            {
                {
                    widget_icon,
                    layout = wibox.layout.fixed.horizontal
                },
                margins = dpi(10),
                widget = wibox.container.margin
            },
            widget = clickable_container
        },
        margins = dpi(5),
        widget = wibox.container.margin
    },
    shape = beautiful.client_shape_rounded_xl,
    bg = beautiful.bg_focus,
    widget = wibox.container.background
}
-- ------------------------------------------------- --
_G.dnd_status = false
-- ------------------------------------------------- --
widget:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                awful.spawn(apps.default.file_manager)
            end
        )
    )
)

return widget
