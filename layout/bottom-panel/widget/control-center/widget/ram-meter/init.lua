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
    text = 'RAM',
    font = 'SFMono Nerd Font Mono Heavy  10',
    align = 'left',
    widget = wibox.widget.textbox
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local icon =
    wibox.widget {
    layout = wibox.layout.align.vertical,
    expand = 'none',
    nil,
    {
        image = icons.memory,
        resize = true,
        widget = wibox.widget.imagebox
    },
    nil
}

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
        id = 'ram_usage',
        max_value = 100,
        value = 29,
        forced_height = dpi(48),
        color = '#f4f4f7ee',
        background_color = '#22262d',
        shape = gears.shape.rounded_rect,
        widget = wibox.widget.progressbar
    },
    nil,
    expand = 'none',
    forced_height = dpi(36),
    layout = wibox.layout.align.vertical
}

local ram_tooltip =
    awful.tooltip {
    objects = {meter_icon},
    text = 'None',
    mode = 'outside',
    align = 'right',
    margin_leftright = dpi(8),
    margin_topbottom = dpi(8),
    preferred_positions = {'right', 'left', 'top', 'bottom'}
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
watch(
    'bash -c "free | grep -z Mem.*Swap.*"',
    15,
    function(_, stdout)
        local total,
            used,
            free,
            shared,
            buff_cache,
            available,
            total_swap,
            used_swap,
            free_swap = stdout:match('(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*Swap:%s*(%d+)%s*(%d+)%s*(%d+)')
        slider.ram_usage:set_value(used / total * 100)
        local tip = (used / total * 100)
        tip = string.sub(tip, 1, 2)
        ram_tooltip:set_text('RAM Utilization: ' .. tip .. '%')
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
            expand = 'none',
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
return ram_meter
