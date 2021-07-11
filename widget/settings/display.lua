--  _____  __               __
-- |     \|__|.-----.-----.|  |.---.-.--.--.
-- |  --  |  ||__ --|  _  ||  ||  _  |  |  |
-- |_____/|__||_____|   __||__||___._|___  |
--                  |__|             |_____|
--  _______         __   __   __
-- |     __|.-----.|  |_|  |_|__|.-----.-----.-----.
-- |__     ||  -__||   _|   _|  ||     |  _  |__ --|
-- |_______||_____||____|____|__||__|__|___  |_____|
--                                     |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local rounded = require("lib.widget.rounded")
local filesystem = require("module.functions.file")
local icons = require("theme.icons")
local signals = require("module.settings.signals")
local dpi = beautiful.xresources.apply_dpi
local configWriter = require("module.functions.config-writer")
local datetime = require("lib.function.datetime")
local filehandle = require("module.functions.file")
local imagemagic = require("module.ui-components.imagemagic")
local xrandr_menu = require("module.hardware.xrandr").menu
local scrollbox = require("module.ui-components.scrollbox")
local slider = require("module.ui-components.slider")
local card = require("module.ui-components.card")
local button = require("module.ui-components.button")
local functions = require("module.functions")

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- this will hold the scrollbox, used to reset it
local body = nil

local m = dpi(10)
local settings_index = dpi(40)
local settings_height = dpi(900)

local tempDisplayDir = filehandle.mktempdir()
local monitorScaledImage = ""

local active_pallet = beautiful.xcolor4

signals.connect_exit(
  function()
    filehandle.rm(tempDisplayDir)
  end
)

local screens = {}
local mon_size = {
  w = nil,
  h = nil
}
local refresh = function()
end

local NORMAL_MODE = 1
local WALLPAPER_MODE = 2
local XRANDR_MODE = 3

local Display_Mode = NORMAL_MODE

local function make_screen_layout(wall, label)
  local size = dpi(20)
  local monitor =
    wibox.widget {
    widget = wibox.widget.imagebox,
    shape = function(cr, rect_width, rect_height)
      gears.shape.partially_rounded_rect(cr, rect_width, rect_height, true, true, true, true, 12)
    end,
    clip_shape = function(cr, rect_width, rect_height)
      gears.shape.partially_rounded_rect(cr, rect_width, rect_height, true, true, true, true, 12)
    end,
    resize = true,
    forced_width = nil,
    forced_height = nil
  }
  monitor:set_image(wall)
  return wibox.container.place(
    wibox.widget {
      layout = wibox.layout.stack,
      forced_width = size * 16,
      forced_height = size * 9,
      wibox.container.place(monitor),
      {
        layout = wibox.container.place,
        valign = "center",
        halign = "center",
        {
          layout = wibox.container.background,
          fg = beautiful.fg_normal,
          bg = beautiful.bg_settings_display_number,
          shape = rounded(dpi(60)),
          forced_width = dpi(60),
          forced_height = dpi(60),
          wibox.container.place(
            {
              widget = wibox.widget.textbox,
              markup = label
            }
          )
        }
      }
    }
  )
end

-- ########################################################################
-- ########################################################################
-- ########################################################################

-- wall is the scaled wallpaper
-- fullwall is a fullscreen (or original wallpaper)
-- the disable_number argument tells use if we should show the number in the center of the monitor
local function make_mon(wall, id, fullwall, disable_number)
  fullwall = fullwall or wall
  local monitor =
    wibox.widget {
    widget = wibox.widget.imagebox,
    shape = function(cr, rect_width, rect_height)
      gears.shape.partially_rounded_rect(cr, rect_width, rect_height, true, true, true, true, 12)
    end,
    clip_shape = function(cr, rect_width, rect_height)
      gears.shape.partially_rounded_rect(cr, rect_width, rect_height, true, true, true, true, 12)
    end,
    resize = true,
    forced_width = mon_size.w,
    forced_height = mon_size.h
  }
  monitor:set_image(wall)
  monitor:connect_signal(
    "button::press",
    function(_, _, _, btn)
      -- we check if button == 1 for a left mouse button (this way scrolling still works)
      if Display_Mode == WALLPAPER_MODE and btn == 1 then
        awful.spawn.easy_async(
          "theme set " .. fullwall,
          function()
            Display_Mode = NORMAL_MODE
            refresh()
            local themeFile = os.getenv("HOME") .. "/.config/awesome/theme"
            -- our theme file exists
            if filesystem.exists(themeFile) then
              local newContent = ""
              for _, line in ipairs(filesystem.lines(themeFile)) do
                -- if the line is a file then it is a picture, otherwise it is a configuration option
                if not filesystem.exists(line) then
                  newContent = newContent .. line .. "\n"
                end
              end
              newContent = newContent .. fullwall
              filesystem.overwrite(themeFile, newContent)
            end
            -- collect the garbage to remove the image cache from memory
            collectgarbage("collect")
          end
        )
      end
    end
  )
  if disable_number then
    return wibox.container.place(monitor)
  end
  return wibox.container.place(
    wibox.widget {
      layout = wibox.layout.stack,
      forced_width = mon_size.w,
      forced_height = mon_size.h,
      wibox.container.place(monitor),
      {
        layout = wibox.container.place,
        valign = "center",
        halign = "center",
        {
          layout = wibox.container.background,
          fg = beautiful.fg_normal,
          bg = beautiful.bg_settings_display_number,
          shape = rounded(dpi(100)),
          forced_width = dpi(100),
          forced_height = dpi(100),
          wibox.container.place(
            {
              widget = wibox.widget.textbox,
              font = beautiful.monitor_font,
              text = id
            }
          )
        }
      }
    }
  )
