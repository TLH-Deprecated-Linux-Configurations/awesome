--  _____               __
-- |     \.-----.--.--.|__|.----.-----.-----.
-- |  --  |  -__|  |  ||  ||  __|  -__|__ --|
-- |_____/|_____|\___/ |__||____|_____|_____|
--  _______               __
-- |_     _|.-----.--.--.|  |_
--   |   |  |  -__|_   _||   _|
--   |___|  |_____|__.__||____|
-- ------------------------------------------------- --
local devices_text =
    wibox.widget {
    text = 'Devices',
    font = beautiful.font .. ' 16',
    widget = wibox.widget.textbox
}

local devicesIcon =
    wibox.widget {
    layout = wibox.layout.align.vertical,
    expand = 'none',
    nil,
    {
        id = 'icon',
        image = icons.devices,
        resize = true,
        widget = wibox.widget.imagebox
    },
    nil
}

local devices =
    wibox.widget {
    {
        {
            devicesIcon,
            layout = wibox.layout.flex.horizontal
        },
        margins = dpi(8),
        widget = wibox.container.margin
    },
    forced_height = dpi(40),
    shape = beautiful.client_shape_rounded_xl,
    widget = wibox.container.background
}

local widget =
    wibox.widget {
    {
        devices,
        devices_text,
        layout = wibox.layout.align.horizontal,
        align = 'center',
        halign = 'center',
        valigin = 'center',
        expand = 'min',
        spacing = dpi(16)
    },
    fg = colors.white,
    widget = wibox.container.background
}

return widget
