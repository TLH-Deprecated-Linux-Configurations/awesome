
local bottom_panel = require("layout.bottom-panel")
local left_panel = require("layout.left-panel")
local right_panel = require("layout.right-panel")
local top_panel = require("layout.top-panel")
local topBarDraw = general["top_bar_draw"] or "all"
local tagBarDraw = general["tag_bar_draw"] or "main"
local anchorTag = general["tag_bar_anchor"] or "bottom"

local function anchor(s)
  if anchorTag == "bottom" then
    -- Create the bottom bar
    s.bottom_panel = bottom_panel(s)
  elseif anchorTag == "right" then
    s.bottom_panel = right_panel(s)
  else
    s.bottom_panel = left_panel(s, topBarDraw == "none")
  end
end

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(
  function(s)
    if topBarDraw == "all" then
      -- Create the Top bar
      s.top_panel = top_panel(s, false, false)
    elseif topBarDraw == "main" and s.index == 1 then
      -- Create the Top bar
      s.top_panel = top_panel(s, false, false)
    else
      -- don't draw anything but render the left_panel
      s.top_panel = top_panel(s, false, true)
    end

    if tagBarDraw == "all" then
      anchor(s)
    elseif tagBarDraw == "main" and s.index == 1 then
      anchor(s)
    end
  end
)

-- Hide bars when app go fullscreen
local function updateBarsVisibility()
  for s in screen do
    if s.selected_tag then
      local fullscreen = s.selected_tag.fullscreenMode
      -- Order matter here for shadow
      if s.top_panel then
        s.top_panel.visible = not fullscreen
      end
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

_G.client.connect_signal(
  "property::fullscreen",
  function(c)
    if c.first_tag then
      c.first_tag.fullscreenMode = c.fullscreen
    end
    updateBarsVisibility()
  end
)

_G.client.connect_signal(
  "unmanage",
  function(c)
    if c.fullscreen then
      c.screen.selected_tag.fullscreenMode = false
      updateBarsVisibility()
    end
  end
)
