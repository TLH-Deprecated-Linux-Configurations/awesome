--  ______                     __      ______         __
-- |   __ \.---.-.-----.-----.|  |    |   __ \.--.--.|  |.-----.-----.
-- |    __/|  _  |     |  -__||  |    |      <|  |  ||  ||  -__|__ --|
-- |___|   |___._|__|__|_____||__|    |___|__||_____||__||_____|_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local left_panel = require('layout.left-panel.left-panel')
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Create a wibox for each screen connected
--
awful.screen.connect_for_each_screen(
    function(s)
        if s.index == 1 then
            -- Create the left_panel
            s.left_panel = left_panel()
        end
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Hide panel when clients go fullscreen
--
local showAgain = false
local function updateleftBarsVisibility()
    for s in screen do
        if s.selected_tag then
            local fullscreen = s.selected_tag.fullscreenMode
            if s.left_panel then
                if fullscreen and s.left_panel.visible then
                    _G.screen.primary.left_panel:toggle()
                    showAgain = true
                elseif not fullscreen and not s.left_panel.visible and showAgain then
                    _G.screen.primary.left_panel:toggle()
                    showAgain = false
                end
            end
        end
    end
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
_G.tag.connect_signal(
    'property::selected',
    function(_)
        updateleftBarsVisibility()
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
_G.client.connect_signal(
    'property::fullscreen',
    function(c)
        if c.first_tag then
            c.first_tag.fullscreenMode = c.fullscreen
        end
        updateleftBarsVisibility()
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
_G.client.connect_signal(
    'unmanage',
    function(c)
        if c.fullscreen then
            c.screen.selected_tag.fullscreenMode = false
            updateleftBarsVisibility()
        end
    end
)
