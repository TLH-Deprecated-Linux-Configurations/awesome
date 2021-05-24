local HOME = os.getenv("HOME")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi

local card = require("lib-widget.card")

local theme = require("theme.icons.dark-light")

local PATH_TO_ICONS = HOME .. "/.config/awesome/widget/weather/icons/"

-- Weather Updater
require("widget.weather.weather-update")

local weather_icon_widget =
  wibox.widget {
  {
    id = "icon",
    image = theme(PATH_TO_ICONS .. "whatever_icon" .. ".svg"),
    resize = true,
    forced_height = dpi(45),
    forced_width = dpi(45),
    widget = wibox.widget.imagebox
  },
  layout = wibox.layout.fixed.horizontal
}

_G.weather_icon_widget = weather_icon_widget

local weather_card = card("Weather & Temperature")

local weather_description =
  wibox.widget {
  text = i18n.translate("No internet connection..."),
  font = "SFNS Display Regular 16",
  align = "left",
  valign = "center",
  widget = wibox.widget.textbox
}

_G.weather_description = weather_description

local weather_temperature =
  wibox.widget {
  text = i18n.translate("Try again later."),
  font = "SFNS Display Regular 12",
  align = "left",
  valign = "center",
  widget = wibox.widget.textbox
}

_G.weather_temperature = weather_temperature

local body =
  wibox.widget {
  expand = "none",
  layout = wibox.layout.fixed.horizontal,
  {
    wibox.widget {
      weather_icon_widget,
      margins = dpi(4),
      widget = wibox.container.margin
    },
    margins = dpi(5),
    widget = wibox.container.margin
  },
  {
    {
      layout = wibox.layout.fixed.vertical,
      weather_description,
      weather_temperature
    },
    margins = dpi(4),
    widget = wibox.container.margin
  }
}

weather_card.update_body(body)

return weather_card
