--  _____               __
-- |     \.-----.--.--.|__|.----.-----.-----.
-- |  --  |  -__|  |  ||  ||  __|  -__|__ --|
-- |_____/|_____|\___/ |__||____|_____|_____|
--  _______               __
-- |_     _|.-----.--.--.|  |_
--   |   |  |  -__|_   _||   _|
--   |___|  |_____|__.__||____|
-- ------------------------------------------------- --
local devices_text =
  wibox.widget {
  text = "devices",
  font = "SF Pro Rounded Heavy    Bold 14",
  widget = wibox.widget.textbox
}

local widget_devices_text =
  wibox.widget {
  layout = wibox.layout.align.vertical,
  expand = "none",
  nil,
  {
    devices_text,
    layout = wibox.layout.align.horizontal
  },
  nil
}

local devicesIcon =
  wibox.widget {
  layout = wibox.layout.align.vertical,
  expand = "none",
  nil,
  {
    id = "icon",
    image = icons.devices,
    resize = true,
    widget = wibox.widget.imagebox
  },
  nil
}

local devices =
  wibox.widget {
  {
    {
      devicesIcon,
      layout = wibox.layout.fixed.horizontal
    },
    margins = dpi(4),
    widget = wibox.container.margin
  },
  forced_height = dpi(40),
  forced_width = dpi(40),
  shape = beautiful.client_shape_rounded_small,
  bg = colors.transparent,
  widget = wibox.container.background
}

local widget =
  wibox.widget {
  {
    devices,
    widget_devices_text,
    layout = wibox.layout.fixed.horizontal,
    spacing = dpi(16)
  },
  fg = colors.white,
  widget = wibox.container.background
}

return widget
