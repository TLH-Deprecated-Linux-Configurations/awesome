--  _______           __         __
-- |   |   |.-----.--|  |.--.--.|  |.-----.-----.
-- |       ||  _  |  _  ||  |  ||  ||  -__|__ --|
-- |__|_|__||_____|_____||_____||__||_____|_____|
-- ------------------------------------------------- --
local awful = require('awful')
-- ------------------------------------------------- --

require(... .. '.application_switcher')
require(... .. '.screenshot_menu')
require(... .. '.hotkeys-popup')
require(... .. '.bluetooth')

require(... .. '.menu')
require(... .. '.network')
require(... .. '.notifications')
require(... .. '.notification_center')

require(... .. '.control_center')
require(... .. '.drawer')

-- ------------------------------------------------- --
-- modules requiring "connect_for_each_screen"
awful.screen.connect_for_each_screen(require(... .. '.dock'))
awful.screen.connect_for_each_screen(require(... .. '.exit-screen'))
awful.screen.connect_for_each_screen(require(... .. '.bar'))
