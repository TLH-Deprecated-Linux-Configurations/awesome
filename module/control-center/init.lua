-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Widget library
local wibox = require("wibox")

-- rubato

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
local battery = require("widget.control-center.battery")
local sliders = require("widget.control-center.sliders")
-- local buttons = require("widget.control-center.buttons")
local bluetooth = require("widget.control-center.bluetooth.")
local end_session = require("widget.control-center.end-session")
local network = require("widget.control-center.network")
local fortune = require("widget.control-center.fortune")
local bar_button = require("widget.control-center.buttons.bar-button")
local do_not_disturb = require("widget.control-center.buttons.do-not-disturb")
local dropbox = require("widget.control-center.buttons.dropbox-toggle")
local bookmarks = require("widget.control-center.bookmarks")
local mute = require("widget.control-center.buttons.mute-button")
local restart = require("widget.control-center.buttons.restart-awesome")
local screen_capture = require("widget.control-center.buttons.screen-capture")
local urls = require("widget.control-center.urls")

local url_boxed = create_boxed_widget(urls, dpi(400), dpi(300), "#00000000")
local screen_capture_boxed = create_boxed_widget(screen_capture, dpi(120), dpi(120), beautiful.bg_normal)
local restart_boxed = create_boxed_widget(restart, dpi(120), dpi(120), beautiful.bg_normal)
local mute_button_boxed = create_boxed_widget(mute, dpi(120), dpi(120), beautiful.bg_normal)
local bar_button_boxed = create_boxed_widget(bar_button, dpi(120), dpi(120), beautiful.bg_normal)
local do_not_disturb_boxed = create_boxed_widget(do_not_disturb, dpi(120), dpi(120), beautiful.bg_normal)
local dropbox_boxed = create_boxed_widget(dropbox, dpi(120), dpi(120), beautiful.bg_normal)
local bookmarks_boxed = create_boxed_widget(bookmarks, dpi(400), dpi(200), beautiful.bg_normal)
local fortune_boxed = create_boxed_widget(fortune, dpi(450), dpi(300), beautiful.bg_normal)
local network_boxed = create_boxed_widget(network, dpi(450), dpi(650), beautiful.bg_normal)
local end_session_boxed = create_boxed_widget(end_session, dpi(200), dpi(120), beautiful.bg_normal)
-- local buttons_boxed = create_boxed_widget(buttons, dpi(450), dpi(120), beautiful.bg_normal)
local sliders_boxed = create_boxed_widget(sliders, dpi(450), dpi(275), beautiful.bg_normal)
local bluetooth_boxed = create_boxed_widget(bluetooth, dpi(450), dpi(350), beautiful.bg_normal)
local time_boxed = create_boxed_widget(centered_widget(time), dpi(250), dpi(120), beautiful.bg_normal)
local date_boxed = create_boxed_widget(centered_widget(date), dpi(200), dpi(120), beautiful.bg_normal)
local battery_boxed = create_boxed_widget(battery, dpi(250), dpi(120), beautiful.bg_normal)
local stats_boxed = create_boxed_widget(stats, dpi(450), dpi(490), beautiful.bg_normal)
local notifs_boxed = create_boxed_widget(notifs, dpi(450), dpi(400), beautiful.bg_normal)

-- Dashboard
control_center =
  wibox(
  {
    type = "splash",
    screen = mouse.screen,
    height = screen_height,
    width = screen_width,
    ontop = true,
    visible = false,
    bg = colors.alpha(colors.blacker, "88")
  }
)
backdrop =
  wibox(
  {
    type = "splash",
    height = screen_height,
    width = screen_width,
    ontop = true,
    visible = false,
    bg = colors.alpha(colors.blacker, "88")
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
backdrop:buttons(
  gears.table.join(
    -- Middle click - Hide control_center
    awful.button(
      {},
      1,
      function()
        control_center_hide()
      end
    ),
    awful.button(
      {},
      2,
      function()
        control_center_hide()
      end
    ),
    awful.button(
      {},
      3,
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
  intro = 0.15,
  duration = 0.4,
  easing = rubato.bouncy,
  awestore_compat = true,
  subscribed = function(pos)
    control_center.x = pos
  end
}

local slide_strut =
  rubato.timed {
  pos = dpi(0),
  rate = 60,
  intro = 0.1,
  duration = 0.3,
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
  awful.screen.connect_for_each_screen(
    function(s)
      backdrop.visible = true
    end
  )
  awesome.emit_signal("bluetooth::power:refresh")
  awesome.emit_signal("bluetooth::devices:refreshPanel")
  awesome.emit_signal("network::networks:refreshPanel")
  control_center.visible = true
  slide:set(0)
  slide_strut:set(1200)
  control_center_status = false
end

control_center_hide = function()
  slide:set(-1200)
  slide_strut:set(0)
  control_center_status = true
  awful.screen.connect_for_each_screen(
    function(s)
      backdrop.visible = false
    end
  )
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
    {
      widget = wibox.container.margin,
      layout = wibox.layout.fixed.vertical,
      network_boxed,
      fortune_boxed
    },
    -- ------------------------------------------------- --
    {
      {
        {
          {
            time_boxed,
            date_boxed,
            layout = wibox.layout.fixed.horizontal
          },
          sliders_boxed,
          notifs_boxed,
          {
            battery_boxed,
            end_session_boxed,
            layout = wibox.layout.fixed.horizontal
          },
          layout = wibox.layout.fixed.vertical
        },
        {
          stats_boxed,
          -- buttons_boxed,
          {
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(20),
            bar_button_boxed,
            do_not_disturb_boxed,
            dropbox_boxed
          },
          {
            layout = wibox.layout.fixed.horizontal,
            mute_button_boxed,
            restart_boxed,
            spacing = dpi(20),
            screen_capture_boxed
          },
          bookmarks_boxed,
          layout = wibox.layout.fixed.vertical
        },
        {
          layout = wibox.layout.fixed.vertical,
          url_boxed,
          bluetooth_boxed
        },
        layout = wibox.layout.fixed.horizontal
      },
      {
        layout = wibox.layout.fixed.vertical
      },
      layout = wibox.layout.fixed.vertical
    },
    expand = "none",
    layout = wibox.layout.fixed.horizontal
  },
  margins = dpi(10),
  widget = wibox.container.margin
}
