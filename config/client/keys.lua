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
local snap_edge = require("utils.snap-edge")
-- numpad key codes 1-9
-- local numpad_map = {87, 88, 89, 83, 84, 85, 79, 80, 81}

require("awful.autofocus")
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
    {description = "Move Floating Client up by 10px", group = "Client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey},
    "Down",
    function(c)
      c:relative_move(0, dpi(10), 0, 0)
    end,
    {description = "Move Floating Client down by 10px", group = "Client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey},
    "Left",
    function(c)
      c:relative_move(dpi(-10), 0, 0, 0)
    end,
    {description = "Move Floating Client to the Left by 10px", group = "Client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey},
    "Right",
    function(c)
      c:relative_move(dpi(10), 0, 0, 0)
    end,
    {description = "Move Floating Client to the Right by 10px", group = "Client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey, "Shift"},
    "Up",
    function(c)
      c:relative_move(0, dpi(-10), 0, dpi(10))
    end,
    {description = "Increase Floating Client Size Vertically by 10px up", group = "Client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey, "Shift"},
    "Down",
    function(c)
      c:relative_move(0, 0, 0, dpi(10))
    end,
    {description = "Increase Floating Client Size Vertically by 10px down", group = "Client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey, "Shift"},
    "Left",
    function(c)
      c:relative_move(dpi(-10), 0, dpi(10), 0)
    end,
    {description = "Increase Floating Client Size Horizontally by 10px Left", group = "Client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey, "Shift"},
    "Right",
    function(c)
      c:relative_move(0, 0, dpi(10), 0)
    end,
    {description = "Increase Floating Client Size Horizontally by 10px Right", group = "Client"}
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
    {description = "Decrease Floating Client Size Vertically by 10px up", group = "Client"}
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
    {description = "Decrease Floating Client Size Vertically by 10px down", group = "Client"}
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
    {description = "Decrease Floating Client Size Horizontally by 10px Left", group = "Client"}
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
    {description = "Decrease Floating Client Size Horizontally by 10px Right", group = "Client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey, altkey},
    "Down",
    function(c)
      snap_edge(c, "bottom")
    end,
    {description = "Move Floating Client to the Bottom", group = "Client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey, altkey},
    "Left",
    function(c)
      snap_edge(c, "left")
    end,
    {description = "Move Floating Client to the Left", group = "Client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey, altkey},
    "Right",
    function(c)
      snap_edge(c, "right")
    end,
    {description = "Move Floating Client to the Right", group = "Client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey, altkey},
    "Up",
    function(c)
      snap_edge(c, "top")
    end,
    {description = "Move Floating Client to the Top", group = "Client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey, altkey, "Control"},
    "Down",
    function(c)
      snap_edge(c, "bottomright")
    end,
    {description = "Move Floating Client to the Bottom Right Corner", group = "Client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey, altkey, "Control"},
    "Left",
    function(c)
      snap_edge(c, "bottomleft")
    end,
    {description = "Move Floating Client to the Bottom Left Corner", group = "Client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey, altkey, "Control"},
    "Right",
    function(c)
      snap_edge(c, "topright")
    end,
    {description = "Move Floating Client to the Top Left Corner", group = "Client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {modkey, altkey, "Control"},
    "Up",
    function(c)
      snap_edge(c, "topleft")
    end,
    {description = "Move Floating Client to the Top Left", group = "Client"}
  )
)
-- -- Snap to edge/corner - Use numpad
-- awful.key({ modkey, "Shift" }, "#" .. numpad_map[1], function (c) snap_edge(c, 'bottomleft') end),
-- awful.key({ modkey, "Shift" }, "#" .. numpad_map[2], function (c) snap_edge(c, 'bottom') end),
-- awful.key({ modkey, "Shift" }, "#" .. numpad_map[3], function (c) snap_edge(c, 'bottomright') end),
-- awful.key({ modkey, "Shift" }, "#" .. numpad_map[4], function (c) snap_edge(c, 'left') end),
-- awful.key({ modkey, "Shift" }, "#" .. numpad_map[5], function (c) snap_edge(c, 'center') end),
-- awful.key({ modkey, "Shift" }, "#" .. numpad_map[6], function (c) snap_edge(c, 'right') end),
-- awful.key({ modkey, "Shift" }, "#" .. numpad_map[7], function (c) snap_edge(c, 'topleft') end),
-- awful.key({ modkey, "Shift" }, "#" .. numpad_map[8], function (c) snap_edge(c, 'top') end),
-- awful.key({ modkey, "Shift" }, "#" .. numpad_map[9], function (c) snap_edge(c, 'topright') end),
-- ------------------------------------------------- --
return clientkeys
