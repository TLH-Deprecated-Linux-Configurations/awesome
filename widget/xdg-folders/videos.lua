local HOME = os.getenv("HOME")
local wibox = require("wibox")
local clickable_container = require("widget.material.clickable-container")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi

local PATH_TO_ICONS = HOME ..  "/.config/awesome/widget/xdg-folders/icons/"
local menubar = require("menubar")

local function icon(item)
  return menubar.utils.lookup_icon(item)
end
local vidWidget =
  wibox.widget {
  {
    id = "icon",
    widget = wibox.widget.imagebox,
    resize = true
  },
  layout = wibox.layout.align.horizontal
}

local videos_button = clickable_container(wibox.container.margin(vidWidget, dpi(8), dpi(8), dpi(8), dpi(8)))
videos_button:buttons(
  gears.table.join(
    awful.button(
      {},
      1,
      nil,
      function()
        awful.spawn.easy_async_with_shell(
          "xdg-open $HOME/Videos",
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
    objects = {videos_button},
    mode = "outside",
    align = "right",
    timer_function = function()
      return i18n.translate("Videos")
    end,
    preferred_positions = {"right", "left", "top", "bottom"}
  }
)

vidWidget.icon:set_image(icon("folder-video") or (PATH_TO_ICONS .. "folder-videos" .. ".svg"))

return videos_button
