--  ______        __         __     __                                _______ __ __     __
-- |   __ \.----.|__|.-----.|  |--.|  |_.-----.-----.-----.-----.    |     __|  |__|.--|  |.-----.----.
-- |   __ <|   _||  ||  _  ||     ||   _|     |  -__|__ --|__ --|    |__     |  |  ||  _  ||  -__|   _|
-- |______/|__|  |__||___  ||__|__||____|__|__|_____|_____|_____|    |_______|__|__||_____||_____|__|
--                   |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Load these libraries (if you haven't already)

local gears = require("gears")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi
local signals = require("module.settings.signals")

local vol_osd = require("widget.brightness.brightness-slider-osd")

local brightnessOverlay
-- ########################################################################
-- ########################################################################
-- ########################################################################
awful.screen.connect_for_each_screen(
    function(s)
        -- Create the box

        local offsetx = dpi(56)
        local offsety = dpi(300)
        brightnessOverlay =
            wibox(
            {
                visible = nil,
                ontop = true,
                type = "normal",
                height = offsety,
                width = dpi(48),
                bg = "#00000000",
                screen = s,
                x = s.geometry.x + s.geometry.width - offsetx,
                y = s.geometry.y + (s.geometry.height / dpi(2)) - (offsety / dpi(2))
            }
        )
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        screen.connect_signal(
            "removed",
            function(removed)
                if s == removed then
                    brightnessOverlay.visible = false
                    brightnessOverlay.screen = awful.screen.ed()
                end
            end
        )
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        signals.connect_refresh_screen(
            function()
                print("Refreshing brightness osd slider")

                if not s.valid or brightnessOverlay == nil then
                    return
                end

                -- the action center itself
                brightnessOverlay.x = s.geometry.x + s.geometry.width - offsetx
                brightnessOverlay.y = s.geometry.y + (s.geometry.height / dpi(2)) - (offsety / dpi(2))
            end
        )
    end
)

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Put its items in a shaped container
brightnessOverlay:setup {
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
-- ########################################################################
-- ########################################################################
-- ########################################################################
local hideOSD =
    gears.timer {
    timeout = 5,
    autostart = true,
    single_shot = true,
    callback = function()
        if brightnessOverlay then
            brightnessOverlay.visible = false
        end
    end
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function toggleBriOSD(bool)
    if brightnessOverlay == nil then
        return
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- don't perform the toggle off if it is already off
    if ((not bool) and (not brightnessOverlay.visible)) then
        return
    end
    brightnessOverlay.visible = bool
    if bool then
        hideOSD:again()
        if _G.toggleVolOSD ~= nil then
            _G.toggleVolOSD(false)
        end
    else
        hideOSD:stop()
    end
end
if _G.toggleBriOSD == nil then
    _G.toggleBriOSD = toggleBriOSD
end
-- ########################################################################
-- ########################################################################
-- ########################################################################

return brightnessOverlay
