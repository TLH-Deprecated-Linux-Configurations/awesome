--  _______           __         __
-- |   |   |.-----.--|  |.--.--.|  |.-----.-----.
-- |       ||  _  |  _  ||  |  ||  ||  -__|__ --|
-- |__|_|__||_____|_____||_____||__||_____|_____|
-- ------------------------------------------------- --
local awful = require("awful")
-- ------------------------------------------------- --

require(... .. ".application_switcher")
require(... .. ".dashboard")

require(... .. ".hotkeys-popup")

require(... .. ".menu")
require(... .. ".network")
require(... .. ".notifications")
require(... .. ".titlebar")
require(... .. ".controlCenter")

-- ------------------------------------------------- --
-- modules requiring "connect_for_each_screen"
awful.screen.connect_for_each_screen(require(... .. ".dock"))
awful.screen.connect_for_each_screen(require(... .. ".exit-screen"))
awful.screen.connect_for_each_screen(require(... .. ".bar"))
