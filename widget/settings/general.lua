
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local configWriter = require("lib-tde.config-writer")
local configFile = os.getenv("HOME") .. "/.config/tos/general.conf"
local dpi = beautiful.xresources.apply_dpi
local icons = require("theme.icons")
local slider = require("lib-widget.slider")
local seperator_widget = require("lib-widget.separator")
local signals = require("lib-tde.signals")
local card = require("lib-widget.card")
local button = require("lib-widget.button")
local checkbox = require("lib-widget.checkbox")
local datetime = require("lib-tde.function.datetime")

local m = dpi(5)
local settings_index = dpi(40)
local settings_width = dpi(1100)
local settings_nw = dpi(260)

local button_widgets = {}
local primary_theme = beautiful.primary

signals.connect_primary_theme_changed(
  function(new_theme)
    primary_theme = new_theme
  end
)

local function create_multi_option_array(name, tooltip, options, default, configOption)
  local name_widget =
    wibox.widget {
    text = name,
    font = beautiful.title_font,
    widget = wibox.widget.textbox
  }
  awful.tooltip {
    objects = {name_widget},
    timer_function = function()
      return tooltip
    end
  }
  local layout = wibox.layout.flex.horizontal()
  layout.forced_width = settings_width - settings_nw
  layout:add(name_widget)
  button_widgets[name] = {}
  for _, option in ipairs(options) do
    -- leave focus button callback
    local leave = function()
      if button_widgets[name][option].active then
        button_widgets[name][option].bg = primary_theme.hue_600
      else
        button_widgets[name][option].bg = beautiful.bg_modal
      end
    end

    -- the button object
    local option_widget
    option_widget =
      button(
      option,
      function()
        print("Pressed button")
        for _, widget in pairs(button_widgets[name]) do
          widget.bg = beautiful.bg_modal
          widget.active = false
        end
        option_widget.bg = primary_theme.hue_800
        option_widget.active = true
        configWriter.update_entry(configFile, configOption, option)
      end,
      nil,
      nil,
      nil,
      leave
    )

    option_widget.forced_height = settings_index * 0.7

    if option == default then
      option_widget.active = true
    else
      option_widget.bg = beautiful.bg_modal
    end

    button_widgets[name][option] = option_widget
    layout:add(wibox.container.margin(option_widget, m, m, m, m))
  end
  return layout
end

local function create_checkbox(name, tooltip, checked, configOption, on, off)
  local name_widget =
    wibox.widget {
    text = name,
    font = beautiful.title_font,
    widget = wibox.widget.textbox
  }
  local box =
    checkbox(
    checked,
    function(box_checked)
      local value = off or "0"
      if box_checked then
        value = on or "1"
      end
      configWriter.update_entry(configFile, configOption, value)
    end,
    settings_index * 0.7
  )

  awful.tooltip {
    objects = {name_widget},
    timer_function = function()
      return tooltip
    end
  }

  return wibox.container.margin(
    wibox.widget {
      layout = wibox.layout.align.horizontal,
      wibox.container.margin(name_widget, m),
      nil,
      wibox.container.margin(box, 0, m)
    },
    m,
    m,
    m,
    m
  )
end

local function create_option_slider(title, min, max, inc, option, start_value, callback, tooltip_callback)
  local option_slider =
    slider(
    min,
    max,
    inc,
    start_value,
    function(value)
      callback(value)
      configWriter.update_entry(configFile, option, tostring(value))
    end,
    tooltip_callback
  )

  return wibox.widget {
    layout = wibox.layout.align.horizontal,
    wibox.container.margin(wibox.widget.textbox(title), 0, m),
    option_slider,
    forced_height = dpi(30)
  }
end

