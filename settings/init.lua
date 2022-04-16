--  _______         __   __   __
-- |     __|.-----.|  |_|  |_|__|.-----.-----.-----.
-- |__     ||  -__||   _|   _|  ||     |  _  |__ --|
-- |_______||_____||____|____|__||__|__|___  |_____|
--                                     |_____|
-- ------------------------------------------------- --

return {
	theme = "vice",
	background = "9.jpg",
	default_programs = {
		terminal = "kitty",
		terminal_editor = "nvim",
		editor = "code-oss",
		browser = "firefox",
		file_manager = "thunar",
		terminal_file_manager = "ranger",
		lock = config_dir .. "bin/blur.sh",
		email = "neomutt",
		chat = "discord",
		screenshot = config_dir .. "bin/snapshot.sh area",
	},
	profile_picture = "user.png",
	window_gaps = 4,
	window_border_size = 2,
	dirs = {
		downloads = "$HOME/Downloads",
		pictures = "$HOME/256/Dropbox/Pictures",
		music = "$HOME/256/Dropbox/Music",
		wallpapers = "$HOME/.config/awesome/themes/wallpapers",
	},
}
