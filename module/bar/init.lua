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
			visible = true,
			bg = beautiful.bg_normal,
			fg = colors.white
		}
	)
	-- ------------------------------------------------- --
	--  provide spacing
	s.panel:struts {
		bottom = dpi(42)
	}
	-- ------------------------------------------------- --
	--  toggle function to make it disappear
	function bar_toggle()
		if s.panel.visible == false then
			awful.screen.connect_for_each_screen(
				function(s)
					s.panel.visible = true
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
	--  toggle for when in fullscreen mode
	local function fullscreen_bar_toggle(c)
		if c.screen and c.screen.index == 1 and c == client.focus then
			if c.fullscreen then
				awful.screen.focused().panel.visible = false
			else
				awful.screen.focused().panel.visible = true
			end
		end
	end
	-- ------------------------------------------------- --
	--  signal to apply fullscreen toggle
	for _, signal in pairs({"property::fullscreen", "focus"}) do
		client.connect_signal(signal, fullscreen_bar_toggle)
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
