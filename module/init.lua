--  _______           __         __
-- |   |   |.-----.--|  |.--.--.|  |.-----.-----.
-- |       ||  _  |  _  ||  |  ||  ||  -__|__ --|
-- |__|_|__||_____|_____||_____||__||_____|_____|

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Init all modules
require('module.settings')
require('module.auto-start')
require('widget.exit-screen')
require('module.quake-terminal')
require('module.brightness-slider-osd')
require('module.volume-slider-osd')
require('module.volume_manager')
_G.switcher = require('module.application-switch')

require('module.battery-notifier')
