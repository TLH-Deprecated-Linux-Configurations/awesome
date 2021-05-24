
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi
local has_package_installed = require("lib-tde.hardware-check").has_package_installed
local seperator_widget = require("lib-widget.separator")

local function show_widget_or_default(widget, show)
  if show then
    return widget
  end
  return wibox.widget {
    text = "",
    visible = false,
    widget = wibox.widget.textbox
  }
end

local separator_horizontal = wibox.container.margin(seperator_widget(dpi(1), "horizontal", 0.2), 0, 0, dpi(10), dpi(10))

local separator_vertical =
  wibox.container.margin(
  wibox.widget {
    orientation = "vertical",
    forced_width = dpi(1),
    opacity = 0.20,
    widget = wibox.widget.separator
  },
  dpi(10),
  dpi(10),
  0,
  0
)

return function(position)
  if position == "left" then
    return wibox.widget {
      layout = wibox.layout.align.vertical,
      {
        separator_horizontal,
        require("widget.xdg-folders.home"),
        require("widget.xdg-folders.documents"),
        require("widget.xdg-folders.downloads"),
        -- require("widget.xdg-folders.pictures"),
        -- require("widget.xdg-folders.videos"),
        separator_horizontal,
        show_widget_or_default(require("widget.xdg-folders.trash"), has_package_installed("gvfs")),
        layout = wibox.layout.fixed.vertical
      }
    }
  end
  return wibox.widget {
    layout = wibox.layout.align.horizontal,
    {
      separator_vertical,
      require("widget.xdg-folders.home"),
      require("widget.xdg-folders.documents"),
      require("widget.xdg-folders.downloads"),
      -- require("widget.xdg-folders.pictures"),
      -- require("widget.xdg-folders.videos"),
      separator_vertical,
      show_widget_or_default(require("widget.xdg-folders.trash"), has_package_installed("gvfs")),
      layout = wibox.layout.fixed.horizontal
    }
  }
end
