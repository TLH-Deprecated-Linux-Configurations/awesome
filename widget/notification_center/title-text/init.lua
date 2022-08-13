--  _______ __ __   __
-- |_     _|__|  |_|  |.-----.
--   |   | |  |   _|  ||  -__|
--   |___| |__|____|__||_____|
--  _______               __
-- |_     _|.-----.--.--.|  |_
--   |   |  |  -__|_   _||   _|
--   |___|  |_____|__.__||____|
-- ------------------------------------------------- --
local user_content =
    wibox.widget {
    text = ' Notifications',
    font = beautiful.font .. ' 25',
    widget = wibox.widget.textbox
}

-- ------------------------------------------------- --
local spacer_bar =
    wibox.widget {
    {
        orientation = 'vertical',
        forced_height = dpi(1),
        forced_width = dpi(2),
        shape = gears.shape.rounded_bar,
        widget = wibox.widget.separator
    },
    margins = dpi(10),
    widget = wibox.container.margin
}
------------------------------------ --

local widget =
    wibox.widget {
    {
        user_content,
        layout = wibox.layout.flex.horizontal
    },
    fg = beautiful.fg_normal,
    bg = beautiful.normal,
    widget = wibox.container.background
}
-- ------------------------------------------------- --w
return widget
