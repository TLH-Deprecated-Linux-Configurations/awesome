
local wibox = require("wibox")
local TagList = require("widget.tag-list")
local clickable_container = require("widget.material.clickable-container")

return function(screen, action_bar_width)
  -- Create an imagebox widget which will contains an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  local LayoutBox = function(s)
    local layoutBox = clickable_container(awful.widget.layoutbox(s))
    layoutBox:buttons(
      awful.util.table.join(
        awful.button(
          {},
          1,
          function()
            awful.layout.inc(1)
          end
        ),
        awful.button(
          {},
          3,
          function()
            awful.layout.inc(-1)
          end
        ),
        awful.button(
          {},
          4,
          function()
            awful.layout.inc(1)
          end
        ),
        awful.button(
          {},
          5,
          function()
            awful.layout.inc(-1)
          end
        )
      )
    )
    return layoutBox
  end

  local folders = nil
  if general["weak_hardware"] == "0" or general["weak_hardware"] == nil then
    folders = require("widget.xdg-folders")("bottom")
  end

  
  return wibox.widget {
    id = "action_bar",
    layout = wibox.layout.align.horizontal,
    forced_height = action_bar_width,
    -- left widget
    expand = "none",
    nil,
    {
      -- middle widgets
      layout = wibox.layout.align.horizontal,
      -- Create a taglist widget
      TagList("bottom")(screen),
      folders
    },
    {
      -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      LayoutBox()
    }
  }
end
