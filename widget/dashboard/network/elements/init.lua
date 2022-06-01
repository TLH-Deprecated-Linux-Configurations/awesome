--  _______ __                              __
-- |    ___|  |.-----.--------.-----.-----.|  |_.-----.
-- |    ___|  ||  -__|        |  -__|     ||   _|__ --|
-- |_______|__||_____|__|__|__|_____|__|__||____|_____|
-- ------------------------------------------------- --
local elements = {}

elements.create = function(SSID, BSSID, connectStatus, signal, secure, speed)
  local box = {}

  local connectIcon =
    wibox.widget {
    layout = wibox.layout.align.vertical,
    expand = "none",
    nil,
    {
      id = "icon",
      image = icons.wifi_3,
      resize = true,
      widget = wibox.widget.imagebox
    },
    nil
  }

  local connect =
    wibox.widget {
    {
      {
        {
          connectIcon,
          layout = wibox.layout.fixed.horizontal
        },
        margins = dpi(9),
        widget = wibox.container.margin
      },
      forced_height = dpi(30),
      forced_width = dpi(30),
      widget = clickable_container
    },
    shape = beautiful.client_shape_rounded_small,
    bg = beautiful.bg_focus,
    widget = wibox.container.background
  }

  connect:connect_signal(
    "mouse::enter",
    function()
      connect.bg = beautiful.bg_normal
    end
  )

  connect:connect_signal(
    "mouse::leave",
    function()
      connect.bg = beautiful.bg_focus
    end
  )

  local disconnectIcon =
    wibox.widget {
    layout = wibox.layout.align.vertical,
    expand = "none",
    nil,
    {
      id = "icon",
      image = icons.wifi_off,
      resize = true,
      widget = wibox.widget.imagebox
    },
    nil
  }

  local disconnect =
    wibox.widget {
    {
      {
        {
          disconnectIcon,
          layout = wibox.layout.fixed.horizontal
        },
        margins = dpi(9),
        widget = wibox.container.margin
      },
      forced_height = dpi(30),
      forced_width = dpi(30),
      widget = clickable_container
    },
    shape = beautiful.client_shape_rounded_small,
    bg = beautiful.bg_button,
    widget = wibox.container.background
  }

  disconnect:connect_signal(
    "mouse::enter",
    function()
      disconnect.bg = beautiful.accent
    end
  )

  disconnect:connect_signal(
    "mouse::leave",
    function()
      disconnect.bg = beautiful.bg_button
    end
  )

  connect:buttons(
    gears.table.join(
      awful.button(
        {},
        1,
        nil,
        function()
          awful.spawn.easy_async_with_shell(
            "nmcli connection show '" .. SSID .. "' | grep 'connection.autoconnect:' | awk '{print $2}'",
            function(stdout)
              local knownStatus = stdout:gsub("\n", "")
              if knownStatus == "yes" then
                awful.spawn.with_shell(
                  "nmcli device wifi connect " ..
                    BSSID ..
                      " && notify-send 'Connected to internet' '" ..
                        SSID .. "' || notify-send 'Unable to connect' '" .. SSID .. "'"
                )
              else
                if secure == "no" then
                  awful.spawn.with_shell(
                    "nmcli device wifi connect " ..
                      BSSID ..
                        " && notify-send 'Connected to internet' '" ..
                          SSID .. "' || notify-send 'Unable to connect' '" .. SSID .. "'"
                  )
                else
                  awful.spawn.with_shell(
                    "nmcli device wifi connect " ..
                      BSSID ..
                        " password $(rofi -dmenu -p '" ..
                          SSID ..
                            "' -theme ~/.config/awesome/config/rofi/centered.rasi -password)" ..
                              " && notify-send 'Connected to internet' '" ..
                                SSID .. "' || notify-send 'Unable to connect' '" .. SSID .. "'"
                  )
                end
              end
            end
          )
        end
      )
    )
  )

  disconnect:buttons(
    gears.table.join(
      awful.button(
        {},
        1,
        nil,
        function()
          awful.spawn.with_shell("nmcli device disconnect wlan0")
        end
      )
    )
  )

  local signalIcon =
    wibox.widget {
    layout = wibox.layout.align.vertical,
    expand = "none",
    nil,
    {
      id = "icon",
      image = icons.wifi_off,
      resize = true,
      widget = wibox.widget.imagebox
    },
    nil
  }

  local wifiIcon =
    wibox.widget {
    {
      {
        signalIcon,
        margins = dpi(7),
        widget = wibox.container.margin
      },
      shape = gears.shape.rect,
      bg = colors.color4,
      widget = wibox.container.background
    },
    forced_width = 40,
    forced_height = 40,
    widget = clickable_container
  }

  local content =
    wibox.widget {
    {
      {
        {
          text = SSID,
          font = "SF Pro Rounded Heavy    Bold  10",
          widget = wibox.widget.textbox
        },
        {
          text = BSSID,
          font = "SF Pro Rounded Heavy    8",
          widget = wibox.widget.textbox
        },
        layout = wibox.layout.align.vertical
      },
      margins = dpi(10),
      widget = wibox.container.margin
    },
    shape = gears.shape.rect,
    bg = colors.colorB,
    widget = wibox.container.background
  }

  local icon_table = {
    icons.wifi_0,
    icons.wifi_1,
    icons.wifi_2,
    icons.wifi_3
  }

  signalIcon.icon:set_image(icon_table[math.ceil(tonumber(signal) / 25)])

  local buttons = {}

  if connectStatus == "yes" then
    buttons = {
      layout = wibox.layout.align.horizontal,
      spacing = dpi(15),
      disconnect
    }
    awesome.emit_signal("network::status:updateIcon", icon_table[math.ceil(tonumber(signal) / 25)])
  else
    buttons = {
      layout = wibox.layout.align.horizontal,
      spacing = dpi(15),
      connect
    }
  end

  box =
    wibox.widget {
    {
      wifiIcon,
      content,
      buttons,
      layout = wibox.layout.align.horizontal
    },
    shape = beautiful.client_shape_rounded_small,
    fg = colors.white,
    widget = wibox.container.background
  }

  return box
end

return elements
