--  ______
-- |   __ \.---.-.----.
-- |   __ <|  _  |   _|
-- |______/|___._|__|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- declare widget
local bar = function(s)
	s.panel =
		awful.wibox(
		{
			ontop = true,
			screen = s,
			type = "dock",
			height = dpi(42),
			position = "bottom",
			width = s.geometry.width,
			x = s.geometry.x,
			y = s.geometry.y,
			stretch = true,
			visible = false,
			bg = beautiful.bg_normal,
			fg = colors.white
		}
	)
	-- ------------------------------------------------- --
	--  provide spacing

	-- ------------------------------------------------- --
	--  toggle function to make it disappear
	function bar_toggle()
		if s.panel.visible == false then
			awful.screen.connect_for_each_screen(
				function(s)
					s.panel.visible = true
					s.panel:struts {
						bottom = dpi(42)
					}
				end
			)
			awesome.emit_signal("bar:true")
		elseif s.panel.visible == true then
			awful.screen.connect_for_each_screen(
				function(s)
					s.panel.visible = false
				end
			)
			awesome.emit_signal("bar:false")
		end
	end

	-- ------------------------------------------------- --
	--  left portion of the panel
	local leftBar = {
		layout = wibox.layout.fixed.horizontal,
		spacing = dpi(5)
	}
	-- ------------------------------------------------- --
	--  center portion of the panel, used for spacing purposes
	local centerBar = {
		layout = wibox.layout.align.horizontal,
		spacing = dpi(5),
		{
			layout = wibox.layout.fixed.horizontal,
			nil
		},
		{
			require("widget.bar.task")(s),
			layout = wibox.layout.fixed.horizontal
		},
		{
			nil,
			layout = wibox.layout.fixed.horizontal
		}
	}
	-- ------------------------------------------------- --
	--  right portion of the panel, used for widgets
	local rightBar = {
		layout = wibox.layout.fixed.horizontal,
		spacing = dpi(5)
	}
	-- ------------------------------------------------- --
	--  inserting widgets as tables on the left portion
	table.insert(leftBar, require("widget.bar.menu")({color = colors[beautiful.bg_button]}, 0, 0, 0, 0))
	table.insert(leftBar, require("widget.bar.tags")(s))
	-- table.insert(leftBar, require("widget.bar.task")(s))
	-- ------------------------------------------------- --
	-- ------------------------------------------------- --
	--  right widget insertions
	table.insert(rightBar, require("widget.bar.volume")({color = colors[beautiful.bg_button]}, 0, 0))

	table.insert(rightBar, require("widget.bar.network")({color = colors[beautiful.bg_button]}, 0, 0))
	table.insert(rightBar, require("widget.bar.notifications-bar")({color = colors[beautiful.bg_button]}, 0, 0))
	table.insert(rightBar, require("widget.bar.bluetooth")({color = colors[beautiful.bg_button]}, 0, 0))
	table.insert(rightBar, require("widget.bar.battery")({color = colors[beautiful.bg_button]}, 0, 0))
	table.insert(rightBar, require("widget.bar.clock")({color = colors[beautiful.bg_button]}, 0, 0))
	table.insert(rightBar, require("widget.bar.end-session")({color = colors[beautiful.bg_button]}, 0, 0))
	-- ------------------------------------------------- --
	-- panel template
	s.panel:setup {
		layout = wibox.layout.align.horizontal,
		expand = "none",
		{
			leftBar,
			left = dpi(4),
			top = dpi(3),
			bottom = dpi(3),
			widget = wibox.container.margin
		},
		{
			centerBar,
			top = dpi(4),
			bottom = dpi(4),
			widget = wibox.container.margin
		},
		{
			rightBar,
			right = dpi(4),
			widget = wibox.container.margin
		}
	}
	s.detect =
		gears.timer {
		timeout = 3,
		callback = function()
			s.panel.visible = false
			s.detect:stop()
		end
	}

	s.enable_wibar = function()
		s.panel.visible = true
		if not s.detect.started then
			s.detect:start()
		end
	end

	s.activation_zone =
		wibox(
		{
			x = s.geometry.x,
			y = s.geometry.y + s.geometry.height - 1,
			position = "bottom",
			opacity = 1.0,
			width = s.geometry.width,
			height = 1,
			screen = s,
			input_passthrough = false,
			visible = true,
			ontop = true,
			type = "dock"
		}
	)

	s.activation_zone:connect_signal(
		"mouse::enter",
		function()
			s.enable_wibar()
		end
	)
	s.panel:connect_signal(
		"mouse:enter",
		function()
			s.enable_wibar()
		end
	)
	s.panel:connect_signal(
		"mouse:leave",
		function()
			s.detect()
		end
	)
	return s.panel
end
-- ------------------------------------------------- --
--  connect signal for the bar toggle to run the function
awesome.connect_signal(
	"bar:toggle",
	function()
		bar_toggle()
	end
)
-- ------------------------------------------------- --
-- universal toggle to turn off all the centers spawned from widgets
awesome.connect_signal(
	"bar::centers:toggle:off",
	function()
		awesome.emit_signal("volume::center:toggle:off")
		awesome.emit_signal("network::center:toggle:off")
		awesome.emit_signal("notifications::center:toggle:off")
		awesome.emit_signal("bluetooth::center:toggle:off")
		awesome.emit_signal("cal::center:toggle:off")
	end
)
-- ------------------------------------------------- --
return bar
