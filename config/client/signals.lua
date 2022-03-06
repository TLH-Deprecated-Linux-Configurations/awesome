--  ______ __ __               __
-- |      |  |__|.-----.-----.|  |_
-- |   ---|  |  ||  -__|     ||   _|
-- |______|__|__||_____|__|__||____|

--  _______ __                     __
-- |     __|__|.-----.-----.---.-.|  |
-- |__     |  ||  _  |     |  _  ||  |
-- |_______|__||___  |__|__|___._||__|
--             |_____|
-- ------------------------------------------------- --

-- ------------------------------------------------- --
local update_client = function(c)
  -- Set client's shape based on its tag's layout and status (floating, maximized, etc.)
  --
  if c.fullscreen then
    c.shape = beautiful.client_shape_rectangle
  else
    c.shape = beautiful.client_shape_rounded
  end
end

-- ------------------------------------------------- --
client.connect_signal(
  "request::manage",
  function(c)
    -- Fade in animation (fade out is in keys)

    if not c.icon then
      local i = gears.surface(gfs.get_configuration_dir() .. "icons/ghosts/awesome.png")
      c.icon = i._native
    end

    local fade_in =
      awestore.tweened(
      0,
      {
        duration = beautiful.fade_duration,
        easing = awestore.easing.linear
      }
    )
    local unsub =
      fade_in:subscribe(
      function(o)
        if c and c.valid then
          c.opacity = o / 20
        end
      end
    )
    fade_in:set(20)
    fade_in.ended:subscribe(
      function()
        unsub()
      end
    )
    -- ------------------------------------------------- --
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end
    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
        awful.placement.no_overlap(c)

        awful.placement.centered(c)
      end
    end
  end
)
-- ------------------------------------------------- --
client.connect_signal(
  "manage",
  function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
    end
  end
)
-- ------------------------------------------------- --
-- Enable sloppy focus, so that focus follows mouse. BUT don't raise the window, Lord help me that is annoying when trying to access a popup window within another window
client.connect_signal(
  "mouse::enter",
  function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
  end
)
-- ------------------------------------------------- --
client.connect_signal(
  "focus",
  function(c)
    c.border_color = beautiful.border_focus
  end
)
-- ------------------------------------------------- --
client.connect_signal(
  "unfocus",
  function(c)
    c.border_color = beautiful.border_normal
  end
)

-- ------------------------------------------------- --
-- Manipulate client shape on floating
client.connect_signal(
  "property::floating",
  function(c)
    if c.floating then
      c.shape = beautiful.client_shape_rounded
      awful.placement.no_offscreen(c)
      awful.placement.centered(c)
      c.screen = awful.screen.focused()
    end
  end
)
-- ------------------------------------------------- --
-- Manipulate client shape on fullscreen/non-fullscreen
client.connect_signal(
  "property::fullscreen",
  function(c)
    if c.fullscreen then
      c.shape = beautiful.client_shape_rectangle
    else
      update_client(c)
    end
  end
)
-- ------------------------------------------------- --
-- Manipulate client shape on fullscreen/non-fullscreen
client.connect_signal(
  "property::maximized",
  function(c)
    if c.maximized then
      c.shape = beautiful.client_shape_rectangle
    else
      update_client(c)
    end
  end
)
-- ------------------------------------------------- --
-- Set mouse resize mode (live or after)
awful.mouse.resize.set_mode("live")
-- ------------------------------------------------- --
-- Restore geometry for floating clients
-- (for example after swapping from tiling mode to floating mode)

tag.connect_signal(
  "property::layout",
  function(t)
    for k, c in ipairs(t:clients()) do
      if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
        local cgeo = awful.client.property.get(c, "floating_geometry")
        if cgeo then
          c:geometry(awful.client.property.get(c, "floating_geometry"))
        end
      end
    end
  end
)

client.connect_signal(
  "manage",
  function(c)
    if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
      awful.client.property.set(c, "floating_geometry", c:geometry())
    end
  end
)

client.connect_signal(
  "property::geometry",
  function(c)
    if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
      awful.client.property.set(c, "floating_geometry", c:geometry())
    end
  end
)