end

return function()
  local view = wibox.container.margin()
  view.left = m
  view.right = m
  view.bottom = m

  local title = wibox.widget.textbox(("Display"))
  title.font = beautiful.font .. " 22"
  title.forced_height = settings_index + m + m

  local close = wibox.widget.imagebox(icons.close)
  close.font = beautiful.font .. " 10"
  close.forced_height = 40
  close:buttons(
    gears.table.join(
      awful.button(
        {},
        1,
        function()
          if root.elements.hub then
            root.elements.hub.close()
          end
        end
      )
    )
  )

  local monitors = card()

  local layout = wibox.layout.grid()
  layout.spacing = m
  layout.forced_num_cols = 4
  layout.homogeneous = true
  layout.expand = true
  layout.min_rows_size = dpi(100)

  local brightness =
    slider(
    0,
    100,
    1,
    0,
    function(value)
      for k in pairs(mouse.screen.outputs) do
        local n = (7 * value + 300) / 1000
        awful.spawn.with_shell(functions.setbrightness .. " " .. k .. " " .. tostring(n))
      end
    end
  )

  signals.connect_brightness(
    function(value)
      brightness.update(tonumber(value))
    end
  )

  local screen_time =
    slider(
    10,
    600,
    1,
    600,
    function(value)
      print("Updated screen time: " .. tostring(value) .. "sec")
      general["screen_on_time"] = tostring(value)
      configWriter.update_entry(os.getenv("HOME") .. "/.cache/awesome/general.conf", "screen_on_time", tostring(value))
      if general["screen_timeout"] == "1" or general["screen_timeout"] == nil then
        awful.spawn("pkill -f bin/autolock.sh")
        awful.spawn("sh ~/.config/awesome/bin/autolock.sh " .. tostring(value))
      end
    end,
    function()
      return datetime.numberInSecToMS(300) .. (" before sleeping")
    end
  )

  local screenLayoutBtn =
    button(
    "Screen Layout",
    function()
      if not (Display_Mode == XRANDR_MODE) then
        Display_Mode = XRANDR_MODE
      else
        Display_Mode = NORMAL_MODE
      end
      refresh()
    end
  )
  screenLayoutBtn.top = m
  screenLayoutBtn.bottom = m

  body = scrollbox(layout)
  monitors.update_body(
    wibox.widget {
      layout = wibox.container.margin,
      margins = m,
      body
    }
  )

  local brightness_card = card()
  local screen_time_card = card()

  brightness_card.update_body(
    wibox.widget {
      layout = wibox.layout.fixed.vertical,
      {
        layout = wibox.container.margin,
        margins = m,
        {
          font = beautiful.font .. " 10",
          text = ("Brightness"),
          widget = wibox.widget.textbox
        }
      },
      {
        layout = wibox.container.margin,
        left = m,
        right = m,
        bottom = m,
        brightness
      }
    }
  )
  screen_time_card.update_body(
    wibox.widget {
      layout = wibox.layout.fixed.vertical,
      {
        layout = wibox.container.margin,
        margins = m,
        {
          font = beautiful.font .. " 10",
          text = ("Screen on time"),
          widget = wibox.widget.textbox
        }
      },
      {
        layout = wibox.container.margin,
        left = m,
        right = m,
        bottom = m,
        screen_time
      }
    }
  )

  brightness_card.forced_height = (m * 6) + dpi(30)
  screen_time_card.forced_height = (m * 6) + dpi(30)

  view:setup {
    layout = wibox.container.background,
    {
      layout = wibox.layout.align.vertical,
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
      {
        layout = wibox.layout.fixed.vertical,
        brightness_card,
        {
          layout = wibox.container.margin,
          top = m,
          screen_time_card
        },
        {
          layout = wibox.container.margin,
          top = m,
          monitors
        },
        {
          layout = wibox.container.margin,
          top = m,
          screenLayoutBtn
        }
      },
      nil
    }
  }
  -- ########################################################################
  -- ########################################################################
  -- ########################################################################
  -- The user option tells use if these are pictures supplied by the user
  local function load_monitor(k, table, done, user)
    local v = table[k]
    -- check if it is a file
    if filesystem.exists(v) then
      local base = filehandle.basename(v)

      local width = dpi(300)
      local height = (width / 16) * 9
      local scaledImage = tempDisplayDir .. "/" .. base
      if user then
        scaledImage = tempDisplayDir .. "/user-" .. base
      end
      -- We use imagemagick to generate a "thumbnail"
      -- This is done to save memory consumption
      -- However note that our cache (tempDisplayDir) is stored in ram
      imagemagic.scale(
        v,
        width,
        height,
        scaledImage,
        function()
          if filesystem.exists(scaledImage) and Display_Mode == WALLPAPER_MODE then
            layout:add(make_mon(scaledImage, k, v, true))
          else
            print("Something went wrong scaling " .. v)
          end
          if done then
            done(user, table, k)
          end
        end
      )
    else
      -- in case the entry is a directory and not a file
      if done then
        done(user, table, k)
      end
    end
  end

  local recursive_monitor_load_func

  local function loadMonitors()
    local usr_files = filesystem.list_dir("/usr/share/backgrounds")

    recursive_monitor_load_func = function(bool, table, i)
      if i < #table then
        i = i + 1
        load_monitor(i, table, recursive_monitor_load_func, bool)
      end
    end
    load_monitor(1, usr_files, recursive_monitor_load_func, false)
    local pictures = os.getenv("HOME") .. "/Pictures/"
    if filesystem.dir_exists(pictures) then
      local home_dir = filesystem.list_dir_full(pictures)
      -- true to tell the function that these are user pictures
      load_monitor(1, home_dir, recursive_monitor_load_func, true)
    end
  end

  local function render_normal_mode()
    screenLayoutBtn.visible = true
    awful.spawn.with_line_callback(
      "theme active",
      {
        stdout = function(o)
          table.insert(screens, o)
        end,
        output_done = function()
          monitors.forced_height = settings_height / 2
          if #screen < 4 then
            layout.forced_num_cols = #screen
          end
          for k, v in pairs(screens) do
            local base = filehandle.basename(v)

            local width = dpi(600)
            local height = (width / 16) * 9
            monitorScaledImage = tempDisplayDir .. "/monitor-" .. base
            if filesystem.exists(monitorScaledImage) then
              layout:add(make_mon(monitorScaledImage, k, v))
            else
              -- We use imagemagick to generate a "thumbnail"
              -- This is done to save memory consumption
              -- However note that our cache (tempDisplayDir) is stored in ram
              imagemagic.scale(
                v,
                width,
                height,
                monitorScaledImage,
                function()
                  layout:add(make_mon(monitorScaledImage, k, v))
                end
              )
            end
          end
        end
      }
    )
  end

  local timer =
    gears.timer {
    timeout = 0.1,
    call_now = false,
    autostart = false,
    single_shot = true,
    callback = loadMonitors
  }

  local function render_wallpaper_mode()
    screenLayoutBtn.visible = false
    -- do an asynchronous render of all wallpapers
    timer:start()
    layout.forced_num_cols = 4
  end

  local function render_xrandr_mode()
    screenLayoutBtn.visible = true

    local permutated_screens = xrandr_menu()

    for _, tbl in ipairs(permutated_screens) do
      local label = tbl[1]
      local cmd = tbl[2]
      local screen_names = tbl[3]

      local widget = wibox.layout.flex.horizontal()
      widget:add(wibox.widget.textbox(label))
      for index = 1, #screen_names, 1 do
        local screen_wdgt = make_screen_layout(monitorScaledImage, screen_names[index])
        widget:add(wibox.container.margin(screen_wdgt, m, m, m, m))
      end

      local screen_btn =
        button(
        widget,
        function()
          print("Executing: " .. cmd)
          awful.spawn.easy_async_with_shell(
            cmd,
            function()
              awful.spawn("sh -c 'sleep 1 && which autorandr && autorandr --save 1 --force'")
              Display_Mode = NORMAL_MODE
              refresh()
            end
          )
        end,
        active_pallet
      )
      layout:add(screen_btn)
      layout.forced_num_cols = 1
    end
  end

  refresh = function()
    screens = {}
    layout:reset()
    body:reset()
    -- remove all images from memory (to save memory space)
    collectgarbage("collect")

    awful.spawn.easy_async_with_shell(
      "brightness -g",
      function(o)
        brightness:set_value(math.floor(tonumber(255)))
      end
    )
    if Display_Mode == WALLPAPER_MODE then
      render_wallpaper_mode()
    elseif Display_Mode == XRANDR_MODE then
      render_xrandr_mode()
    else
      render_normal_mode()
    end
  end

  signals.connect_refresh_screen(
    function()
      -- If we are in the screen layout mode, refresh it on screen refreshes
      if Display_Mode == XRANDR_MODE then
        refresh()
      end
    end
  )

  view.refresh = refresh
  return view
end
