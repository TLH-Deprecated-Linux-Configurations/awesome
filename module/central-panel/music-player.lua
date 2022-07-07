local playerctl_daemon = require('signal.playerctl')
local playerctl = require('widget.playerctl')
---- Music Player
---- ~~~~~~~~~~~~

local music_text =
	wibox.widget(
	{
		font = beautiful.font .. 'Medium 10',
		valign = 'center',
		widget = wibox.widget.textbox
	}
)

local music_art =
	wibox.widget(
	{
		image = beautiful.music,
		resize = true,
		widget = wibox.widget.imagebox
	}
)

local music_art_container =
	wibox.widget(
	{
		music_art,
		forced_height = dpi(120),
		forced_width = dpi(120),
		widget = wibox.container.background
	}
)

local filter_color = {
	type = 'linear',
	from = {0, 0},
	to = {0, 120},
	stops = {{0, beautiful.widget_bg .. 'cc'}, {1, beautiful.widget_bg}}
}

local music_art_filter =
	wibox.widget(
	{
		{
			bg = filter_color,
			forced_height = dpi(120),
			forced_width = dpi(120),
			widget = wibox.container.background
		},
		direction = 'east',
		widget = wibox.container.rotate
	}
)

local music_title =
	wibox.widget(
	{
		font = beautiful.font .. 'Regular 13',
		valign = 'center',
		widget = wibox.widget.textbox
	}
)

local music_artist =
	wibox.widget(
	{
		font = beautiful.font .. 'Bold 16',
		valign = 'center',
		widget = wibox.widget.textbox
	}
)

local music =
	wibox.widget(
	{
		{
			{
				{
					music_art_container,
					music_art_filter,
					layout = wibox.layout.stack
				},
				{
					{
						{
							music_text,
							ui.vertical_pad(dpi(15)),
							{
								{
									widget = wibox.container.scroll.horizontal,
									step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
									fps = 60,
									speed = 75,
									music_artist
								},
								{
									widget = wibox.container.scroll.horizontal,
									step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
									fps = 60,
									speed = 75,
									music_title
								},
								forced_width = dpi(170),
								layout = wibox.layout.fixed.vertical
							},
							layout = wibox.layout.fixed.vertical
						},
						nil,
						{
							{
								playerctl.previous(20, beautiful.xforeground, beautiful.transparent),
								playerctl.play(beautiful.accent, beautiful.transparent),
								playerctl.next(20, beautiful.xforeground, beautiful.transparent),
								layout = wibox.layout.flex.horizontal
							},
							forced_height = dpi(70),
							margins = dpi(10),
							widget = wibox.container.margin
						},
						expand = 'none',
						layout = wibox.layout.align.vertical
					},
					top = dpi(9),
					bottom = dpi(9),
					left = dpi(10),
					right = dpi(10),
					widget = wibox.container.margin
				},
				layout = wibox.layout.stack
			},
			bg = beautiful.widget_bg,
			shape = beautiful.client_shape_rounded_xl,
			forced_width = dpi(200),
			forced_height = dpi(200),
			widget = wibox.container.background
		},
		margins = dpi(10),
		color = colors.black,
		widget = wibox.container.margin
	}
)

--- playerctl
--- -------------
playerctl_daemon:connect_signal(
	'metadata',
	function(_, title, artist, album_path, __, ___, ____)
		if title == '' then
			title = 'Nothing Playing'
		end
		if artist == '' then
			artist = 'Nothing Playing'
		end
		if album_path == '' then
			album_path = gears.filesystem.get_configuration_dir() .. 'theme/assets/no_music.png'
		end

		music_art:set_image(gears.surface.load_uncached(album_path))
		music_title:set_markup_silently("<span foreground='" .. colors.white .. "'>" .. title .. '</span>')
		music_artist:set_markup_silently("<span foreground='" .. colors.lesswhite .. "'>" .. artist .. '</span> ')
	end
)

playerctl_daemon:connect_signal(
	'playback_status',
	function(_, playing, __)
		if playing then
			music_text:set_markup_silently("<span foreground='" .. colors.color1 .. "'>Now Playing</span> ")
		else
			music_text:set_markup_silently("<span foreground='" .. colors.color1 .. "'>Music</span> ")
		end
	end
)

return music
