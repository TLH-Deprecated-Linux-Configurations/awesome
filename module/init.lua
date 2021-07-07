--  _______           __         __
-- |   |   |.-----.--|  |.--.--.|  |.-----.-----.
-- |       ||  _  |  _  ||  |  ||  ||  -__|__ --|
-- |__|_|__||_____|_____||_____||__||_____|_____|

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Init all modules
require("module.settings")
require("module.settings.auto-start")
require("widget.exit-screen")
require("module.ui-components.quake-terminal")
require("module.hardware.brightness-slider-osd")
require("module.hardware.volume-slider-osd")
require("module.hardware.volume_manager")
_G.switcher = require("module.ui-components.application-switch")

require("module.hardware.battery-notifier")
