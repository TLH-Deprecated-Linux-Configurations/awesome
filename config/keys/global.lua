--  _______ __         __           __
-- |     __|  |.-----.|  |--.---.-.|  |
-- |    |  |  ||  _  ||  _  |  _  ||  |
-- |_______|__||_____||_____|___._||__|
--  __  __
-- |  |/  |.-----.--.--.-----.
-- |     < |  -__|  |  |__ --|
-- |__|\__||_____|___  |_____|
--               |_____|
-- ------------------------------------------------- --
-- setup
local awful = require("awful")
local naughty = require("naughty")

local modkey = require("config.keys.mod").modKey
local altkey = require("config.keys.mod").altKey
local drop = require("utils.dropdown")
local apps = require("config.root.apps")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local hotkeys_popup_custom = require("utils.hotkeys-popup")
_G.switcher = require("module.application-switcher")
require("awful.autofocus")

local globalKeys =
	awful.util.table.join(
	-- ------------------------------------------------- --
	awful.key({modkey}, "j", awful.tag.viewprev, {description = "view previous", group = "Tag"}),
	-- ------------------------------------------------- --
	awful.key({modkey}, "k", awful.tag.viewnext, {description = "view next", group = "Tag"}),
	-- ------------------------------------------------- --
	awful.key(
		{modkey, "Shift"},
		"Right",
		function()
			awful.client.focus.byidx(1)
		end,
		{description = "focus next by index", group = "Window"}
	),
	-- ------------------------------------------------- --
	awful.key(
		{modkey, "Shift"},
		"j",
		function()
			awful.client.focus.byidx(-1)
		end,
		{description = "focus previous by index", group = "Window"}
	),
	-- ------------------------------------------------- --
	-- Layout manipulation
	awful.key(
		{modkey, "Shift"},
		"j",
		function()
			awful.client.swap.byidx(1)
		end,
		{description = "swap with next client by index", group = "Window"}
	),
	-- ------------------------------------------------- --
	awful.key(
		{modkey, "Shift"},
		"k",
		function()
			awful.client.swap.byidx(-1)
		end,
		{description = "swap with previous client by index", group = "Window"}
	),
	-- ------------------------------------------------- --
	awful.key(
		{modkey, "Control"},
		"j",
		function()
			awful.screen.focus_relative(1)
		end,
		{description = "focus the next screen", group = "Screen"}
	),
	-- ------------------------------------------------- --
	awful.key(
		{modkey, "Control"},
		"k",
		function()
			awful.screen.focus_relative(-1)
		end,
		{description = "focus the previous screen", group = "Screen"}
	),
	-- ------------------------------------------------- --
	awful.key({modkey}, "u", awful.client.urgent.jumpto, {description = "jump to urgent client", group = "Window"}),
	-- ------------------------------------------------- --
	awful.key(
		{modkey},
		"Tab",
		function()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end,
		{description = "go back", group = "Window"}
	),
	-- ------------------------------------------------- --
	-- Tab Between Applications
	awful.key(
		{"Mod1"},
		"Tab",
		function()
			_G.switcher.switch(1, "Mod1", "Alt_L", "Shift", "Tab")
		end,
		{description = "Tab Forward Between Applications", group = "Launcher"}
	),
	-- ------------------------------------------------- --
	awful.key(
		{"Mod1", "Shift"},
		"Tab",
		function()
			_G.switcher.switch(-1, "Mod1", "Alt_L", "Shift", "Tab")
		end,
		{
			description = "Tab Between Applications In Reverse Order",
			group = "Launcher"
		}
	),
	-- ------------------------------------------------- --
	-- Terminal
	awful.key(
		{modkey},
		"Return",
		function()
			drop.toggle(apps.default.terminal, "left", "top", 0.9, 0.9)
		end,
		{description = "Open Terminal", group = "Default programs"}
	),
	-- ------------------------------------------------- --
	-- Terminal
	awful.key(
		{modkey, "Shift"},
		"Return",
		function()
			awful.spawn(apps.default.terminal)
		end,
		{description = "Open Terminal", group = "Default programs"}
	),
	-- ------------------------------------------------- --
	awful.key({modkey}, "r", awesome.restart, {description = "reload awesome", group = "Awesome"}),
	-- ------------------------------------------------- --
	awful.key({modkey, "Shift"}, "q", awesome.quit, {description = "quit awesome", group = "Awesome"}),
	-- ------------------------------------------------- --
	awful.key(
		{modkey},
		"h",
		function()
			awful.tag.incmwfact(0.05)
		end,
		{description = "increase master width factor", group = "Layout"}
	),
	-- ------------------------------------------------- --
	awful.key(
		{modkey},
		"l",
		function()
			awful.tag.incmwfact(-0.05)
		end,
		{description = "decrease master width factor", group = "Layout"}
	),
	-- ------------------------------------------------- --
	awful.key(
		{modkey, "Shift"},
		"h",
		function()
			awful.tag.incnmaster(1, nil, true)
		end,
		{description = "increase the number of master clients", group = "Layout"}
	),
	-- ------------------------------------------------- --
	awful.key(
		{modkey, "Shift"},
		"l",
		function()
			awful.tag.incnmaster(-1, nil, true)
		end,
		{description = "decrease the number of master clients", group = "Layout"}
	),
	-- ------------------------------------------------- --
	awful.key(
		{modkey, "Control"},
		"h",
		function()
			awful.tag.incncol(1, nil, true)
		end,
		{description = "increase the number of columns", group = "Layout"}
	),
	-- ------------------------------------------------- --
	awful.key(
		{modkey, "Control"},
		"l",
		function()
			awful.tag.incncol(-1, nil, true)
		end,
		{description = "decrease the number of columns", group = "Layout"}
	),
	-- ------------------------------------------------- --
	awful.key(
		{modkey},
		"space",
		function()
			awesome.emit_signal("layout::changed:next")
			naughty.notify(
				{
					preset = naughty.config.presets.low,
					title = "Switched Layouts",
					text = awful.layout.getname(awful.layout.get(awful.screen.focused()))
				}
			)
		end,
		{description = "select next layout", group = "Layout"}
	),
	-- ------------------------------------------------- --
	awful.key(
		{modkey, "Shift"},
		"space",
		function()
			awesome.emit_signal("layout::changed:prev")
			naughty.notify(
				{
					preset = naughty.config.presets.low,
					title = "Switched Layouts",
					text = awful.layout.getname(awful.layout.get(awful.screen.focused()))
				}
			)
		end,
		{description = "select previous layout", group = "Layout"}
	),
	-- ------------------------------------------------- --
	awful.key(
		{modkey, "Control"},
		"n",
		function()
			local c = awful.client.restore()
			-- Focus restored client
			if c then
				c:emit_signal("request::activate", "key.unminimize", {raise = true})
			end
		end,
		{description = "restore minimized", group = "Window"}
	),
	-- ------------------------------------------------- --
	--Run App Menu
	awful.key(
		{modkey, "Control"},
		"Escape",
		function()
			awful.spawn.with_shell("rofi -no-lazy-grab -show drun -theme ~/.config/awesome/config/rofi/centered.rasi")
		end,
		{description = "run rofi prompt", group = "Launchers"}
	),
	-- ------------------------------------------------- --
	--Window Menu
	awful.key(
		{"Mod1"},
		"Escape",
		function()
			awful.menu.menu_keys.down = {"Down", "Alt_L"}
			awful.menu.menu_keys.up = {"Up", "Alt_R"}
			awful.menu.clients({theme = {width = 450}}, {keygrabber = true})
		end,
		{description = "Launch Menu of Open Windows", group = "Utility"}
	),
	-- ------------------------------------------------- --
	awful.key(
		{modkey},
		"Escape",
		function()
			exit_screen_show()
		end,
		{description = "Toggle Exit Screen", group = "Awesome"}
	),
	-- ------------------------------------------------- --
	awful.key(
		{modkey, "Shift"},
		"m",
		function()
			awesome.emit_signal("bar:toggle")
			awesome.emit_signal("cc:resize")
			awesome.emit_signal("nc:resize")
			awesome.emit_signal("cal:resize")
		end,
		{description = "Toggle Bottom Panel", group = "Awesome"}
	),
	awful.key(
		{modkey, "Shift"},
		"Escape",
		function()
			awesome.emit_signal("bar::centers:toggle:off")
		end,
		{description = "Turn Bars Off", group = "Awesome"}
	),
	-- ------------------------------------------------- --
	awful.key({modkey}, "F1", hotkeys_popup_custom.show_help, {description = "show help", group = "Awesome"}),
	-- ------------------------------------------------- --
	awful.key(
		{modkey},
		"F2",
		function()
			awful.spawn(apps.default.browser)
		end,
		{description = "Open Firefox", group = "Default programs"}
	),
	-- ------------------------------------------------- --
	awful.key(
		{modkey},
		"F3",
		function()
			awful.spawn(apps.default.file_manager)
		end,
		{description = "Open File Manager as a Dropdown", group = "Default programs"}
	),
	-- ------------------------------------------------- --
	awful.key(
		{modkey, "Shift"},
		"F3",
		function()
			drop.toggle(apps.default.file_manager, "left", "top", 0.7, 0.7)
		end,
		{description = "Open File Manager", group = "Default programs"}
	),
	-- ------------------------------------------------- --
	awful.key(
		{modkey, "Control"},
		"F3",
		function()
			awful.spawn(apps.default.terminal_file_manager)
		end,
		{description = "Open Terminal File Manager", group = "Default programs"}
	),
	-- ------------------------------------------------- --

	awful.key(
		{modkey},
		"F4",
		function()
			awful.spawn.easy_async_with_shell("~/.config/awesome/config/rofi/fontawesome_menu/fontawesome-menu")
		end,
		{
			description = "Copy FontAwesome Icons to Clipboard",
			group = "Launcher"
		}
	),
	-- ------------------------------------------------- --
	awful.key(
		{modkey},
		"F5",
		function()
			awful.spawn(apps.default.editor)
		end,
		{description = "Open Code Editor", group = "Default programs"}
	),
	-- ------------------------------------------------- --
	awful.key(
		{modkey},
		"F6",
		function()
			awful.spawn(apps.default.email)
		end,
		{description = "Open Email", group = "Default programs"}
	),
	-- ------------------------------------------------- --
	awful.key(
		{modkey},
		"F7",
		function()
			awesome.emit_signal("cc:resize")
			awesome.emit_signal("cc:toggle")
		end,
		{description = "toggle control center", group = "Awesome"}
	),
	-- ------------------------------------------------- --
	awful.key(
		{modkey, "Shift"},
		"F7",
		function()
			awesome.emit_signal("notifications::center:toggle")
		end,
		{description = "toggle notification center", group = "Awesome"}
	),
	-- ------------------------------------------------- --
	awful.key(
		{modkey},
		"F12",
		function()
			awesome.emit_signal("settings::window:toggle")
		end,
		{description = "Settings Window", group = "Awesome"}
	),
	-- ------------------------------------------------- --
	-- ------------------------------------------------- --
	--Screenshot
	awful.key(
		{},
		"Print",
		function()
			awful.spawn.easy_async_with_shell("$HOME/.config/awesome/bin/snapshot.sh full")
		end,
		{description = "Screenshot Tool", group = "Launcher"}
	),
	-- ------------------------------------------------- --
	-- ------------------------------------------------- --
	-- ------------------------------------------------- --
	--Screenshot
	awful.key(
		{modkey},
		"Print",
		function()
			awful.spawn.easy_async_with_shell("$HOME/.config/awesome/bin/snapshot.sh area")
		end,
		{description = "Screenshot Tool", group = "Launcher"}
	),
	-- ------------------------------------------------- --
	-- Brightness
	awful.key(
		{},
		"XF86MonBrightnessUp",
		function()
			awful.spawn("light -A 10%", false)
			awful.spawn.with_line_callback(
				"light -G",
				{
					stdout = function(value)
						awful.spawn.with_line_callback(
							"light -M ",
							{
								stdout = function(max)
									percentage = value / max * 100
									-- if percentage ~= percentage_old then
									awesome.emit_signal("signal::brightness", percentage)
									-- percentage_old = percentage
									-- end
								end
							}
						)
					end
				}
			)
		end,
		{description = "increase brightness by 10%", group = "Hotkeys"}
	),
	-- ------------------------------------------------- --
	awful.key(
		{},
		"XF86MonBrightnessDown",
		function()
			awful.spawn("light -U 10%", false)
			awful.spawn.with_line_callback(
				"light -G",
				{
					stdout = function(value)
						awful.spawn.with_line_callback(
							"light -M ",
							{
								stdout = function(max)
									percentage = value / max * 100
									-- if percentage ~= percentage_old then
									awesome.emit_signal("signal::brightness", percentage)
									-- percentage_old = percentage
									-- end
								end
							}
						)
					end
				}
			)
		end,
		{description = "decrease brightness by 10%", group = "Hotkeys"}
	),
	-- ------------------------------------------------- --
	awful.key(
		{},
		"XF86AudioRaiseVolume",
		function()
			awful.spawn("pamixer -i 5")
		end,
		{description = "Increase Volume", group = "Awesome"}
	),
	-- ------------------------------------------------- --
	awful.key(
		{},
		"XF86AudioLowerVolume",
		function()
			awful.spawn("pamixer -d 5")
		end,
		{description = "Decrease Volume", group = "Awesome"}
	),
	-- ------------------------------------------------- --
	awful.key(
		{},
		"XF86AudioMute",
		function()
			awful.spawn("pamixer -t")
		end,
		{description = "Mute Volume", group = "Awesome"}
	),
	-- ------------------------------------------------- --
	-- Power Button
	awful.key(
		{},
		"XF86PowerDown",
		function()
			awesome.emit_signal("module::exit_screen:show")
		end,
		{description = "Shutdown Skynet", group = "Hotkeys"}
	), -- ------------------------------------------------- --
	awful.key(
		{},
		"XF86PowerOff",
		function()
			awesome.emit_signal("module::exit_screen:show")
		end,
		{description = "Toggle Exit Screen", group = "Hotkeys"}
	),
	-- ------------------------------------------------- --
	-- Display Button
	awful.key(
		{},
		"XF86Display",
		function()
			awful.spawn.single_instance("arandr", false)
		end,
		{description = "Arandr", group = "Hotkeys"}
	) --
)
-- ------------------------------------------------- --
for i = 1, 9 do
	globalKeys =
		awful.util.table.join(
		globalKeys,
		-- View tag only.
		awful.key(
			{modkey},
			"#" .. i + 9,
			function()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					tag:view_only()
				end
			end,
			{description = "view tag #" .. i, group = "Tag"}
		),
		-- Toggle tag display.
		awful.key(
			{modkey, "Control"},
			"#" .. i + 9,
			function()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					awful.tag.viewtoggle(tag)
				end
			end,
			{description = "toggle tag #" .. i, group = "Tag"}
		),
		-- Move client to tag.
		awful.key(
			{modkey, "Shift"},
			"#" .. i + 9,
			function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:move_to_tag(tag)
					end
				end
			end,
			{description = "move focused client to tag #" .. i, group = "Tag"}
		),
		-- Toggle tag on focused client.
		awful.key(
			{modkey, "Control", "Shift"},
			"#" .. i + 9,
			function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:toggle_tag(tag)
					end
				end
			end,
			{description = "toggle focused client on tag #" .. i, group = "Tag"}
		)
	)
end

return globalKeys
