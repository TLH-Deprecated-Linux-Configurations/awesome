--  _______ __                     __
-- |     __|__|.-----.-----.---.-.|  |.-----.
-- |__     |  ||  _  |     |  _  ||  ||__ --|
-- |_______|__||___  |__|__|___._||__||_____|
--             |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Internal signal delegator, this manages signals specific to various functions
--
local signals = {}
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Notify other awesome components that the exit_screen should be hidden
--
signals.emit_module_exit_screen_hide = function()
	awesome.emit_signal("module::exit_screen_hide")
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Trigger a callback function when the exit screen goes hidden
--
signals.connect_module_exit_screen_hide = function(func)
	awesome.connect_signal("module::exit_screen_hide", func)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Notify other awesome components that the battery has updated its value
--
signals.emit_module_exit_screen_show = function()
	awesome.emit_signal("module::exit_screen_show")
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Trigger a callback function when the exit screen is being show
--
signals.connect_module_exit_screen_show = function(func)
	awesome.connect_signal("module::exit_screen_show", func)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Notify other awesome components that the battery has updated its value
--
signals.emit_battery = function(value)
	awesome.emit_signal("module::battery", value)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Trigger a callback function when the battery is updated
--
signals.connect_battery = function(func)
	awesome.connect_signal("module::battery", func)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Notify other awesome components that the battery charging has changed
--
signals.emit_battery_charging = function(value)
	awesome.emit_signal("module::charger", value)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Trigger a callback function when the battery charging changed
--
signals.connect_battery_charging = function(func)
	awesome.connect_signal("module::charger", func)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Notify other awesome components that the screen brightness has changed
--
signals.emit_brightness = function(value)
	awesome.emit_signal("brightness::update", value)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Trigger a callback function when the brightness changed
--
signals.connect_brightness = function(func)
	awesome.connect_signal("brightness::update", func)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################

signals.emit_volume = function(value)
	awesome.emit_signal("volume::update", value)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Trigger a callback function when the volume changed
--
signals.connect_volume = function(func)
	awesome.connect_signal("volume::update", func)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Request an update to check to volume value
--
signals.emit_volume_update = function(value)
	awesome.emit_signal("volume::update::request", value or 0)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Trigger a callback function when a client requests a volume update
--
signals.connect_volume_update = function(func)
	awesome.connect_signal("volume::update::request", func)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Notify other awesome components that the volume mute state changed
--
signals.emit_volume_is_muted = function(value)
	awesome.emit_signal("volume::update::muted", value)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Trigger a callback function when the volume mute state changed
--
signals.connect_volume_is_muted = function(func)
	awesome.connect_signal("volume::update::muted", func)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Notify other awesome components that the uptime changed
--
signals.emit_uptime = function(value)
	awesome.emit_signal("uptime::changed", value)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Trigger a callback function when the uptime changed
--
signals.connect_uptime = function(func)
	awesome.connect_signal("uptime::changed", func)
end

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Notify other awesome components about the current cpu usage
--
signals.emit_cpu_usage = function(value)
	awesome.emit_signal("cpu::usage", value)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Trigger a callback function when the cpu usage has been updated
--
signals.connect_cpu_usage = function(func)
	awesome.connect_signal("cpu::usage", func)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################

-- Notify other awesome components about the current disk usage
signals.emit_disk_usage = function(value)
	awesome.emit_signal("disk::usage", value)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################

-- Trigger a callback function when the disk usage has been updated
signals.connect_disk_usage = function(func)
	awesome.connect_signal("disk::usage", func)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Notify other awesome components about the total disk space
signals.emit_disk_space = function(value)
	awesome.emit_signal("disk::space", value)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Trigger a callback function when the disk space has been updated
signals.connect_disk_space = function(func)
	awesome.connect_signal("disk::space", func)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Notify other awesome components about the current ram usage
signals.emit_ram_usage = function(value)
	awesome.emit_signal("ram::usage", value)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Trigger a callback function when the ram usage has been updated
signals.connect_ram_usage = function(func)
	awesome.connect_signal("ram::usage", func)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################

-- Notify other awesome components about the total ram
signals.emit_ram_total = function(value)
	awesome.emit_signal("ram::total", value)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Trigger a callback function for the total ram amount
--
signals.connect_ram_total = function(func)
	awesome.connect_signal("ram::total", func)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Notify other awesome components about the current bluetooth status
--
signals.emit_bluetooth_status = function(value)
	awesome.emit_signal("BLUETOOTH::status", value)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Trigger a callback function for the current bluetooth status
--
signals.connect_bluetooth_status = function(func)
	awesome.connect_signal("BLUETOOTH::status", func)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Notify other awesome components about the current wifi status
--
signals.emit_wifi_status = function(value)
	awesome.emit_signal("WIFI::status", value)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Trigger a callback function for the current wifi status
--
signals.connect_wifi_status = function(func)
	awesome.connect_signal("WIFI::status", func)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Trigger a callback function when we are about to shut down
--
signals.connect_exit = function(func)
	awesome.connect_signal("exit", func)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Notify wiboxes when the screen layout is updated (so they can update their position)
--
signals.emit_refresh_screen = function()
	awesome.emit_signal("awesome::screen:refresh")
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Trigger a callback function when a wibox should update their position on the screen
signals.connect_refresh_screen = function(func)
	awesome.connect_signal("awesome::screen:refresh", func)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Notify when the notification disturb state changes
signals.emit_do_not_disturb = function(bDoNotDisturb)
	awesome.emit_signal("awesome::do_not_disturb::changed", bDoNotDisturb)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Trigger a callback function when the do not disturb mode changed
--
signals.connect_do_not_disturb = function(func)
	awesome.connect_signal("awesome::do_not_disturb::changed", func)
end

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Restore geometry for floating clients
-- (for example after swapping from tiling mode to floating mode)
--
tag.connect_signal("property::layout", function(t)
	for k, c in ipairs(t:clients()) do
		if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
			-- Geometry x = 0 and y = 0 most probably means that the
			-- clients have been spawned in a non floating layout, and thus
			-- they don't have their floating_geometry set properly.
			-- If that is the case, don't change their geometry
			local cgeo = awful.client.property.get(c, "floating_geometry")
			if cgeo ~= nil then
				if not (cgeo.x == 0 and cgeo.y == 0) then
					c:geometry(awful.client.property.get(c, "floating_geometry"))
				end
			end
			c:geometry(awful.client.property.get(c, "floating_geometry"))
		end
	end
end)

return signals
