--  _______            __ __         __
-- |     __|.--.--.--.|__|  |_.----.|  |--.-----.----.
-- |__     ||  |  |  ||  |   _|  __||     |  -__|   _|
-- |_______||________||__|____|____||__|__|_____|__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- This changes between the two panel modes via a click of the mouse
--

local active_button = beautiful.xcolor8 .. '90'
local inactive_button = beautiful.xcolor8 .. '70'
-- ########################################################################
-- ########################################################################
-- ########################################################################
local notif_text =
    wibox.widget {
    text = 'Notifications',
    font = beautiful.font .. ' 12',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local notif_button = clickable_container(wibox.container.margin(notif_text, dpi(0), dpi(0), dpi(7), dpi(7)))
-- ########################################################################
-- ########################################################################
-- ########################################################################
local wrap_notif =
    wibox.widget {
    notif_button,
    forced_width = dpi(180),
    bg = active_button,
    shape = beautiful.widget_shape,
    widget = wibox.container.background
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local widgets_text =
    wibox.widget {
    text = 'Widgets',
    font = beautiful.font .. ' 12',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local widgets_button = clickable_container(wibox.container.margin(widgets_text, dpi(0), dpi(0), dpi(7), dpi(7)))
-- ########################################################################
-- ########################################################################
-- ########################################################################
local wrap_widget =
    wibox.widget {
    widgets_button,
    forced_width = dpi(180),
    bg = inactive_button,
    shape = beautiful.widget_shape,
    widget = wibox.container.background
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local switcher =
    wibox.widget {
    expand = 'none',
    layout = wibox.layout.fixed.horizontal,
    {
        wrap_notif,
        layout = wibox.layout.fixed.horizontal
    },
    {
        wrap_widget,
        layout = wibox.layout.fixed.horizontal
    }
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function switch_mode(right_panel_mode)
    if right_panel_mode == 'notif_mode' then
        -- Update button color
        wrap_notif.bg = active_button
        wrap_widget.bg = inactive_button
        -- Change panel content of right-panel.lua
        _G.screen.primary.right_panel:switch_mode(right_panel_mode)
    elseif right_panel_mode == 'widgets_mode' then
        -- Update button color
        wrap_notif.bg = inactive_button
        wrap_widget.bg = active_button
        -- Change panel content of right-panel.lua
        _G.screen.primary.right_panel:switch_mode(right_panel_mode)
    end
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
notif_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                switch_mode('notif_mode')
            end
        )
    )
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
widgets_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                switch_mode('widgets_mode')
            end
        )
    )
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
return switcher
