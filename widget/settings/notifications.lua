local os = require("os")
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")
local appname = require("lib.nappname")
local icons = require("theme.icons")
function show_empty()
  local empty = wibox.container.place()
  empty.forced_width = beautiful.modal_width - 260 - (10 * 4)
  empty.forced_height = beautiful.modal_height - (10 * 3) - 40
  empty.valign = "center"
  empty.halign = "center"
  empty.widget = wibox.widget.textbox("you have no notifications!")
  return empty
end

return function()
  local view = wibox.container.margin()
  view.left = 10
  view.right = 10

  local title = wibox.widget.textbox("Notifications")
  title.font = beautiful.font .. " 22"
  title.forced_height = 40 + 10 + 10

  local close = wibox.widget.imagebox(icons.close)
  close.font = beautiful.font .. " 10"
  close.forced_height = 40
  close:buttons(
    gears.table.join(
      awful.button(
        {},
        1,
        function()
          if root.elements.hub then
            root.elements.hub.close()
          end
        end
      )
    )
  )

  local clear = wibox.widget.textbox(icons.clear)
  clear.font = beautiful.font .. " 08"
  clear.forced_height = 40
  clear:buttons(
    gears.table.join(
      awful.button(
        {},
        1,
        function()
          naughty.destroy_all_notifications()
        end
      )
    )
  )

  local notifications =
    naughty.list.notifications {
    base_layout = wibox.widget {
      layout = wibox.layout.fixed.vertical,
      spacing = 10
    },
    widget_template = {
      layout = wibox.container.background,
      bg = beautiful.bg_modal .. "66",
      shape = function(cr, rect_width, rect_height)
        gears.shape.partially_rounded_rect(cr, rect_width, rect_height, true, true, true, true, 12)
      end,
      {
        layout = wibox.container.margin,
        margins = 08,
        {
          layout = wibox.layout.align.horizontal,
          {
            layout = wibox.container.margin,
            right = 08,
            naughty.widget.icon
          },
          {
            layout = wibox.layout.fixed.vertical,
            {layout = wibox.container.margin, bottom = 08 / 2, naughty.widget.title},
            {layout = wibox.container.margin, bottom = 08 / 2, naughty.widget.message},
            {layout = wibox.container.place, halign = "right", appname}
          },
          nil
        }
      }
    }
  }

  view:setup {
    layout = wibox.container.background,
    fg = beautiful.xforeground,
    {
      layout = wibox.layout.align.vertical,
      {
        layout = wibox.layout.align.horizontal,
        clear,
        {
          layout = wibox.container.place,
          title
        },
        close
      },
      {
        layout = wibox.layout.flex.horizontal,
        notifications
      }
    }
  }

  return view
end
