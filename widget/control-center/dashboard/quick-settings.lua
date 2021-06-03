
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local card = require("lib.card")

local quick_settings_card = card("Volume")

local volSlider = require("widget.volume.volume-slider")
local body =
  wibox.widget {
  volSlider,
  layout = wibox.layout.fixed.vertical
}

quick_settings_card.update_body(body)

return wibox.container.margin(quick_settings_card, dpi(20), dpi(20), dpi(20), dpi(20))
