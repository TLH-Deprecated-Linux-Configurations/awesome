
local wibox = require("wibox")
local clickable_container = require("widget.material.clickable-container")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi

local menubar = require("menubar")
local HOME = os.getenv("HOME")
local PATH_TO_ICONS = HOME .. "/.config/awesome/widget/xdg-folders/icons/"

local function icon(item)
  return menubar.utils.lookup_icon(item)
end

local homeWidget =
  wibox.widget {
  {
    id = "icon",
    widget = wibox.widget.imagebox,
    resize = true
  },
  layout = wibox.layout.align.horizontal
}

local home_button = clickable_container(wibox.container.margin(homeWidget, dpi(8), dpi(8), dpi(8), dpi(8)))
home_button:buttons(
  gears.table.join(
    awful.button(
      {},
      1,
      nil,
      function()
        awful.spawn.easy_async_with_shell(
          "xdg-open $HOME",
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
    objects = {home_button},
    mode = "outside",
    align = "right",
    timer_function = function()
      return i18n.translate("Home")
    end,
    preferred_positions = {"right", "left", "top", "bottom"}
  }
)

homeWidget.icon:set_image(icon("folder-home") or (PATH_TO_ICONS .. "user-home" .. ".svg"))

return home_button
