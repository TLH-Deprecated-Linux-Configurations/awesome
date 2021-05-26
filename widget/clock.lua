local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local watch = require("awful.widget.watch")
local wibox = require("wibox")



-- Create a textclock widget
local mytextclock = wibox.widget.textclock()




-- Add a calendar (credits to kylekewley for the original code)
local month_calendar = awful.widget.calendar_popup.month({
    screen = s,
    start_sunday = false,
    week_numbers = true
  })
  month_calendar:attach(mytextclock)

return mytextclock