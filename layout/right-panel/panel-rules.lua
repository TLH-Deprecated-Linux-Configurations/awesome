--  ______                     __      ______         __
-- |   __ \.---.-.-----.-----.|  |    |   __ \.--.--.|  |.-----.-----.
-- |    __/|  _  |     |  -__||  |    |      <|  |  ||  ||  -__|__ --|
-- |___|   |___._|__|__|_____||__|    |___|__||_____||__||_____|_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local right_panel = require('layout.right-panel.right-panel')
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Create a wibox for each screen connected
--
awful.screen.connect_for_each_screen(
    function(s)
        if s.index == 1 then
            -- Create the right_panel
            s.right_panel = right_panel()
        end
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Hide panel when clients go fullscreen
--
local showAgain = false
local function updateRightBarsVisibility()
    for s in screen do
        if s.selected_tag then
            local fullscreen = s.selected_tag.fullscreenMode
            if s.right_panel then
                if fullscreen and s.right_panel.visible then
                    _G.screen.primary.right_panel:toggle()
                    showAgain = true
                elseif not fullscreen and not s.right_panel.visible and showAgain then
                    _G.screen.primary.right_panel:toggle()
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
        updateRightBarsVisibility()
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
        updateRightBarsVisibility()
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
            updateRightBarsVisibility()
        end
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
