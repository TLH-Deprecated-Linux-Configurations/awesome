
local beautiful = require("beautiful")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi
local signals = require("lib-tde.signals")

local bottom_panel = function(screen)
  local action_bar_width = dpi(45) -- 48

  local panel =
    wibox {
    screen = screen,
    height = screen.geometry.height,
    width = action_bar_width,
    type = "dock",
    x = screen.geometry.x + screen.geometry.width - action_bar_width,
    y = screen.geometry.y + dpi(26),
    ontop = true,
    bg = beautiful.background.hue_800,
    fg = beautiful.fg_normal
  }

  signals.connect_background_theme_changed(
    function(theme)
      panel.bg = theme.hue_800 .. beautiful.background_transparency
    end
  )

  screen.connect_signal(
    "removed",
    function(removed)
      if panel.screen == removed then
        panel.visible = false
        panel = nil
      end
    end
  )

  -- this is called when we need to update the screen
  signals.connect_refresh_screen(
    function()
      print("Refreshing right-panel")
      if panel == nil or panel == nil then
        return
      end
      local scrn = panel.screen
      panel.x = scrn.geometry.x + scrn.geometry.width - action_bar_width
      panel.y = scrn.geometry.y + dpi(26)
      panel.width = action_bar_width
      panel.height = scrn.geometry.height
    end
  )

  panel:struts(
    {
      right = action_bar_width
    }
  )

  panel:setup {
    layout = wibox.layout.align.vertical,
    require("layout.left-panel.action-bar")(screen, action_bar_width)
  }
  return panel
end

return bottom_panel
