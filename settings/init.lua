--  _______         __   __   __
-- |     __|.-----.|  |_|  |_|__|.-----.-----.-----.
-- |__     ||  -__||   _|   _|  ||     |  _  |__ --|
-- |_______||_____||____|____|__||__|__|___  |_____|
--                                     |_____|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --

return {
  theme = "vice",
  background = "7.png",
  default_programs = {
    terminal = "kitty",
    terminal_editor = "nvim",
    editor = "code-oss",
    browser = "firefox",
    file_manager = "caja",
    terminal_file_manager = "ranger",
    lock = config_dir .. "bin/blur.sh",
    email = "neomutt",
    chat = "discord",
    screenshot = config_dir .. "bin/snapshot.sh area"
  },
  profile_picture = "user.png",
  window_gaps = 12,
  window_border_size = 2
}
