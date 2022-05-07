--  _______ __
-- |_     _|  |--.-----.--------.-----.-----.
--   |   | |     |  -__|        |  -__|__ --|
--   |___| |__|__|_____|__|__|__|_____|_____|
-- ------------------------------------------------- --
local beautiful = require("beautiful")
local settings = require("settings")

return {
  colors = require("themes.schemes." .. settings.theme),
  beautiful.init("/home/tlh/.config/awesome/themes/theme.lua")
}
