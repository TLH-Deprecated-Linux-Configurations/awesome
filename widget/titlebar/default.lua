local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local titlebar = require("util.titlebar")
local mat_fg = require("widget.material.foreground")

beautiful.titlebar_bg_focus = beautiful.titlebar_bg_focus or beautiful.xbackground
beautiful.titlebar_bg = beautiful.titlebar_bg or beautiful.xbackground
beautiful.titlebar_bg_normal = beautiful.titlebar_bg_normal or beautiful.xbackground
local size = beautiful.titlebar_size or nil

client.connect_signal("request::titlebars", function(c)

  local position = beautiful.titlebar_position or 'top'

  if not titlebar.is_titlebar_off(c) then
    awful.titlebar(c, { position = position, size = size }) : setup {
      nil, -- left
      { -- Middle
        {
          buttons = titlebar.button(c),
          widget = titlebar.title(c),
        },
        widget = mat_fg({ color = beautiful.xcolor15 })
      },
      { -- Right
        titlebar.button_minimize(c),
        titlebar.button_maximize(c),
        titlebar.button_close(c),
        layout = wibox.layout.fixed.horizontal
      },
      --expand = "none",
      layout = wibox.layout.align.horizontal
    }
  end

  -- bottom bar for ncmpcpp
  if c.class == "music_n" and position ~= 'left' then
    titlebar.ncmpcpp(c)
  end
end)
