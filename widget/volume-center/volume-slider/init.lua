--  ___ ___         __
-- |   |   |.-----.|  |.--.--.--------.-----.
-- |   |   ||  _  ||  ||  |  |        |  -__|
--  \_____/ |_____||__||_____|__|__|__|_____|
--  _______ __ __     __
-- |     __|  |__|.--|  |.-----.----.
-- |__     |  |  ||  _  ||  -__|   _|
-- |_______|__|__||_____||_____|__|
-- ------------------------------------------------- --
local box = {}

local muteIcon =
  wibox.widget {
  layout = wibox.layout.align.vertical,
  expand = "none",
  nil,
  {
    id = "icon",
    image = icons.mute,
    resize = true,
    widget = wibox.widget.imagebox
  },
  nil
}

local mute =
  wibox.widget {
  {
    {
      {
        muteIcon,
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
  bg = colors.colorA,
  widget = wibox.container.background
}

mute:connect_signal(
  "mouse::enter",
  function()
    mute.bg = colors.color1
  end
)

mute:connect_signal(
  "mouse::leave",
  function()
    mute.bg = colors.colorA
  end
)

mute:buttons(
  gears.table.join(
    awful.button(
      {},
      1,
      nil,
      function()
        awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ toggle")
      end
    )
  )
)

local volumeIcon =
  wibox.widget {
  {
    {
      {
        layout = wibox.layout.align.vertical,
        expand = "none",
        nil,
        {
          image = icons.volume,
          widget = wibox.widget.imagebox
        },
        nil
      },
      margins = dpi(7),
      widget = wibox.container.margin
    },
    shape = gears.shape.rect,
    bg = colors.color7,
    widget = wibox.container.background
  },
  forced_width = 40,
  forced_height = 40,
  widget = clickable_container
}

local slider =
  wibox.widget {
  nil,
  {
    id = "volume_slider",
    bar_shape = gears.shape.rounded_rect,
    bar_height = dpi(40),
    bar_color = colors.colorA,
    bar_active_color = colors.color10b,
    handle_color = colors.white,
    handle_shape = gears.shape.rounded_rect,
    handle_border_color = colors.black,
    handle_border_width = dpi(2),
    handle_width = dpi(40),
    maximum = 100,
    widget = wibox.widget.slider
  },
  nil,
  expand = "none",
  forced_height = dpi(40),
  layout = wibox.layout.align.vertical
}

local volume_slider = slider.volume_slider

volume_slider:connect_signal(
  "property::value",
  function()
    local volume_level = volume_slider:get_value()

    awful.spawn("pamixer --set-volume " .. volume_level, false)
  end
)

volume_slider:buttons(
  gears.table.join(
    awful.button(
      {},
      9,
      nil,
      function()
        if volume_slider:get_value() > 100 then
          volume_slider:set_value(100)
          return
        end
        volume_slider:set_value(volume_slider:get_value() + 5)
      end
    ),
    awful.button(
      {},
      8,
      nil,
      function()
        if volume_slider:get_value() < 0 then
          volume_slider:set_value(0)
          return
        end
        volume_slider:set_value(volume_slider:get_value() - 5)
      end
    )
  )
)
local update_slider_mute = function()
  awful.spawn.easy_async_with_shell(
    [[bash -c "pamixer --get-mute"]],
    function(stdout)
      local status = string.match(stdout, "%a+")
      if status == "true" then
        volumeIcon.icon:set_image(icons.mute)
      elseif status == "false" then
        volumeIcon.icon:set_image(icons.volume)
      end
    end
  )
end

local update_slider = function()
  awful.spawn.easy_async_with_shell(
    [[bash -c "pamixer --get-volume"]],
    function(stdout)
      if stdout ~= nil then
        local volume = tonumber(stdout)
        volume_slider:set_value(volume)
        awesome.emit_signal("signal::volume:update", volume)
        update_slider_mute()
      else
        volume_slider:get_value()
        awesome.emit_signal("signal::volume:update", volume_slider:get_value())
        update_slider_mute()
      end
    end
  )
end

update_slider()
-- ------------------------------------------------- --
-- The emit will come from the global keybind
awesome.connect_signal(
  "signal::volume",
  function(value, mute)
    local muted = tonumber(mute)
    local percentage = tonumber(value)
    if percentage ~= nil then
      update_slider()

      if muted == 1 then
        update_slider_mute()
      end
    end
  end
)

-- ------------------------------------------------- --
local buttons = {
  layout = wibox.layout.align.horizontal,
  spacing = dpi(15),
  mute
}

box =
  wibox.widget {
  {
    volumeIcon,
    {
      slider,
      margins = dpi(8),
      widget = wibox.container.margin
    },
    buttons,
    layout = wibox.layout.align.horizontal
  },
  shape = beautiful.client_shape_rounded_xl,
  fg = colors.white,
  border_width = dpi(1),
  border_color = colors.colorA,
  widget = wibox.container.background
}

return box
