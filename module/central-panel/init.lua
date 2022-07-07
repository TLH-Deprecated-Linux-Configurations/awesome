--- AWESOME Central panel
--- ~~~~~~~~~~~~~~~~~~~~~

return function(s)
	s.awesomewm =
		wibox.widget(
		{
			{
				image = icons.awesome,
				resize = true,
				halign = 'center',
				valign = 'center',
				widget = wibox.widget.imagebox
			},
			strategy = 'exact',
			height = dpi(50),
			widget = wibox.container.constraint
		}
	)

	--- Header
	local function header()
		local dashboard_text =
			wibox.widget(
			{
				font = beautiful.font .. 'Black 14',
				text = 'Dashboard',
				valign = 'center',
				widget = wibox.widget.textbox
			}
		)

		local function search_box()
			local search_icon =
				wibox.widget(
				{
					font = 'icomoon bold 12',
					align = 'center',
					valign = 'center',
					text = '',
					widget = wibox.widget.textbox()
				}
			)

			local reset_search_icon = function()
				search_icon.markup = "<span font='icomoon 12' foreground='" .. colors.white .. "'>" .. search_icon .. '</span> '
			end
			reset_search_icon()

			local search_text =
				wibox.widget(
				{
					align = 'center',
					valign = 'center',
					font = beautiful.font,
					widget = wibox.widget.textbox()
				}
			)

			local search =
				wibox.widget(
				{
					{
						{
							search_icon,
							{
								search_text,
								bottom = dpi(2),
								widget = wibox.container.margin
							},
							layout = wibox.layout.fixed.horizontal
						},
						left = dpi(15),
						widget = wibox.container.margin
					},
					forced_height = dpi(35),
					forced_width = dpi(420),
					shape = gears.shape.rounded_bar,
					bg = beautiful.widget_bg,
					widget = wibox.container.background()
				}
			)

			local function generate_prompt_icon(icon, color)
				return "<span font='icomoon 12' foreground='" .. color .. "'>" .. icon .. '</span> '
			end

			local function activate_prompt(action)
				search_icon.visible = false
				local prompt
				if action == 'run' then
					prompt = generate_prompt_icon('', beautiful.accent)
				elseif action == 'web_search' then
					prompt = generate_prompt_icon('', beautiful.accent)
				end
				prompt(
					action,
					search_text,
					prompt,
					function()
						search_icon.visible = true
					end
				)
			end

			search:buttons(
				gears.table.join(
					awful.button(
						{},
						1,
						function()
							activate_prompt('run')
						end
					),
					awful.button(
						{},
						3,
						function()
							activate_prompt('web_search')
						end
					)
				)
			)

			return search
		end

		local widget =
			wibox.widget(
			{
				{
					dashboard_text,
					nil,
					search_box(),
					layout = wibox.layout.align.horizontal
				},
				margins = dpi(10),
				widget = wibox.container.margin
			}
		)

		return widget
	end

	--- Widgets
	s.stats = require('module.central-panel.stats')
	s.user_profile = require('module.central-panel.user-profile')
	s.quick_settings = require('module.central-panel.quick-settings')
	s.slider = require('module.central-panel.slider')
	s.music_player = require('module.central-panel.music-player')

	s.central_panel =
		awful.popup(
		{
			type = 'popup',
			screen = awful.screen.primary,
			minimum_height = dpi(700),
			maximum_height = dpi(700),
			minimum_width = dpi(700),
			maximum_width = dpi(700),
			bg = beautiful.transparent,
			ontop = true,
			visible = false,
			placement = awful.placement.top(
				{
					margins = {bottom = dpi(5), top = beautiful.wibar_height - dpi(5), left = dpi(5), right = dpi(5)}
				}
			),
			widget = {
				{
					{
						{
							s.awesomewm,
							halign = 'center',
							valign = 'center',
							widget = wibox.container.place
						},
						margins = dpi(20),
						widget = wibox.container.margin
					},
					{
						{
							{
								header(),
								nil,
								{
									{
										s.user_profile,
										s.quick_settings,
										s.slider,
										layout = wibox.layout.fixed.vertical
									},
									{
										s.stats,
										s.music_player,
										layout = wibox.layout.fixed.vertical
									},
									layout = wibox.layout.align.horizontal
								},
								layout = wibox.layout.align.vertical
							},
							margins = dpi(10),
							widget = wibox.container.margin
						},
						shape = beautiful.client_shape_rounded_xl,
						bg = beautiful.wibar_bg,
						widget = wibox.container.background
					},
					layout = wibox.layout.align.vertical
				},
				bg = beautiful.widget_bg,
				shape = beautiful.client_shape_rounded_xl,
				widget = wibox.container.background
			}
		}
	)
	-- ------------------------------------------------- --
	--- Toggle container visibility
	awesome.connect_signal(
		'central_panel::toggle',
		function()
			s.central_panel.visible = not s.central_panel.visible
		end
	)
end
