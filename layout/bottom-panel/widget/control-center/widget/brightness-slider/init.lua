--  ______        __         __     __
-- |   __ \.----.|__|.-----.|  |--.|  |_.-----.-----.-----.-----.
-- |   __ <|   _||  ||  _  ||     ||   _|     |  -__|__ --|__ --|
-- |______/|__|  |__||___  ||__|__||____|__|__|_____|_____|_____|
--                   |_____|
--  _______ __ __     __
-- |     __|  |__|.--|  |.-----.----.
-- |__     |  |  ||  _  ||  -__|   _|
-- |_______|__|__||_____||_____|__|

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- widget's title in popup
local action_name =
    wibox.widget {
    text = "Brightness",
    font = "SFMono Nerd Font Mono Heavy  10",
    align = "left",
    widget = wibox.widget.textbox
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- icon the widget will be using
local icon =
    wibox.widget {
    layout = wibox.layout.align.vertical,
    expand = "none",
    nil,
    {image = icons.brightness, resize = true, widget = wibox.widget.imagebox},
    nil
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- widget template  making the icon a clickable container button,
-- giving it a shape, etc
local action_level =
    wibox.widget {
    {
        {icon, margins = dpi(5), widget = wibox.container.margin},
        widget = clickable_container
    },
    bg = beautiful.groups_bg,
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, beautiful.groups_radius)
    end,
    widget = wibox.container.background
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Gives the slider its look overall, assign the shapes of its pieces,
-- length and all that jazz
local slider =
    wibox.widget {
    nil,
    {
        id = "brightness_slider",
        bar_shape = gears.shape.rounded_rect,
        bar_height = dpi(24),
        bar_color = "#22262d",
        bar_active_color = "#b2bfd9cc",
        handle_color = "#e9efff",
        handle_shape = gears.shape.circle,
        handle_width = dpi(24),
        handle_border_color = "#000000aa",
        handle_border_width = dpi(2),
        maximum = 100,
        widget = wibox.widget.slider
    },
    nil,
    expand = "none",
    forced_height = dpi(24),
    layout = wibox.layout.align.vertical
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- bringing the slider within the local scope
local brightness_slider = slider.brightness_slider
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- when the slider recieves a connection event (like you clicking the handle)
brightness_slider:connect_signal(
    "property::value",
    function()
        local brightness_level = brightness_slider:get_value()

        spawn("light -S " .. math.max(brightness_level, 5), false)

        -- Update brightness osd
        awesome.emit_signal("module::brightness_osd", brightness_level)
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- buttons or what happens when clicked, assigns increment and decrement
-- values, I like 5 for this
brightness_slider:buttons(
    gears.table.join(
        awful.button(
            {},
            4,
            nil,
            function()
                if brightness_slider:get_value() > 100 then
                    brightness_slider:set_value(100)
                    return
                end
                brightness_slider:set_value(brightness_slider:get_value() + 5)
            end
        ),
        awful.button(
            {},
            5,
            nil,
            function()
                if brightness_slider:get_value() < 0 then
                    brightness_slider:set_value(0)
                    return
                end
                brightness_slider:set_value(brightness_slider:get_value() - 5)
            end
        )
    )
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- update the brightness via the sliders new position whole insuring that value
--  is where the slide renders next.
local update_slider = function()
    awful.spawn.easy_async_with_shell(
        "light -G",
        function(stdout)
            local brightness = string.match(stdout, "(%d+)")
            brightness_slider:set_value(tonumber(brightness))
        end
    )
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Update on startup
update_slider()

-- Assign default position of the slider at startup, I default to 100 here
local action_jump = function()
    local sli_value = brightness_slider:get_value()
    local new_value = 0

    if sli_value >= 0 and sli_value < 50 then
        new_value = 50
    elseif sli_value >= 50 and sli_value < 100 then
        new_value = 100
    else
        new_value = 0
    end
    brightness_slider:set_value(new_value)
end
-- assign the reset a button
action_level:buttons(
    awful.util.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                action_jump()
            end
        )
    )
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- event handling when the emit comes from the global keybind
awesome.connect_signal(
    "widget::brightness",
    function()
        update_slider()
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Event handiing when the emit comes from the on screen display (popup)
awesome.connect_signal(
    "widget::brightness:update",
    function(value)
        brightness_slider:set_value(tonumber(value))
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- button styling
local brightness_setting =
    wibox.widget {
    layout = wibox.layout.fixed.vertical,
    spacing = dpi(5),
    action_name,
    {
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(5),
        {
            layout = wibox.layout.align.vertical,
            expand = "none",
            nil,
            {
                layout = wibox.layout.fixed.horizontal,
                forced_height = dpi(24),
                forced_width = dpi(24),
                action_level
            },
            nil
        },
        slider
    }
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
return brightness_setting
