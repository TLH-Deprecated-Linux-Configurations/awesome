local os = require("os")
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local icons = require("theme.icons")
return function()
  local view = wibox.container.margin()
  view.left = 10
  view.right = 10

  local title = wibox.widget.textbox("Calendar")
  title.font = beautiful.font
  title.forced_height = 40 + 10 + 10

  local close = wibox.widget.imagebox(icons.close)
  close.font = beautiful.font
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

  local cal_container = wibox.container.background()
  cal_container.bg = beautiful.bg_modal .. "66"
  cal_container.shape = function(cr, rect_width, rect_height)
    gears.shape.partially_rounded_rect(cr, rect_width, rect_height, true, true, true, true, 12)
  end
  cal_container.forced_width = beautiful.modal_width - 260 - (10 * 2)
  cal_container.forced_height = beautiful.modal_width - 260 - (10 * 2)

  cal_container:setup {
    layout = wibox.container.margin,
    left = 10,
    right = 40,
    {
      date = os.date("*t"),
      font = beautiful.font,
      widget = wibox.widget.calendar.month
    }
  }

  view:setup {
    layout = wibox.container.background,
    fg = beautiful.xforeground,
    {
      layout = wibox.layout.align.vertical,
      {
        layout = wibox.layout.align.horizontal,
        nil,
        {
          layout = wibox.container.place,
          title
        },
        close
      },
      {
        layout = wibox.container.place,
        valign = "top",
        halign = "center",
        cal_container
      }
    }
  }

  return view
end
