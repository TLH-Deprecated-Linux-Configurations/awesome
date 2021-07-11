--  ______                                __   __
-- |      |.-----.-----.-----.-----.----.|  |_|__|.-----.-----.
-- |   ---||  _  |     |     |  -__|  __||   _|  ||  _  |     |
-- |______||_____|__|__|__|__|_____|____||____|__||_____|__|__|

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
local hardware = require("module.hardware.hardware-check")
local file = require("module.functions.file")
local icons = require("theme.icons")
local mat_icon_button = require("widget.material.icon-button")
local mat_icon = require("widget.material.icon")
local card = require("module.ui-components.card")
local inputfield = require("module.ui-components.inputfield")
local tde_button = require("module.ui-components.button")
local signals = require("module.settings.signals")
local scrollbox = require("module.ui-components.scrollbox")
local network = require("module.hardware.network")

local dpi = beautiful.xresources.apply_dpi

local m = dpi(10)
local settings_index = dpi(40)
local settings_width = dpi(1100)
local settings_height = dpi(900)
local settings_nw = dpi(260)

local active_text = ""

local static_connections = {}
local password_fields = {}

local scrollbox_body

local refresh = function()
end

local qr_code_image = ""
local bIsShowingNetworkTab = true

local active_pallet = beautiful.xcolor4

signals.connect_exit(
  function()
    file.rm(qr_code_image)
  end
)

-- returns the filename of the qr code image
local function generate_qr_code(ssid, password)
  local qr_text = "WIFI:T:WPA;S:" .. ssid .. ";P:" .. password .. ";;"
  local output = "/tmp/qrcode" .. ssid .. ".png"
  hardware.execute("qrencode -l L -v 1 -m 1 -s 9 -o '" .. output .. "' '" .. qr_text .. "'")
  qr_code_image = output
end

local function make_qr_code_field()
  local img =
    wibox.widget {
    image = qr_code_image,
    resize = true,
    forced_height = (settings_height / 2),
    widget = wibox.widget.imagebox
  }
  local done_btn =
    tde_button(
    wibox.widget.imagebox(icons.qr_code),
    function()
      bIsShowingNetworkTab = true
      refresh()
    end,
    active_pallet
  )

  return wibox.widget {
    wibox.container.place(img),
    wibox.container.margin(done_btn, m, m, m, m),
    layout = wibox.layout.fixed.vertical
  }
end

local function make_network_widget(ssid, active)
  -- make sure ssid is not nil
  ssid = ssid or ""

  local box = card()

  local button = mat_icon_button(mat_icon(icons.plus, dpi(25)))
  button:buttons(
    gears.table.join(
      awful.button(
        {},
        1,
        nil,
        function()
          -- try to connect without a password
          if active_text == "" then
            awful.spawn.easy_async(
              "network connect " .. ssid,
              function(_)
                refresh()
              end
            )
          else
            awful.spawn.easy_async(
              "network connect " .. ssid .. " password " .. active_text,
              function(_)
                refresh()
              end
            )
          end
        end
      )
    )
  )

  local password =
    inputfield(
    function(text)
      active_text = text
    end,
    function(_)
      root.elements.settings_grabber:start()
    end,
    true
  )

  if active then
    -- override button to be a checkmark to indicate connection
    button = wibox.container.margin(wibox.widget.imagebox(icons.network), dpi(10), dpi(10), dpi(10), dpi(10))
    password =
      tde_button(
      wibox.widget.imagebox(icons.qr_code),
      function()
        print("Generating qr code")
        local passwd =
          string.gsub(
          hardware.execute("nmcli --show-secrets -g 802-11-wireless-security.psk connection show id '" .. ssid .. "'"),
          "\n",
          ""
        )
        generate_qr_code(ssid, passwd)
        bIsShowingNetworkTab = false
        refresh()
      end,
      active_pallet
    )
  else
    table.insert(password_fields, password)
  end

  -- name on the left, password entry in the middle, connect button on the right
  local widget =
    wibox.widget {
    wibox.container.margin(
      wibox.widget {
        widget = wibox.widget.textbox,
        text = ssid,
        font = beautiful.title_font
      },
      dpi(10),
      dpi(10),
      dpi(10),
      dpi(10)
    ),
    wibox.container.margin(password, dpi(10), dpi(10), dpi(7), dpi(7)),
    button,
    layout = wibox.layout.align.horizontal
  }

  box.update_body(widget)

  local container = wibox.container.margin()
  container.bottom = m
  container.forced_width = settings_width - settings_nw - (m * 2)
  container.forced_height = dpi(50)
  container.widget = box
  return container
end

