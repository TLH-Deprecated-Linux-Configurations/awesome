--  _______           __         __
-- |   |   |.-----.--|  |.--.--.|  |.-----.-----.
-- |       ||  _  |  _  ||  |  ||  ||  -__|__ --|
-- |__|_|__||_____|_____||_____||__||_____|_____|
-- ------------------------------------------------- --
local awful = require("awful")
-- ------------------------------------------------- --
require(... .. ".notifications")
require(... .. ".menu")
require(... .. ".tutorial")
require(... .. ".control-center")
-- ------------------------------------------------- --
awful.screen.connect_for_each_screen(require(... .. ".notification-center"))
--awful.screen.connect_for_each_screen(require(... .. ".bluetooth-center"))
awful.screen.connect_for_each_screen(require(... .. ".network-center"))

awful.screen.connect_for_each_screen(require(... .. ".exit-screen"))
awful.screen.connect_for_each_screen(require(... .. ".bar"))
