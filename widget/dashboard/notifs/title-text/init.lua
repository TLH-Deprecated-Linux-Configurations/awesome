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
    text = 'Notifications',
    font = 'Nineteen Ninety Seven Bold 10',
    widget = wibox.widget.textbox
}
-- ------------------------------------------------- --
local icon = wibox.widget.imagebox(icons.logo)
-- ------------------------------------------------- --
local widget_user =
    wibox.widget {
    layout = wibox.layout.align.vertical,
    expand = 'none',
    nil,
    {
        user_content,
        layout = wibox.layout.align.horizontal
    },
    nil
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
        icon,
        spacer_bar,
        widget_user,
        spacer_bar,
        layout = wibox.layout.fixed.horizontal
    },
    fg = beautiful.fg_normal,
    widget = wibox.container.background
}
-- ------------------------------------------------- --w
return widget
