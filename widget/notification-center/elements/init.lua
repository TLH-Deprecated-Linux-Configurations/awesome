--  _______ __                              __
-- |    ___|  |.-----.--------.-----.-----.|  |_.-----.
-- |    ___|  ||  -__|        |  -__|     ||   _|__ --|
-- |_______|__||_____|__|__|__|_____|__|__||____|_____|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- declare widget
local elements = {}

-- ------------------------------------------------- --
--  widget constructor
elements.create = function(title, message)
  -- ------------------------------------------------- --
  -- box element
  local box = {}

  local clearIcon =
    wibox.widget {
    layout = wibox.layout.align.vertical,
    expand = "none",
    nil,
    {
      id = "icon",
      image = icons.clearNotificationIndividual,
      resize = true,
      widget = wibox.widget.imagebox
    },
    nil
  }
  -- ------------------------------------------------- --
  -- clear element
  local clear =
    wibox.widget {
    {
      {
        {
          clearIcon,
          layout = wibox.layout.fixed.horizontal
        },
        margins = dpi(9),
        widget = wibox.container.margin
      },
      forced_height = dpi(50),
      forced_width = dpi(50),
      widget = clickable_container
    },
    shape = beautiful.client_shape_rounded_small,
    bg = beautiful.bg_normal,
    widget = wibox.container.background
  }
  -- ------------------------------------------------- --
  -- clear connect signal for mouse entry
  clear:connect_signal(
    "mouse::enter",
    function()
      clear.bg = beautiful.bg_focus
    end
  )
  -- ------------------------------------------------- --
  -- clear mouse signal for departure
  clear:connect_signal(
    "mouse::leave",
    function()
      clear.bg = beautiful.bg_normal
    end
  )
  -- ------------------------------------------------- --
  -- clear button bindings
  clear:buttons(
    gears.table.join(
      awful.button(
        {},
        1,
        nil,
        function()
          _G.removeElement(box)
        end
      )
    )
  )
  -- ------------------------------------------------- --
  -- notification icon template
  local notifIcon =
    wibox.widget {
    {
      {
        {
          layout = wibox.layout.align.vertical,
          expand = "none",
          nil,
          {
            image = icons.notifications,
            widget = wibox.widget.imagebox
          },
          nil
        },
        margins = dpi(5),
        widget = wibox.container.margin
      },
      shape = gears.shape.rect,
      bg = beautiful.bg_normal,
      widget = wibox.container.background
    },
    forced_width = dpi(90),
    forced_height = dpi(90),
    widget = clickable_container
  }
  -- ------------------------------------------------- --
  -- notification content template
  local content =
    wibox.widget {
    {
      {
        {
          text = title,
          font = "Nineteen Ninety Seven  Regular  10",
          widget = wibox.widget.textbox
        },
        {
          text = message,
          font = "Nineteen Ninety Seven  8",
          widget = wibox.widget.textbox
        },
        layout = wibox.layout.align.vertical
      },
      margins = dpi(10),
      widget = wibox.container.margin
    },
    shape = gears.shape.rect,
    bg = beautiful.bg_normal,
    widget = wibox.container.background
  }
  -- ------------------------------------------------- --
  -- box element template
  box =
    wibox.widget {
    {
      notifIcon,
      content,
      {
        {
          clear,
          align = "center",
          forced_height = 30,
          layout = wibox.layout.align.vertical
        },
        margins = dpi(5),
        widget = wibox.container.margin
      },
      layout = wibox.layout.align.horizontal
    },
    shape = beautiful.client_shape_rounded,
    fg = colors.white,
    border_width = dpi(1),
    border_color = beautiful.bg_normal,
    widget = wibox.container.background
  }

  return box
end

return elements
