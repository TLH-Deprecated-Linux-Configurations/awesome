--  _______               __
-- |     __|.--.--.-----.|  |_.----.---.-.--.--.
-- |__     ||  |  |__ --||   _|   _|  _  |  |  |
-- |_______||___  |_____||____|__| |___._|___  |
--          |_____|                      |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- the systray has its own internal background because of X11 limitations
beautiful.bg_systray = beautiful.xcolor0 .. '00'
beautiful.systray_icon_spacing = dpi(25)
beautiful.systray_icon_size = dpi(84)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local systray_card = card('System Tray')
local my_round_systray =
    wibox.widget {
    {
        wibox.widget.systray(s),
        left = 0,
        top = 0,
        bottom = 0,
        right = 0,
        widget = wibox.container.margin
    },
    bg = beautiful.xbackground .. '00',
    shape = gears.shape.rounded_rect,
    --shape_clip = true,
    widget = wibox.container.background
    --visible = false
}
systray_card.update_body(my_round_systray)
return wibox.container.margin(systray_card, dpi(20), dpi(20), dpi(20), dpi(20))
