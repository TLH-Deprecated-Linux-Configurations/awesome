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
-- _G.client.focus = c

local capi = {
  screen = screen,
  client = client
}

-- ------------------------------------------------- --
local snapmap = {
  -- ------------------------------------------------- --
  {"separator", " "},
  {"separator", "Snapping by Side"},
  {"separator", " "},
  -- ------------------------------------------------- --
  {
    "Down",
    function(c)
      snap_edge(capi.client.focus, "bottom")
    end,
    "Snap to Bottom"
  },
  -- ------------------------------------------------- --
  {
    "Left",
    function(c)
      snap_edge(capi.client.focus, "left")
    end,
    "Snap to Left"
  },
  -- ------------------------------------------------- --
  {
    "Right",
    function(c)
      snap_edge(capi.client.focus, "right")
    end,
    "Snap to Right"
  },
  -- ------------------------------------------------- --
  {
    "Up",
    function(c)
      snap_edge(capi.client.focus, "top")
    end,
    "Snap to Top"
  },
  -- ------------------------------------------------- --
  {"separator", "Corner Snapping"},
  {"separator", " "},
  -- ------------------------------------------------- --
  {
    "j",
    function(c)
      snap_edge(capi.client.focus, "bottomright")
    end,
    "Snap to Bottom Right"
  },
  -- ------------------------------------------------- --
  {
    "k",
    function(c)
      snap_edge(capi.client.focus, "bottomleft")
    end,
    "Snap to Bottom Left"
  },
  -- ------------------------------------------------- --
  {
    "l",
    function(c)
      snap_edge(capi.client.focus, "topright")
    end,
    "Snap to Top Right"
  },
  -- ------------------------------------------------- --
  {
    "h",
    function(c)
      snap_edge(capi.client.focus, "topleft")
    end,
    "Snap to Top Left"
  },
  {"separator", " "}
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local resizemap = {
  {"separator", " "},
  {"separator", "Increase Client Size"},
  {"separator", " "},
  {
    "h",
    function(c)
      capi.client.focus:relative_move(0, dpi(10), 0, dpi(0))
    end,
    "Increase Size Vertically by 10"
  },
  -- ------------------------------------------------- --
  {
    "j",
    function(c)
      capi.client.focus:relative_move(0, 0, 0, dpi(10))
    end,
    "Increase floating size by 10 vertically"
  },
  -- ------------------------------------------------- --
  {
    "k",
    function(c)
      capi.client.focus:relative_move(dpi(10), 0, dpi(), 0)
    end,
    "Increase Size Horizontally by 10"
  },
  -- ------------------------------------------------- --
  {
    "l",
    function(c)
      capi.client.focus:relative_move(0, 0, dpi(10), 0)
    end,
    "Increase Size Horizontally by 10"
  },
  -- ------------------------------------------------- --
  {"separator", "Decrease Client Size"},
  {"separator", " "},
  -- ------------------------------------------------- --
  {
    "Up",
    function(c)
      if capi.client.focus.height > 10 then
        capi.client.focus:relative_move(0, 0, 0, dpi(-10))
      end
    end,
    "Decrease floating size by 10"
  },
  -- ------------------------------------------------- --
  {
    "Down",
    function(c)
      capi.client.focus:relative_move(0, 0, 0, dpi(-10))
      if capi.client.focus.height > 10 then
        capi.client.focus:relative_move(0, dpi(10), 0, 0)
      end
    end,
    "Decrease Size Vertically by 10"
  },
  -- ------------------------------------------------- --
  {
    "Left",
    function(c)
      if capi.client.focus.width > 10 then
        capi.client.focus:relative_move(0, 0, dpi(-10), 0)
      end
    end,
    "Decrease Size Horizontally by 10"
  },
  -- ------------------------------------------------- --
  {
    "Right",
    function(c)
      capi.client.focus:relative_move(0, 0, dpi(-10), 0)
      if capi.client.focus.width > 10 then
        capi.client.focus:relative_move(dpi(10), 0, 0, 0)
      end
    end,
    "Decrease Size Horizontally 10"
  },
  {"separator", " "}
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --

local movemap = {
  {"separator", " "},
  -- ------------------------------------------------- --
  {
    "Up",
    function(c)
      capi.client.focus:relative_move(0, dpi(-10), 0, 0)
    end,
    "Move Client Up"
  },
  -- ------------------------------------------------- --
  {
    "Down",
    function(c)
      capi.client.focus:relative_move(0, dpi(10), 0, 0)
    end,
    "Move Client Down"
  },
  -- ------------------------------------------------- --
  {
    "Left",
    function(c)
      capi.client.focus:relative_move(dpi(-10), 0, 0, 0)
    end,
    "Move Client Left"
  },
  -- ------------------------------------------------- --
  {
    "Right",
    function(c)
      capi.client.focus:relative_move(dpi(10), 0, 0, 0)
    end,
    "Move Client Right"
  },
  -- ------------------------------------------------- --
  {"separator", " "}
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local clientmap = {
  -- ------------------------------------------------- --
  {"separator", "Client Positioning"},
  {"separator", " "},
  -- ------------------------------------------------- --
  {
    "b",
    function(c)
      capi.client.focus:swap(awful.client.getmaster())
    end,
    "Move to Master"
  },
  -- ------------------------------------------------- --
  {
    "o",
    function(c)
      capi.client.focus:move_to_screen()
    end,
    "Move to Screen"
  },
  -- ------------------------------------------------- --
  {
    "t",
    function()
      c.ontop = not c.ontop
    end,
    "Toggle Client On Top"
  },
  -- ------------------------------------------------- --
  {
    "n",
    function()
      c.minimized = true
    end,
    "Minimize Client"
  },
  -- ------------------------------------------------- --
  {
    "x",
    function()
      capi.client.focus:kill()
    end,
    "Close Client"
  },
  -- ------------------------------------------------- --
  {
    "d",
    function()
      capi.client.focus.floating = not capi.client.focus.floating
    end,
    "Toggle Floating Client"
  },
  -- ------------------------------------------------- --
  {"separator", "Maximize Client"},
  {"separator", " "},
  -- ------------------------------------------------- --
  {
    "m",
    function()
      capi.client.focus.maximized = not capi.client.focus.maximized
      capi.client.focus:raise()
    end,
    "Maximize Client"
  },
  -- ------------------------------------------------- --
  {
    "h",
    function()
      capi.client.focus.maximized_horizontal = not capi.client.focus.maximized
      capi.client.focus:raise()
    end,
    "Maximize Client Horizontally"
  },
  -- ------------------------------------------------- --
  {
    "v",
    function()
      capi.client.focus.maximized_vetical = not capi.client.focus.maximized_vertical
      capi.client.focus:raise()
    end,
    "Maximize Client"
  },
  {
    "f",
    function(c)
      c.fullscreen = not c.fullscreen
      capi.client.focus:raise()
    end,
    "Toggle Fullscreen"
  },
  -- ------------------------------------------------- --
  {"separator", " "}
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Now we call modalbinding from utils to make the above useful
local modalbind = require("utils.modalbind")
modalbind.init()
modalbind.set_opacity = 0.95

-- numpad key codes 1-9
-- local numpad_map = {87, 88, 89, 83, 84, 85, 79, 80, 81}

require("awful.autofocus")
-- ------------------------------------------------- --
local clientkeys =
  awful.util.table.join(
  -- modals use alt + key to activate
  awful.key(
    {"Mod1"},
    "r",
    function()
      modalbind.grab {keymap = resizemap, name = "Window Resizing", stay_in_mode = true}
    end,
    {description = "Enter Window Resizing Mode", group = "Floating Client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {"Mod1"},
    "s",
    function()
      modalbind.grab {keymap = snapmap, name = "Window Snapping", stay_in_mode = true}
    end,
    {description = "Enter Window Snapping Mode", group = "Floating Client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {"Mod1"},
    "m",
    function()
      modalbind.grab {keymap = movemap, name = "Window Movement", stay_in_mode = true}
    end,
    {description = "Enter Window Movement Mode", group = "Floating Client"}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {"Mod1"},
    "c",
    function()
      modalbind.grab {keymap = clientmap, name = "Client Control", stay_in_mode = false}
    end,
    {description = "Enter Client Control Mode", group = "Client"}
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
