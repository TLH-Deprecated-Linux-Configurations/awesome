-- Load these libraries (if you haven't already)

local gears = require("gears")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi
local signals = require("lib.signals")

local vol_osd = require("widget.volume.volume-slider-osd")

awful.screen.connect_for_each_screen(
  function(s)
    -- Create the box

    local offsetx = dpi(56)
    local offsety = dpi(300)
    local volumeOverlay =
      wibox(
      {
        visible = nil,
        ontop = true,
        type = "normal",
        height = offsety,
        width = dpi(48),
        bg = "#00000000",
        x = s.geometry.x + s.geometry.width - offsetx,
        y = s.geometry.y + (s.geometry.height / dpi(2)) - (offsety / dpi(2))
      }
    )

    screen.connect_signal(
      "removed",
      function(removed)
        if s == removed then
          volumeOverlay.visible = false
          volumeOverlay = awful.screen.focused()
        end
      end
    )

    signals.connect_refresh_screen(
      function()
        print("Refreshing volume osd slider")

        if not s.valid or volumeOverlay == nil then
          return
        end

        -- the action center itself
        volumeOverlay.x = s.geometry.x + s.geometry.width - offsetx
        volumeOverlay.y = s.geometry.y + (s.geometry.height / dpi(2)) - (offsety / dpi(2))
      end
    )

    _G.volumeOverlay = volumeOverlay
    -- Put its items in a shaped container
    volumeOverlay:setup {
      -- Container
      {
        -- Items go here
        --wibox.widget.textbox("Hello!"),
        wibox.container.rotate(vol_osd, "east"),
        -- ...
        layout = wibox.layout.fixed.vertical
      },
      -- The real background color
      bg = "#000000" .. "66",
      -- The real, anti-aliased shape
      shape = gears.shape.rounded_rect,
      widget = wibox.container.background()
    }

    local hideOSD =
      gears.timer {
      timeout = 5,
      autostart = true,
      single_shot = true,
      callback = function()
        if volumeOverlay then
          volumeOverlay.visible = false
        end
      end
    }

    local function toggleVolOSD(bool)
      if volumeOverlay == nil then
        return
      end
      if (not _G.menuopened) then
        -- don't perform the toggle off if it is already off
        if ((not bool) and (not volumeOverlay.visible)) then
          return
        end
        volumeOverlay.visible = bool
        if bool then
          hideOSD:again()
          if _G.toggleBriOSD ~= nil then
            _G.toggleBriOSD(false)
          end
        else
          hideOSD:stop()
        end
      end
    end
    -- TODO: make this code run per screen, then the toggle function should loop over all screens and toggle each slider
    _G.toggleVolOSD = toggleVolOSD
  end
)

return _G.volumeOverlay
