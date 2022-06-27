--  _______                         __
-- |     __|.-----.---.-.----.----.|  |--.
-- |__     ||  -__|  _  |   _|  __||     |
-- |_______||_____|___._|__| |____||__|__|
--  ______         __   __
-- |   __ \.--.--.|  |_|  |_.-----.-----.
-- |   __ <|  |  ||   _|   _|  _  |     |
-- |______/|_____||____|____|_____|__|__|
-- ------------------------------------------------- --

local widget_icon =
    wibox.widget(
    {
        layout = wibox.layout.align.vertical,
        expand = 'none',
        nil,
        {
            id = 'icon',
            image = icons.search,
            resize = true,
            widget = wibox.widget.imagebox
        },
        nil
    }
)

local widget =
    wibox.widget(
    {
        {
            {
                {widget_icon, layout = wibox.layout.fixed.horizontal},
                margins = dpi(15),
                widget = wibox.container.margin
            },
            forced_height = dpi(50),
            widget = clickable_container
        },
        shape = beautiful.client_shape_rounded_small,
        bg = colors.colorA,
        widget = wibox.container.background
    }
)

widget:connect_signal(
    'mouse::enter',
    function()
        widget.bg = colors.color4
    end
)

widget:connect_signal(
    'mouse::leave',
    function()
        widget.bg = colors.colorA
    end
)
scan = nil
widget:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            -- ------------------------------------------------- --
            --
            function(scan)
                if scan == nil or scan == false then
                    awful.spawn("echo -e 'scan on' | bluetoothctl")
                    scan = true
                else
                    awful.spawn("echo -e 'scan off' | bluetoothctl")
                    scan = false
                end
            end
        )
    )
)

return widget
