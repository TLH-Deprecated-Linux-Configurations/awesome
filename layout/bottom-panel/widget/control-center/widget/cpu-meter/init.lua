--  ______ ______ _______
-- |      |   __ \   |   |
-- |   ---|    __/   |   |
-- |______|___|  |_______|
--  _______         __
-- |   |   |.-----.|  |_.-----.----.
-- |       ||  -__||   _|  -__|   _|
-- |__|_|__||_____||____|_____|__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local meter_name =
    wibox.widget {
    text = 'CPU',
    font = 'SFMono Nerd Font Mono Heavy  10',
    align = 'left',
    widget = wibox.widget.textbox
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local icon =
    wibox.widget {
    layout = wibox.layout.align.vertical,
    expand = 'none',
    nil,
    {
        image = icons.chart,
        resize = true,
        widget = wibox.widget.imagebox
    },
    nil
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
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
-- ########################################################################
-- ########################################################################
-- ########################################################################
local slider =
    wibox.widget {
    nil,
    {
        id = 'cpu_usage',
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
    forced_height = dpi(48),
    layout = wibox.layout.align.vertical
}
local cpu_tooltip =
    awful.tooltip {
    objects = {meter_icon},
    text = 'None',
    mode = 'outside',
    align = 'right',
    margin_leftright = dpi(8),
    margin_topbottom = dpi(8),
    preferred_positions = {'right', 'left', 'top', 'bottom'}
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local total_prev = 0
local idle_prev = 0
-- ########################################################################
-- ########################################################################
-- ########################################################################
watch(
    [[bash -c "
	cat /proc/stat | grep '^cpu '
	"]],
    15,
    function(_, stdout)
        local user, nice, system, idle, iowait, irq, softirq, steal, guest, guest_nice =
            stdout:match('(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s')

        local total = user + nice + system + idle + iowait + irq + softirq + steal

        local diff_idle = idle - idle_prev
        local diff_total = total - total_prev
        local diff_usage = (1000 * (diff_total - diff_idle) / diff_total + 5) / 10

        slider.cpu_usage:set_value(diff_usage)
        local tip = string.sub(diff_usage, 1, 2)
        cpu_tooltip:set_text('CPU Utilization: ' .. tip .. '%')
        total_prev = total
        idle_prev = idle
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local cpu_meter =
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
-- ########################################################################
-- ########################################################################
-- ########################################################################
return cpu_meter
