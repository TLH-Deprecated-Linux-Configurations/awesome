--  _______
-- |   _   |.-----.-----.-----.
-- |       ||  _  |  _  |__ --|
-- |___|___||   __|   __|_____|
--          |__|  |__|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
return {
	-- ------------------------------------------------- --
	-- The default applications that we will use in keybindings and widgets
	--
	default = {
		-- Default terminal emulator
		--
		terminal = "kitty",
		-- ------------------------------------------------- --
		-- Default web browser
		--
		browser = "firefox",
		-- ------------------------------------------------- --
		-- Default text editor
		text_editor = "nvim",
		-- ------------------------------------------------- --
		-- Default file manager
		file_manager = "caja",
		-- ------------------------------------------------- --
		-- Default media player
		--
		multimedia = "vlc",
		-- ------------------------------------------------- --
		-- Default graphics editor
		--
		graphics = "gimp",
		-- ------------------------------------------------- --
		-- Default network manager
		--
		network_manager = "sh " .. HOME .. "/.config/awesome/bin/wifi.sh",
		-- ------------------------------------------------- --
		-- Default bluetooth manager
		bluetooth_manager = "blueman",
		-- ------------------------------------------------- --
		-- Default power manager
		--
		power_manager = "xfce4-power-manager",
		-- ------------------------------------------------- --
		-- Default GUI package manager
		--
		package_manager = "pamac-manager",
		-- ------------------------------------------------- --
		-- Default locker
		--
		lock = "bash " .. HOME .. "/.config/awesome/bin/blur.sh",
		-- ------------------------------------------------- --
		-- Default app menu
		--
		rofi_appmenu = " bash "
			.. HOME
			.. "/.config/awesome/bin/applauncher.sh "
			.. screen.primary.dpi
			.. " "
			.. filesystem.get_configuration_dir(),
		-- ------------------------------------------------- --
	},
	-- ------------------------------------------------- --
	-- List of apps to start once on start-up
	run_on_start_up = {
		"xsettingsd &",
		'xrdb "$HOME"/.Xresources &',
		"pnmixer &",
		'sudo pkill goautolock && goautolock --time 600 --notify 30 --locker "$HOME/.config/awesome/bin/blur.sh" &',
		--'dropbox start &',
		"sudo pkill /usr/libexec/xfce-polkit && /usr/libexec/xfce-polkit &",
		-- 	'xinput set-prop "ELAN1301:00 04F3:30C6 Touchpad" "libinput Tapping Enabled" 1 &',
		' eval "$(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)" &',
		'xcape -e "Super_L=Super_L|Control_L|Escape" &',
		"greenclip daemon &",
		"udiskie &",
		"picom -b --experimental-backends &",

		"dbus-daemon --session --address=unix:path=$XDG_RUNTIME_DIR/bus &",
		"xfce4-power-manager &",
	},
	-- ------------------------------------------------- --
	-- List of binaries/shell scripts that will execute for a certain task
	--
	utils = {
		-- ------------------------------------------------- --
		-- Fullscreen screenshot
		--
		full_screenshot = config_dir .. "/bin/snapshot.sh full",
		-- ------------------------------------------------- --
		-- Area screenshot
		--
		area_screenshot = config_dir .. "/bin/snapshot.sh area",
		-- ------------------------------------------------- --
		-- Update profile picture
		--
		update_profile = utils_dir .. "/profile-image",
	},
}
