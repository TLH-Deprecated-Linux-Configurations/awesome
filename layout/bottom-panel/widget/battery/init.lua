--  ______         __   __
-- |   __ \.---.-.|  |_|  |_.-----.----.--.--.
-- |   __ <|  _  ||   _|   _|  -__|   _|  |  |
-- |______/|___._||____|____|_____|__| |___  |
--                                     |_____|
--  ______
-- |   __ \.---.-.----.
-- |   __ <|  _  |   _|
-- |______/|___._|__|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- the text displayed
local battery_text =
    wibox.widget {
    font = beautiful.font,
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- create the icon portion of the text, which uses a nerd font to display the icon
local battery_icon =
    wibox.widget {
    font = "SFMono Nerd Font Mono 24",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- create the button itself
local battery_pill =
    wibox.widget {
    widget = clickable_container {
        {
            {battery_icon, margins = dpi(7), widget = wibox.container.margin},
            {battery_text, margins = dpi(1), widget = wibox.container.margin},
            layout = wibox.layout.fixed.horizontal
        },
        left = dpi(10),
        right = dpi(10),
        widget = wibox.container.margin
    }
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
--  respond to the signal changing
awesome.connect_signal(
    "signal::battery",
    function(percentage, state)
        local value = percentage
        -- ------------------------------------------------- --
        -- ------------------------------------------------- --
        -- ------------------------------------------------- --
        -- default output
        local bat_icon = ""
        -- ------------------------------------------------- --
        -- ------------------------------------------------- --
        -- ------------------------------------------------- --
        --charge dependent output
        if value >= 90 and value <= 100 then
            bat_icon = ""
        elseif value >= 70 and value < 90 then
            bat_icon = ""
        elseif value >= 60 and value < 70 then
            bat_icon = ""
        elseif value >= 50 and value < 60 then
            bat_icon = ""
        elseif value >= 30 and value < 50 then
            bat_icon = ""
        elseif value >= 15 and value < 30 then
            bat_icon = ""
        else
            bat_icon = ""
        end
        -- ------------------------------------------------- --
        -- ------------------------------------------------- --
        -- ------------------------------------------------- --
        -- if charging
        --
        if state == 1 then
            bat_icon = ""
        end
        -- ------------------------------------------------- --
        -- ------------------------------------------------- --
        -- ------------------------------------------------- --
        -- if full
        --
        if state == 4 then
            bat_icon = ""
        end
        -- ------------------------------------------------- --
        -- ------------------------------------------------- --
        -- ------------------------------------------------- --
        -- color the icon output
        battery_icon.markup = "<span foreground='#f4f4f7'>" .. bat_icon .. "</span>"
        battery_text.markup = "<span foreground='#f4f4f7'>" .. string.format("%1d", value) .. "%" .. "</span>"
    end
)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- mouse click command handler
battery_pill:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                awful.spawn(apps.default.power_manager, false)
            end
        )
    )
)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- function to draw output of command on when the next function is called
local battery_tooltip =
    awful.tooltip {
    objects = {battery_pill},
    text = "None",
    mode = "outside",
    align = "right",
    margin_leftright = dpi(8),
    margin_topbottom = dpi(8),
    preferred_positions = {"right", "left", "top", "bottom"}
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- function to check battery information when the button is hovered
local get_battery_info = function()
    awful.spawn.easy_async_with_shell(
        "upower -i $(upower -e | grep BAT)",
        function(stdout)
            if stdout == nil or stdout == "" then
                battery_tooltip:set_text("No battery detected!")
                return
            end

            -- Remove new line from the last line
            battery_tooltip:set_text(stdout:sub(1, -2))
        end
    )
end
get_battery_info()

-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- signal that is activated by hovering over the button
battery_pill:connect_signal(
    "mouse::enter",
    function()
        get_battery_info()
    end
)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- the return statement makes these functions available to the overall configuration and in this case, nested in the button drawn on the wibar
return battery_pill
