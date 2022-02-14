--  ______ ______ _______
-- |      |   __ \   |   |
-- |   ---|    __/   |   |
-- |______|___|  |_______|
--  _______         __
-- |   |   |.-----.|  |_.-----.----.
-- |       ||  -__||   _|  -__|   _|
-- |__|_|__||_____||____|_____|__|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local meter_name =
    wibox.widget {
    text = "Brightness",
    font = "Nineteen Ninety Seven Regular  10",
    align = "left",
    widget = wibox.widget.textbox
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local icon =
    wibox.widget {
    layout = wibox.layout.align.vertical,
    expand = "none",
    nil,
    {
        image = icons.brightness,
        resize = true,
        widget = wibox.widget.imagebox
    },
    nil
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local meter_icon =
    wibox.widget {
    {
        icon,
        margins = dpi(5),
        widget = wibox.container.margin
    },
    bg = beautiful.groups_bg,
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, beautiful.groups_radius)
    end,
    widget = wibox.container.background
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local slider =
    wibox.widget {
    nil,
    {
        id = "brightness_usage",
        max_value = 100,
        value = 0,
        forced_height = dpi(48),
        color = "#f4f4f7ee",
        background_color = "#22262d",
        shape = gears.shape.rounded_rect,
        widget = wibox.widget.progressbar
    },
    nil,
    expand = "none",
    forced_height = dpi(48),
    layout = wibox.layout.align.vertical
}
local brightness_tooltip =
    awful.tooltip {
    objects = {meter_icon},
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

awesome.connect_signal(
    "signal::brightness",
    function(value)
        -- Use this if you want to display usage percentage
        slider.brightness_usage:set_value(value)
        brightness_tooltip:set_text("Brightness Level is Currently: " .. value .. "%")
    end
)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local brightness_meter =
    wibox.widget {
    layout = wibox.layout.fixed.vertical,
    spacing = dpi(5),
    meter_name,
    {
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(5),
        {
            layout = wibox.layout.align.vertical,
            expand = "none",
            nil,
            {
                layout = wibox.layout.fixed.horizontal,
                forced_height = dpi(48),
                forced_width = dpi(48),
                meter_icon
            },
            nil
        },
        slider
    }
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
return brightness_meter
