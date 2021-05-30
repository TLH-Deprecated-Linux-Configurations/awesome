
local bottom_panel = require("layout.bottom-panel")


-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(
  function(s)
    s.bottom_panel = bottom_panel(s)
    end
)

-- Hide bars when app go fullscreen
local function updateBarsVisibility()
  for s in screen do
    if s.selected_tag then
      local fullscreen = s.selected_tag.fullscreenMode
      -- Order matter here for shadow
      if s.bottom_panel then
        s.bottom_panel.visible = not fullscreen
      end
    end
  end
end

_G.tag.connect_signal(
  "property::selected",
  function(_)
    updateBarsVisibility()
  end
)
