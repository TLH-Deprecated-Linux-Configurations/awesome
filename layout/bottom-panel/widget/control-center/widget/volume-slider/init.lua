--  ___ ___         __
-- |   |   |.-----.|  |.--.--.--------.-----.
-- |   |   ||  _  ||  ||  |  |        |  -__|
--  \_____/ |_____||__||_____|__|__|__|_____|

--  _______         __
-- |   |   |.-----.|  |_.-----.----.
-- |       ||  -__||   _|  -__|   _|
-- |__|_|__||_____||____|_____|__|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local meter_name =
    wibox.widget {
    text = "Volume",
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
        image = icons.volume,
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
    bg = beautiful.bg_button,
    shape = beautiful.client_shape_rounded,
    widget = clickable_container
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local slider =
    wibox.widget {
    nil,
    {
        id = "volume_usage",
        max_value = 100,
        value = 0,
        forced_height = dpi(36),
        color = "#f4f4f7ee",
        background_color = "#22262d",
        shape = gears.shape.rounded_rect,
        widget = wibox.widget.progressbar
    },
    nil,
    expand = "none",
    forced_height = dpi(36),
    layout = wibox.layout.align.vertical
}
local volume_tooltip =
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
    "signal::volume",
    function(value)
        -- Use this if you want to display usage percentage
        slider.volume_usage:set_value(value)
        volume_tooltip:set_text("Volume Level is Currently: " .. value .. "%")
    end
)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local volume_meter =
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
                forced_height = dpi(36),
                forced_width = dpi(36),
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
return volume_meter
