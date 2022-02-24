local awful = require("awful")

require("module.notifications")
require("module.notification-center")
require("module.bluetooth-center")
require("module.network-center")
require("module.volume-center")

require("module.calendar")
require("module.menu")

awful.screen.connect_for_each_screen(require("module.exit-screen"))
awful.screen.connect_for_each_screen(require("module.control-center"))
awful.screen.connect_for_each_screen(require("module.bar"))
