--  _______                                         __
-- |_     _|.-----.--------.-----.-----.----.---.-.|  |_.--.--.----.-----.
--   |   |  |  -__|        |  _  |  -__|   _|  _  ||   _|  |  |   _|  -__|
--   |___|  |_____|__|__|__|   __|_____|__| |___._||____|_____|__| |_____|
--                         |__|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --

local watch = awful.widget.watch
local dpi = beautiful.xresources.apply_dpi
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local meter_name =
    wibox.widget {
    text = "Temperature",
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
        image = icons.thermometer,
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
        id = "temp_status",
        max_value = 100,
        value = 29,
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
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local temp_tooltip =
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
-- Call the function to monitor the temperature

awesome.connect_signal(
    "signal::temp",
    function(temp)
        slider.value = temp
        temp_tooltip:set_text("Internal Temperature is " .. temp .. "* Degrees Celsius")
    end
)

-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- The meter displayed on screen
local temp_meter =
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
return temp_meter
