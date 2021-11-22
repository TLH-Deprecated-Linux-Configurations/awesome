--  _______            __ __         __
-- |     __|.--.--.--.|__|  |_.----.|  |--.-----.----.
-- |__     ||  |  |  ||  |   _|  __||     |  -__|   _|
-- |_______||________||__|____|____||__|__|_____|__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- This changes between the two panel modes via a click of the mouse
--

local notif_text =
    wibox.widget {
    text = "Notifications",
    font = beautiful.font .. " 11",
    align = "center",
    valign = "center",
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
    shape = beautiful.widget_shape,
    widget = clickable_container
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local widgets_text =
    wibox.widget {
    text = "Widgets",
    font = beautiful.font .. " 12",
    align = "center",
    valign = "center",
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
    shape = beautiful.widget_shape,
    widget = clickable_container
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local switcher =
    wibox.widget {
    expand = "none",
    layout = wibox.layout.fixed.horizontal,
    {
        wrap_notif,
        layout = wibox.layout.fixed.horizontal,
        bg = "linear:0,0:0,21:0,#3c3f4c:1,#17191e"
    },
    {
        wrap_widget,
        layout = wibox.layout.fixed.horizontal,
        bg = "linear:0,0:0,21:0,#3c3f4c:1,#17191e"
    }
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function switch_mode(right_panel_mode)
    if right_panel_mode == "notif_mode" then
        -- Update button color
        wrap_notif.bg = "linear:0,0:0,21:0,#3c3f4c:1,#17191e"
        wrap_widget.bg = "linear:0,0:0,21:0,#636a82:1,#3c3f4c"
        -- Change panel content of right-panel.lua
        _G.screen.primary.right_panel:switch_mode(right_panel_mode)
    elseif right_panel_mode == "widgets_mode" then
        -- Update button color
        wrap_notif.bg = "linear:0,0:0,21:0,#636a82:1,#3c3f4c"
        wrap_widget.bg = "linear:0,0:0,21:0,#3c3f4c:1,#17191e"
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
                switch_mode("notif_mode")
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
                switch_mode("widgets_mode")
            end
        )
    )
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
return switcher
