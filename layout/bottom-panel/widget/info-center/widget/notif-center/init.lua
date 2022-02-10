--  _______         __   __   ___ __              __   __
-- |    |  |.-----.|  |_|__|.'  _|__|.----.---.-.|  |_|__|.-----.-----.
-- |       ||  _  ||   _|  ||   _|  ||  __|  _  ||   _|  ||  _  |     |
-- |__|____||_____||____|__||__| |__||____|___._||____|__||_____|__|__|
--  ______               __
-- |      |.-----.-----.|  |_.-----.----.
-- |   ---||  -__|     ||   _|  -__|   _|
-- |______||_____|__|__||____|_____|__|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Contains the content of the 'info-center', abstracted from it for ease of
-- reading purposes, this way I can abstract away the logic of the button of
--  the 'info-center' and the content thereof (which is this file)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Popup Header
--
local notif_header =
    wibox.widget {
    text = 'Notification Center',
    font = 'Nineteen Ninety Seven Regular  14',
    align = 'left',
    valign = 'center',
    widget = wibox.widget.textbox
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Declare widget's variables
--
local notif_center = function(s)
    -- Create clear-all button
    --
    s.clear_all = require('layout.bottom-panel.widget.info-center.widget.notif-center.clear-all')
    -- ------------------------------------------------- --
    -- Create the center of the popup
    --
    s.notifbox_layout =
        require('layout.bottom-panel.widget.info-center.widget.notif-center.build-notifbox').notifbox_layout
    -- Widget Template
    --
    return wibox.widget {
        {
            {
                expand = 'none',
                layout = wibox.layout.fixed.vertical,
                spacing = dpi(10),
                {
                    layout = wibox.layout.align.horizontal,
                    expand = 'none',
                    notif_header,
                    nil,
                    s.clear_all
                },
                s.notifbox_layout
            },
            margins = dpi(10),
            widget = wibox.container.margin
        },
        bg = beautiful.groups_bg,
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, beautiful.groups_radius)
        end,
        widget = wibox.container.background
    }
end
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- return statement
return notif_center
