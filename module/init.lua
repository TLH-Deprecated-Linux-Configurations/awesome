local awful = require("awful")

require("module.notifications")
awful.screen.connect_for_each_screen(require("module.notification-center"))
awful.screen.connect_for_each_screen(require("module.bluetooth-center"))
awful.screen.connect_for_each_screen(require("module.network-center"))
require("module.volume-center")

require("module.menu")

awful.screen.connect_for_each_screen(require("module.exit-screen"))
awful.screen.connect_for_each_screen(require("module.control-center"))
awful.screen.connect_for_each_screen(require("module.bar"))
