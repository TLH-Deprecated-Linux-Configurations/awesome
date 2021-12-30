--  _______
-- |     __|.----.----.-----.-----.-----.
-- |__     ||  __|   _|  -__|  -__|     |
-- |_______||____|__| |_____|_____|__|__|
--  ______                           __
-- |   __ \.-----.----.-----.----.--|  |.-----.----.
-- |      <|  -__|  __|  _  |   _|  _  ||  -__|   _|
-- |___|__||_____|____|_____|__| |_____||_____|__|
--  ______               ___ __
-- |      |.-----.-----.'  _|__|.-----.
-- |   ---||  _  |     |   _|  ||  _  |
-- |______||_____|__|__|__| |__||___  |
--                              |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local user_preferences = {}

-- Screen	WIDTHxHEIGHT
user_preferences.user_resolution = '1920x1080'

-- Offset 	x,y
user_preferences.user_offset = '0,0'

-- bool   	true or false
user_preferences.user_audio = false

-- String 	$HOME
user_preferences.user_save_directory = '$(xdg-user-dir VIDEOS)/Recordings/'

-- String
user_preferences.user_mic_lvl = '20'

-- String
user_preferences.user_fps = '30'

return user_preferences