return function()
  local view = wibox.container.margin()
  view.left = m
  view.right = m

  local title = wibox.widget.textbox(i18n.translate("General"))
  title.font = beautiful.title_font
  title.forced_height = settings_index + m + m

  local close = wibox.widget.imagebox(icons.close)
  close.forced_height = settings_index
  close:buttons(
    gears.table.join(
      awful.button(
        {},
        1,
        function()
          if root.elements.settings then
            root.elements.settings.close()
          end
        end
      )
    )
  )

  local save =
    button(
    "Update",
    function()
      print("Saving general settings")
      -- reload TDE
      awesome.restart()
    end
  )

  local separator = seperator_widget(settings_index / 1.5)

  local checkbox_widget =
    wibox.widget {
    layout = wibox.layout.flex.vertical,
    create_checkbox(
      i18n.translate("Audio popup"),
      i18n.translate("Enable the 'pop' sound when changing the audio"),
      general["audio_change_sound"] == "1",
      "audio_change_sound"
    ),
    create_checkbox(
      i18n.translate("Error data opt out"),
      i18n.translate("Send error messages to the developers, this is useful for debugging and reducing errors/bugs"),
      general["tde_opt_out"] == "1",
      "tde_opt_out"
    ),
    create_checkbox(
      i18n.translate("Titlebar drawing"),
      i18n.translate("Draw the titlebar above every application"),
      general["draw_mode"] == "fast",
      "draw_mode",
      "fast",
      "none"
    ),
    create_checkbox(
      i18n.translate("Screen timeout"),
      i18n.translate("Put the system in sleep mode after a period of inactivity"),
      general["screen_timeout"] == "1" or general["screen_timeout"] == nil,
      "screen_timeout"
    ),
    create_checkbox(
      i18n.translate("Disable Desktop"),
      i18n.translate("When enabled we don't draw icons or anything on the desktop"),
      general["disable_desktop"] == "1",
      "disable_desktop"
    ),
    create_checkbox(
      i18n.translate("Weak Hardware"),
      i18n.translate("Disable a lot of the 'nice' features in order to reduce hardware consumption"),
      general["weak_hardware"] == "1",
      "weak_hardware"
    ),
    create_checkbox(
      i18n.translate("Autofocus"),
      i18n.translate("Automatically make the focus follow the mouse without clicking"),
      general["autofocus"] == "1",
      "autofocus"
    ),
    create_checkbox(
      i18n.translate("Minimize Network Usage"),
      i18n.translate("Disable a lot of network utilities to reduce network usage"),
      general["minimize_network_usage"] == "1",
      "minimize_network_usage"
    )
  }

  local multi_option_widget =
    wibox.widget {
    create_multi_option_array(
      i18n.translate("Tagbar anchor location"),
      i18n.translate("The location where you want the tagbar to appear (default bottom)"),
      {"bottom", "right", "left"},
      general["tag_bar_anchor"] or "bottom",
      "tag_bar_anchor"
    ),
    create_multi_option_array(
      i18n.translate("Tagbar bar draw location"),
      i18n.translate("Draw the tagbar either on all screens, the main screen or don't draw it at all"),
      {"all", "main", "none"},
      general["tag_bar_draw"] or "all",
      "tag_bar_draw"
    ),
    create_multi_option_array(
      i18n.translate("Topbar draw location"),
      i18n.translate("Draw the topbar either on all screens, the main screen or don't draw it at all"),
      {"all", "main", "none"},
      general["top_bar_draw"] or "all",
      "top_bar_draw"
    ),
    create_multi_option_array(
      i18n.translate("Window screenshot mode"),
      i18n.translate(
        "when making a screenshot of a window, you can either show the screenshot or make a pretty version with some shadows, and your theme color"
      ),
      {"shadow", "none"},
      general["window_screen_mode"] or "shadow",
      "window_screen_mode"
    ),
    layout = wibox.layout.flex.vertical
  }

  local break_timeout_value = tonumber(general["break_timeout"]) or 60
  local break_time_value = tonumber(general["break_time"]) or 60

  local break_widget =
    wibox.widget {
    create_checkbox(
      i18n.translate("Break Timer"),
      i18n.translate(
        "A break timer gets triggered every hour, this is intended to give you some time to stretch, take a break etc"
      ),
      general["break"] == "1",
      "break"
    ),
    create_option_slider(
      i18n.translate("Break Timeout"),
      60, -- one minute
      60 * 60 * 12, -- 12 hours
      60,
      "break_timeout",
      break_timeout_value,
      function(value)
        break_timeout_value = value
      end,
      function()
        return i18n.translate("Timeout before the break triggers: ") .. datetime.numberInSecToMS(break_timeout_value)
      end
    ),
    create_option_slider(
      i18n.translate("Break Time"),
      1, -- one second
      60 * 15, -- 15 minutes
      5,
      "break_time",
      break_time_value,
      function(value)
        break_time_value = value
      end,
      function()
        return i18n.translate("Duration of the break: ") .. datetime.numberInSecToMS(break_time_value)
      end
    ),
    layout = wibox.layout.flex.vertical
  }

  local slider_widget =
    wibox.widget {
    create_option_slider(
      i18n.translate("Animation Speed"),
      0,
      1.5,
      0.05,
      "animation_speed",
      tonumber(general["window_screen_mode"]) or _G.anim_speed,
      function(value)
        _G.update_anim_speed(value)
      end
    ),
    layout = wibox.layout.flex.vertical
  }

  local checkbox_card = card()
  checkbox_card.update_body(wibox.container.margin(checkbox_widget, dpi(10), dpi(10), dpi(3), dpi(3)))

  local multi_option_card = card()
  multi_option_card.update_body(wibox.container.margin(multi_option_widget, dpi(10), dpi(10), dpi(3), dpi(3)))

  local slider_card = card()
  slider_card.update_body(wibox.container.margin(slider_widget, dpi(10), dpi(10), dpi(3), dpi(3)))

  local break_card = card()
  break_card.update_body(wibox.container.margin(break_widget, dpi(10), dpi(10), dpi(3), dpi(3)))

  view:setup {
    layout = wibox.container.background,
    {
      layout = wibox.layout.fixed.vertical,
      {
        layout = wibox.layout.align.horizontal,
        nil,
        wibox.container.margin(
          {
            layout = wibox.container.place,
            title
          },
          settings_index * 2
        ),
        close
      },
      separator,
      wibox.container.margin(checkbox_card, dpi(10), dpi(10)),
      separator,
      wibox.container.margin(multi_option_card, dpi(10), dpi(10)),
      separator,
      wibox.container.margin(slider_card, dpi(10), dpi(10)),
      separator,
      wibox.container.margin(break_card, dpi(10), dpi(10)),
      separator,
      wibox.container.margin(save, m, m, m, m)
    }
  }

  return view
end
