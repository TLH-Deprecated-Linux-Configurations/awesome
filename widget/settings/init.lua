local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local icons = require("theme.icons")
root.elements = root.elements or {}
root.elements.hub_views = root.elements.hub_views or {}

local function close_views()
  gears.table.map(
    function(v)
      v.view.visible = false
      v.title.font = beautiful.font .. " 18"
    end,
    root.elements.hub_views
  )
end

local function enable_view_by_index(i, s, loc)
  if root.elements.hub_views[i] then
    close_views()
    root.elements.hub_views[i].view.visible = true
    root.elements.hub_views[i].title.font = beautiful.font .. " 18"
    if root.elements.hub_views[i].view.refresh then
      root.elements.hub_views[i].view.refresh()
    end
    if not s then
      return
    end
    if loc == "right" then
      root.elements.hub.x = (s.workarea.width - beautiful.modal_width - 10) + s.workarea.x
    else
      root.elements.hub.x = ((s.workarea.width / 2) - (beautiful.modal_width / 2)) + s.workarea.x
    end
    root.elements.hub.visible = true
  end
end

local function make_view(i, t, v, a)
  local button = wibox.container.background()
  button.forced_height = 10 + 40 + 10

  local icon = wibox.widget.imagebox(i)
  icon.forced_height = 40
  icon.forced_width = 40
  icon.align = "center"
  icon.font = beautiful.font .. " 10"

  local title = wibox.widget.textbox(t)
  if a == nil then
    title.font = beautiful.font .. " 13"
  else
    title.font = beautiful.font .. " 21"
  end

  local view = wibox.container.margin()
  view.margins = 10
  if a == nil then
    view.visible = false
  else
    view.visible = true
  end

  if (v == nil) then
    view:setup {
      layout = wibox.container.place,
      valign = "center",
      halign = "center",
      {
        layout = wibox.container.background,
        fg = beautiful.xcolor0,
        wibox.widget.textbox(t)
      }
    }
  else
    view = v
  end

  button:connect_signal(
    "mouse::enter",
    function()
      button.bg = beautiful.bg_modal .. "66"
    end
  )
  button:connect_signal(
    "mouse::leave",
    function()
      button.bg = beautiful.xcolor0 .. "00"
    end
  )
  button:buttons(
    gears.table.join(
      awful.button(
        {},
        1,
        function()
          close_views()
          view.visible = true
          title.font = beautiful.font .. " 18"
          if view.refresh then
            view.refresh()
          end
        end
      )
    )
  )
  button:setup {
    layout = wibox.container.margin,
    margins = 10,
    {
      layout = wibox.layout.align.horizontal,
      icon,
      {
        layout = wibox.container.margin,
        left = 10,
        title
      }
    }
  }

  return {link = button, view = view, title = title}
end

local function make_nav()
  local navbg =
    gears.color(
    {
      type = "linear",
      from = {15, 15},
      to = {260, beautiful.modal_height},
      stops = {{0, beautiful.xcolor7 .. "66"}, {0.25, beautiful.xcolor20 .. '66'}, {0.5, beautiful.xcolor0 .. '66'}, {0.75, beautiful.xcolor17 .. '66'}, {1, beautiful.xcolor8 .. "66"}}
    }
  )

  local nav = wibox.container.background()
  nav.bg = navbg
  nav.forced_width = 260

  local user = wibox.widget.textbox
  user.font = beautiful.font .. " 12"
  awful.spawn.easy_async_with_shell('whoami', function(u) user.text = u:gsub("^%s*(.-)%s*$", "%1") end);

  local avatar =
    wibox.widget {
    layout = wibox.container.background,
    shape = gears.shape.circle,
    shape_clip = gears.shape.circle,
    forced_width = 40,
    forced_height = 40,
    {
      widget = wibox.widget.imagebox,
      image = gears.filesystem.get_configuration_dir() .. "theme/icons/user.svg",
      resize = true
    }
  }

  local rule = wibox.container.background()
  rule.forced_height = 1
  rule.bg = beautiful.xbackground .. "66"
  rule.widget = wibox.widget.base.empty_widget()

  table.insert(root.elements.hub_views, make_view(icons.memory, "system", require("widget.settings.system")()))

  table.insert(root.elements.hub_views, make_view(icons.wifi, "connections", require("widget.settings.connections")()))
  table.insert(root.elements.hub_views, make_view(icons.brush, "display", require("widget.settings.display")()))
  table.insert(root.elements.hub_views, make_view(icons.music, "media", require("widget.settings.media")()))

  local header = wibox.container.margin()
  header.margins = 10
  header.forced_height = 10 + 40 + 10
  header:setup {
    layout = wibox.layout.align.horizontal,
    {
      layout = wibox.container.margin,
      avatar,
      user
    },
  }

  local nav_container = wibox.layout.fixed.vertical()
  nav_container.forced_width = 260
  nav_container.forced_height = beautiful.modal_height
  nav_container:add(header)
  nav_container:add(rule)
  gears.table.map(
    function(v)
      nav_container:add(v.link)
    end,
    root.elements.hub_views
  )

  local power = wibox.container.background()
  power.bg = beautiful.xcolor1
  power.shape = function(cr, rect_width, rect_height)
    gears.shape.partially_rounded_rect(cr, rect_width, rect_height, true, true, true, true, 14)
  end
  power.forced_height = 40
  power:setup {
    layout = wibox.container.place,
    halign = "center",
    {
      widget = wibox.widget.textbox,
      text = "",
      font = beautiful.font .. " 48"
    }
  }
  power:buttons(
    gears.table.join(
      awful.button(
        {},
        1,
        function()
          if root.elements.powermenu.show then
            root.elements.powermenu.show()
          end
        end
      )
    )
  )

  nav:setup {
    layout = wibox.container.place,
    {
      layout = wibox.layout.align.vertical,
      wibox.widget.base.empty_widget(),
      nav_container,
      {
        layout = wibox.container.margin,
        margins = 10,
        power
      }
    }
  }

  return nav
end

return function()
  local hub =
    wibox(
    {
      ontop = true,
      visible = false,
      type = "toolbar",
      bg = beautiful.bg_modal .. "aa",
      width = beautiful.modal_width,
      height = beautiful.modal_height,
      screen = awful.screen.primary
    }
  )

  local nav = make_nav()
  local view_container = wibox.layout.stack()
  gears.table.map(
    function(v)
      view_container:add(v.view)
    end,
    root.elements.hub_views
  )

  hub:buttons(
    gears.table.join(
      awful.button(
        {},
        3,
        function()
          hub.visible = false
        end
      )
    )
  )

  hub.y = 98 + (10 * 2)
  hub:setup {
    layout = wibox.layout.flex.vertical,
    {
      layout = wibox.layout.align.horizontal,
      nav,
      view_container
    }
  }

  hub.close = function()
    hub.visible = false
  end
  hub.enable_view_by_index = enable_view_by_index
  hub.close_views = close_views
  hub.make_view = make_view

  close_views()
  root.elements.hub = hub
end
