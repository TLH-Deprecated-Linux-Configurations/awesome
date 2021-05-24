local HOME = os.getenv("HOME")
local wibox = require("wibox")
local clickable_container = require("widget.material.clickable-container")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi

local PATH_TO_ICONS = HOME .. "/.config/awesome/widget/xdg-folders/icons/"
local menubar = require("menubar")

local function icon(item)
  return menubar.utils.lookup_icon(item)
end
local picWidget =
  wibox.widget {
  {
    id = "icon",
    widget = wibox.widget.imagebox,
    resize = true
  },
  layout = wibox.layout.align.horizontal
}

local pic_button = clickable_container(wibox.container.margin(picWidget, dpi(8), dpi(8), dpi(8), dpi(8)))
pic_button:buttons(
  gears.table.join(
    awful.button(
      {},
      1,
      nil,
      function()
        awful.spawn.easy_async_with_shell(
          "xdg-open $HOME/Pictures",
          function(_)
          end,
          1
        )
      end
    )
  )
)

-- Alternative to naughty.notify - tooltip. You can compare both and choose the preferred one
awful.tooltip(
  {
    objects = {pic_button},
    mode = "outside",
    align = "right",
    timer_function = function()
      return i18n.translate("Pictures")
    end,
    preferred_positions = {"right", "left", "top", "bottom"}
  }
)

picWidget.icon:set_image(icon("folder-pictures") or (PATH_TO_ICONS .. "folder-pictures" .. ".svg"))

return pic_button
