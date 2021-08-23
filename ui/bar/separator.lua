local wibox = require('wibox')
local beautiful = require('beautiful')

return wibox.widget {
    widget = wibox.container.margin,
    left = 6,
    border_color = beautiful.xcolor7
}
