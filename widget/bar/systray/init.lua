--  _______
-- |_     _|.----.---.-.--.--.
--   |   |  |   _|  _  |  |  |
--   |___|  |__| |___._|___  |
--                     |_____|
--  _______                     __
-- |_     _|.-----.-----.-----.|  |.-----.
--   |   |  |  _  |  _  |  _  ||  ||  -__|
--   |___|  |_____|___  |___  ||__||_____|
--                |_____|_____|
-- ------------------------------------------------- --
-- Define the widget
--
local widget =
    wibox.widget {
    {
        id = 'icon',
        image = icons.left_arrow,
        widget = wibox.widget.imagebox,
        resize = true
    },
    layout = wibox.layout.align.horizontal
}
-- ------------------------------------------------- --
-- Define the widget button
local widget_button =
    wibox.widget {
    {
        {
            widget,
            margins = dpi(6),
            widget = wibox.container.margin
        },
        widget = clickable_container
    },
    margins = dpi(4),
    widget = wibox.container.margin
}
-- ------------------------------------------------- --
systray = wibox.widget.systray()

-- ------------------------------------------------- --
widget_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                awesome.emit_signal('widget::systray:toggle')
            end
        )
    )
)
-- ------------------------------------------------- --

-- Listen to signal
--
awesome.connect_signal(
    'widget::systray:toggle',
    function()
        if screen.primary.systray then
            if not screen.primary.systray.visible then
                widget.icon:set_image(gears.surface.load_uncached(icons.left_arrow))
                screen.primary.systray.visible = true
            else
                widget.icon:set_image(gears.surface.load_uncached(icons.right_arrow))
                screen.primary.systray.visible = false
            end

            screen.primary.systray.visible = not screen.primary.systray.visible
        end
    end
)
-- ------------------------------------------------- --
-- Update icon on start-up
--
if screen.primary.systray then
    if screen.primary.systray.visible then
        widget.icon:set_image(icons.right_arrow)
    end
end
-- ------------------------------------------------- --
-- Show only the tray button in the primary screen
return awful.widget.only_on_screen(widget_button, 'primary')