local function make_connection(t, n)
  local container = wibox.container.margin()
  container.bottom = m
  container.forced_width = settings_width - settings_nw - (m * 2)

  local conx = card()

  local i
  local wireless = "wireless"
  local bluetooth = "bluetooth"
  local wired = "wired"

  if t == wireless then
    i = icons.wifi
  elseif t == bluetooth then
    i = icons.bluetooth
  elseif t == wired then
    i = icons.lan
  else
    i = icons.lan_off
  end
  if n == "disconnected" and t == wireless then
    i = icons.wifi_off
  end
  if n == "disconnected" and t == wired then
    i = icons.lan_off
  end
  local icon =
    wibox.widget {
    image = i,
    resize = true,
    forced_width = 50,
    forced_height = 50,
    widget = wibox.widget.imagebox
  }

  local name =
    wibox.widget {
    widget = wibox.widget.textbox,
    text = n,
    font = beautiful.title_font
  }

  local type =
    wibox.widget {
    widget = wibox.widget.textbox,
    -- Holds the string "wireless", "wired" or similar
    text = (t),
    font = beautiful.title_font
  }

  local address =
    wibox.widget {
    widget = wibox.widget.textbox,
    text = "",
    font = beautiful.title_font
  }

  conx.update_body(
    wibox.widget {
      layout = wibox.layout.align.horizontal,
      {
        layout = wibox.container.margin,
        margins = m,
        wibox.container.margin(icon, dpi(10), dpi(10), dpi(10), dpi(10))
      },
      address,
      wibox.container.margin(name, 0, m),
      {layout = wibox.container.margin, right = m, type}
    }
  )

  container.widget = conx

  return {widget = container, icon = icon, name = name, ip = address}
end

return function()
  local view = wibox.container.margin()
  view.left = m
  view.right = m

  local title = wibox.widget.textbox(("Connections"))
  title.font = beautiful.font .. ' 22'
  title.forced_height = settings_index + m + m

  local close = wibox.widget.imagebox(icons.close)
  close.font = beautiful.font .. ' 10'
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

  local connections = wibox.layout.fixed.vertical()

  local wireless = make_connection("wireless")
  local wired = make_connection("wired")
  local network_settings =
    wibox.container.margin(
    wibox.widget {
      widget = wibox.widget.textbox,
      text = ("Network list"),
      font = "agave Nerd Font Mono Bold  24"
    },
    dpi(20),
    0,
    dpi(20),
    dpi(20)
  )

  table.insert(static_connections, wireless.widget)
  table.insert(static_connections, wired.widget)
  table.insert(static_connections, network_settings)

  connections:add(wireless.widget)
  connections:add(wired.widget)
  connections:add(network_settings)

  scrollbox_body = scrollbox(connections)

  view:setup {
    layout = wibox.container.background,
    bg = beautiful.bg_normal .. "00",
    --fg = beautiful.xforeground,
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
        layout = wibox.container.place,
        valign = "top",
        halign = "center",
        scrollbox_body
      }
    }
  }

  local function setup_network_connections()
    network.get_ssid_list(
      function(list)
        for _, value in pairs(list) do
          connections:add(make_network_widget(value["ssid"], value["active"]))
        end
      end
    )
  end

  refresh = function()
    password_fields = {}
    local interface = file.string("/tmp/interface.txt")

    if scrollbox_body then
      scrollbox_body.reset()
    end

    if hardware.hasWifi() and not (interface == "") then
      wireless.icon:set_image(icons.wifi)
      wireless.name.text = interface
      wireless.ip.text = hardware.getDefaultIP()
    else
      wireless.icon:set_image(icons.wifi_off)
      wireless.name.text = ("Disconnected")
      wireless.ip.text = ""
    end

    -- Always try to populate network list, even when it is not possible
    -- This is to make networks more easily detectable in case your wifi card is not working properly, or when the pc never had a network before
    if bIsShowingNetworkTab and hardware.hasWifi() then
      -- remove all wifi connections
      connections.children = static_connections
      setup_network_connections()
    elseif hardware.hasWifi() then
      -- remove all wifi connections
      connections.children = static_connections
      connections:add(make_qr_code_field())
    end

    awful.spawn.easy_async_with_shell(
      'sh -c \'ip link | grep ": en" | grep " UP "\'',
      function(_, _, _, c)
        if (c == 0) then
          print("Lan on")
          wired.icon:set_image(icons.lan)
          wired.name.text = ("connected")
          wired.ip.text = hardware.getDefaultIP()
        else
          wired.icon:set_image(icons.lan_off)
          wired.name.text = ("Disconnected")
          wired.ip.text = ""
        end
      end
    )
  end

  view.refresh = refresh
  return view
end
