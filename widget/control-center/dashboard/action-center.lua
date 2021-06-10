local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local card = require("lib.card")

local action_card = card("Action Center")

local actionWidget = require("widget.action-center")

action_card.update_body(actionWidget)

return wibox.container.margin(action_card, dpi(20), dpi(20), dpi(20), dpi(20))
