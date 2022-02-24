--  ______ __               __
-- |      |__|.-----.-----.|  |_
-- |   ---|  ||  -__|     ||   _|
-- |______|__||_____|__|__||____|
--  __  __
-- |  |/  |.-----.--.--.-----.
-- |     < |  -__|  |  |__ --|
-- |__|\__||_____|___  |_____|
--               |_____|
-- ------------------------------------------------- --
local awful = require("awful")

local modkey = "Mod4"
local altkey = "Mod1"

require("awful.autofocus")
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local clientkeys =
  awful.util.table.join(
  -- ------------------------------------------------- --

  awful.key(
    {modkey, "Shift"},
    "f",
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    {description = "toggle fullscreen", group = "Window"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey},
    "x",
    function(c)
      c:kill()
    end,
    {description = "close", group = "Window"}
  ),
  -- ------------------------------------------------- --
  awful.key({modkey}, "f", awful.client.floating.toggle, {description = "toggle floating", group = "Window"}),
  -- ------------------------------------------------- --
  awful.key(
    {modkey, "Control", "Shift"},
    "m",
    function(c)
      c:swap(awful.client.getmaster())
    end,
    {description = "move to master", group = "Window"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey},
    "o",
    function(c)
      c:move_to_screen()
    end,
    {description = "move to screen", group = "Window"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey, "Shift"},
    "t",
    function(c)
      c.ontop = not c.ontop
    end,
    {description = "toggle keep on top", group = "Window"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey},
    "n",
    function(c)
      c.minimized = true
    end,
    {description = "minimize", group = "Window"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey},
    "m",
    function(c)
      c.maximized = not c.maximized
      c:raise()
    end,
    {description = "(un)maximize", group = "Window"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey, "Control"},
    "m",
    function(c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end,
    {description = "(un)maximize vertically", group = "Window"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey, altkey},
    "m",
    function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end,
    {description = "(un)maximize horizontally", group = "Window"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey},
    "Up",
    function(c)
      c:relative_move(0, dpi(-10), 0, 0)
    end,
    {description = "Move Floating Client up by 10px", group = "client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey},
    "Down",
    function(c)
      c:relative_move(0, dpi(10), 0, 0)
    end,
    {description = "Move Floating Client down by 10px", group = "client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey},
    "Left",
    function(c)
      c:relative_move(dpi(-10), 0, 0, 0)
    end,
    {description = "Move Floating Client to the Left by 10px", group = "client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey},
    "Right",
    function(c)
      c:relative_move(dpi(10), 0, 0, 0)
    end,
    {description = "Move Floating Client to the Right by 10px", group = "client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey, "Shift"},
    "Up",
    function(c)
      c:relative_move(0, dpi(-10), 0, dpi(10))
    end,
    {description = "Increase Floating Client Size Vertically by 10px up", group = "client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey, "Shift"},
    "Down",
    function(c)
      c:relative_move(0, 0, 0, dpi(10))
    end,
    {description = "Increase Floating Client Size Vertically by 10px down", group = "client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey, "Shift"},
    "Left",
    function(c)
      c:relative_move(dpi(-10), 0, dpi(10), 0)
    end,
    {description = "Increase Floating Client Size Horizontally by 10px Left", group = "client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey, "Shift"},
    "Right",
    function(c)
      c:relative_move(0, 0, dpi(10), 0)
    end,
    {description = "Increase Floating Client Size Horizontally by 10px Right", group = "client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey, "Control"},
    "Up",
    function(c)
      if c.height > 10 then
        c:relative_move(0, 0, 0, dpi(-10))
      end
    end,
    {description = "Decrease Floating Client Size Vertically by 10px up", group = "client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey, "Control"},
    "Down",
    function(c)
      local c_height = c.height
      c:relative_move(0, 0, 0, dpi(-10))
      if c.height ~= c_height and c.height > 10 then
        c:relative_move(0, dpi(10), 0, 0)
      end
    end,
    {description = "Decrease Floating Client Size Vertically by 10px down", group = "client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey, "Control"},
    "Left",
    function(c)
      if c.width > 10 then
        c:relative_move(0, 0, dpi(-10), 0)
      end
    end,
    {description = "Decrease Floating Client Size Horizontally by 10px Left", group = "client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey, "Control"},
    "Right",
    function(c)
      local c_width = c.width
      c:relative_move(0, 0, dpi(-10), 0)
      if c.width ~= c_width and c.width > 10 then
        c:relative_move(dpi(10), 0, 0, 0)
      end
    end,
    {description = "Decrease Floating Client Size Horizontally by 10px Right", group = "client"}
  )
)
-- ------------------------------------------------- --
return clientkeys
