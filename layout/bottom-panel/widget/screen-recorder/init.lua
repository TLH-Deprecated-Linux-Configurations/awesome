--  _______
-- |     __|.----.----.-----.-----.-----.
-- |__     ||  __|   _|  -__|  -__|     |
-- |_______||____|__| |_____|_____|__|__|
--  ______                           __
-- |   __ \.-----.----.-----.----.--|  |.-----.----.
-- |      <|  -__|  __|  _  |   _|  _  ||  -__|   _|
-- |___|__||_____|____|_____|__| |_____||_____|__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local recorder_table = require("layout.bottom-panel.widget.screen-recorder.screen-recorder-ui")
require("layout.bottom-panel.widget.screen-recorder.screen-recorder-ui-backend")
local screen_rec_toggle_button = recorder_table.screen_rec_toggle_button

local return_button = function()
	return screen_rec_toggle_button
end

return return_button
