--  _____         __
-- |     \.---.-.|  |_.-----.
-- |  --  |  _  ||   _|  -__|
-- |_____/|___._||____|_____|
-- ------------------------------------------------- --
-- -------------------- objects -------------------- --
--
local date_day =
    wibox.widget {
    font = beautiful.font .. ' 42',
    format = '%d',
    valign = 'center',
    halign = 'center',
    widget = wibox.widget.textclock
}
-- ------------------------------------------------- --
local date_month =
    wibox.widget {
    font = beautiful.font .. ' 38',
    format = '%B',
    valign = 'center',
    halign = 'center',
    widget = wibox.widget.textclock
}
-- ------------------------------------------------- --
local date =
    wibox.widget {
    {
        date_month,
        date_day,
        expand = 'none',
        widget = wibox.layout.fixed.horizontal
    },
    widget = wibox.container.background
}

return date
