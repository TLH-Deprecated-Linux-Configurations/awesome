--  ______
-- |   __ \.---.-.--------.
-- |      <|  _  |        |
-- |___|__||___._|__|__|__|
--  _______         __
-- |   |   |.-----.|  |_.-----.----.
-- |       ||  -__||   _|  -__|   _|
-- |__|_|__||_____||____|_____|__|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local meter_name =
    wibox.widget {
    text = "RAM",
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
        image = icons.memory,
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
        id = "ram_usage",
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
-- provide the tooltip percentage number
local ram_tooltip =
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
local ram_script = [[
  sh -c "
  free -m | grep 'Mem:' | awk '{printf \"%d@@%d@\", $7, $2}'
  "]]

-- Ram info
awesome.connect_signal(
    "signal::ram",
    function(used, total)
        local used_ram_percentage = (used / total) * 100
        slider.value = used_ram_percentage
        -- TODO set this to chop off extraneous decimel place numbers and round up to 2 places after decimel
        ram_tooltip:set_text("RAM Utilization: " .. used_ram_percentage .. "%")
    end
)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local ram_meter =
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
return ram_meter
