--  _______                                         __
-- |_     _|.-----.--------.-----.-----.----.---.-.|  |_.--.--.----.-----.
--   |   |  |  -__|        |  _  |  -__|   _|  _  ||   _|  |  |   _|  -__|
--   |___|  |_____|__|__|__|   __|_____|__| |___._||____|_____|__| |_____|
--                         |__|
-- ########################################################################
-- ########################################################################
-- ########################################################################

local watch = awful.widget.watch
local dpi = beautiful.xresources.apply_dpi
-- ########################################################################
-- ########################################################################
-- ########################################################################
local meter_name =
    wibox.widget {
    text = 'Temperature',
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
        image = icons.thermometer,
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
        id = 'temp_status',
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
-- ########################################################################
-- ########################################################################
-- ########################################################################
local temp_tooltip =
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
-- Call the function to monitor the temperature
local max_temp = 80

awful.spawn.easy_async_with_shell(
    [[
	temp_path=null
	for i in /sys/class/hwmon/hwmon*/temp*_input;
	do
		temp_path="$(echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null ||
			echo $(basename ${i%_*})) $(readlink -f $i)");"

		label="$(echo $temp_path | awk '{print $2}')"

		if [ "$label" = "Package" ];
		then
			echo ${temp_path} | awk '{print $5}' | tr -d ';\n'
			exit;
		fi
	done
	]],
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Format the output
    function(stdout)
        local temp_path = stdout:gsub('%\n', '')
        if temp_path == '' or not temp_path then
            temp_path = '/sys/class/thermal/thermal_zone0/temp'
        end

        watch(
            [[
			sh -c "cat ]] .. temp_path .. [["
			]],
            15,
            function(_, stdout)
                local temp = 0
                temp = temp + stdout:match('(%d+)')
                slider.temp_status:set_value((temp / 1000) / max_temp * 100)
                local tip = (temp / 1000) / max_temp * 100
                tip = string.sub(tip, 1, 2)
                temp_tooltip:set_text('Internal Temperature is ' .. tip .. '* Degrees Celsius')
            end
        )
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
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
return temp_meter
