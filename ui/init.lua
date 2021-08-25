require 'ui.notifs'
require 'ui.pop'
require 'ui.bar'
require 'ui.decorations'
require 'ui.menu'
-- TODO Add a timer around this to trigger at certain amount of inactivity
require('ui.lockscreen')

local bar = require('ui.bar')
awful.screen.connect_for_each_screen(
    function(s)
        s.bar = bar(s)
        s.bar.visible = false
    end
)

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Hide the wibox by default
local function updateBarsVisibility()
    collectgarbage('collect')

    for s in screen do
        if s.selected_tag then
            local fullscreen = s.selected_tag
            if s.bar then
                s.bar.visible = not fullscreen
            end
        end
    end
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
tag.connect_signal(
    'property::selected',
    function(_)
        updateBarsVisibility()
    end
)
