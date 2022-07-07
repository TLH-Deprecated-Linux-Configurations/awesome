--- Microphone Widget
--- ~~~~~~~~~~~~~~~~~

local function button(icon)
	return clickable_container(
		{
			forced_width = dpi(60),
			forced_height = dpi(60),
			shape = gears.shape.circle,
			{
				{
					widget = wibox.widget.imagebox,
					image = icons.icon
				},
				widget = wibox.container.margin,
				margins = dpi(6)
			}
		}
	)
end
local widget = button('mic')

widget:buttons(
	gears.table.join(
		awful.button(
			{},
			1,
			nil,
			function()
				awful.spawn.with_shell('pamixer --default-source -t')
			end
		)
	)
)

watch(
	'pamixer --default-source --get-mute',
	5,
	function(_, stdout)
		if stdout:match('true') then
			widget:turn_off()
		else
			widget:turn_on()
		end
		collectgarbage('collect')
	end,
	widget
)

return widget
