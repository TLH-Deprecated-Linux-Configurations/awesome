-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Widget library
local wibox = require("wibox")

-- rubato
local rubato = require("module.rubato")

-- Get screen geometry
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height

-- control_center
------------

-- Helpers
local function centered_widget(widget)
  local w =
    wibox.widget {
    nil,
    {
      nil,
      widget,
      expand = "none",
      layout = wibox.layout.align.vertical
    },
    expand = "none",
    layout = wibox.layout.align.horizontal
  }

  return w
end

local function create_boxed_widget(widget_to_be_boxed, width, height, bg_color)
  local box_container = wibox.container.background()
  box_container.bg = bg_color
  box_container.forced_height = height
  box_container.forced_width = width
  box_container.shape = beautiful.client_shape_rounded

  local boxed_widget =
    wibox.widget {
    -- Add margins
    {
      -- Add background color
      {
        -- The actual widget goes here
        widget_to_be_boxed,
        top = dpi(9),
        bottom = dpi(9),
        left = dpi(10),
        right = dpi(10),
        widget = wibox.container.margin
      },
      widget = box_container
    },
    margins = dpi(10),
    color = "#00000000",
    widget = wibox.container.margin
  }

  return boxed_widget
end

-- Widget

local time = require("widget.control-center.time")
local date = require("widget.control-center.date")

local stats = require("widget.control-center.dials")
local notifs = require("widget.control-center.notifs")

local sliders = require("widget.control-center.sliders")
local buttons = require("widget.control-center.buttons")

local buttons_boxed = create_boxed_widget(buttons, dpi(425), dpi(125), beautiful.bg_normal)
local sliders_boxed = create_boxed_widget(sliders, dpi(375), dpi(250), beautiful.bg_normal)

local time_boxed = create_boxed_widget(centered_widget(time), dpi(260), dpi(120), beautiful.bg_normal)
local date_boxed = create_boxed_widget(centered_widget(date), dpi(120), dpi(120), beautiful.bg_normal)

local stats_boxed = create_boxed_widget(stats, dpi(400), dpi(490), beautiful.bg_normal)
local notifs_boxed = create_boxed_widget(notifs, dpi(380), dpi(355), beautiful.bg_normal)

-- Dashboard
control_center =
  wibox(
  {
    type = "splash",
    --[[ screen = mouse.screen, ]]
    height = screen_height,
    width = screen_width,
    ontop = true,
    visible = false,
    bg = "#1b1d2488"
  }
)

awful.placement.centered(control_center)

control_center:buttons(
  gears.table.join(
    -- Middle click - Hide control_center
    awful.button(
      {},
      2,
      function()
        control_center_hide()
      end
    )
  )
)

local slide =
  rubato.timed {
  pos = dpi(-1200),
  rate = 60,
  intro = 0.3,
  duration = 0.8,
  easing = rubato.quadratic,
  awestore_compat = true,
  subscribed = function(pos)
    control_center.x = pos
  end
}

local slide_strut =
  rubato.timed {
  pos = dpi(0),
  rate = 60,
  intro = 0.3,
  duration = 0.8,
  easing = rubato.quadratic,
  awestore_compat = true,
  subscribed = function(width)
    control_center:struts {left = width, right = 0, top = 0, bottom = 0}
  end
}

local control_center_status = false

slide.ended:subscribe(
  function()
    if control_center_status then
      control_center.visible = false
    end
  end
)

control_center_show = function()
  control_center.visible = true
  slide:set(0)
  slide_strut:set(1200)
  control_center_status = false
end

control_center_hide = function()
  slide:set(-1200)
  slide_strut:set(0)
  control_center_status = true
end

control_center_toggle = function()
  if control_center.visible then
    control_center_hide()
  else
    control_center_show()
  end
end

control_center:setup {
  {
    nil,
    {
      {
        {
          {
            time_boxed,
            date_boxed,
            layout = wibox.layout.fixed.horizontal
          },
          {
            layout = wibox.layout.fixed.horizontal,
            notifs_boxed
          },
          layout = wibox.layout.fixed.vertical
        },
        {
          buttons_boxed,
          stats_boxed,
          layout = wibox.layout.fixed.vertical
        },
        {
          layout = wibox.layout.fixed.vertical
        },
        layout = wibox.layout.fixed.horizontal
      },
      {
        sliders_boxed,
        layout = wibox.layout.fixed.horizontal
      },
      layout = wibox.layout.fixed.vertical
    },
    expand = "none",
    layout = wibox.layout.align.horizontal
  },
  margins = dpi(10),
  widget = wibox.container.margin
}
