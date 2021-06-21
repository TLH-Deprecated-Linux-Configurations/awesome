--                     __               __                        __               __
-- .-----.--.--.---.-.|  |--.-----.    |  |_.-----.----.--------.|__|.-----.---.-.|  |
-- |  _  |  |  |  _  ||    <|  -__|    |   _|  -__|   _|        ||  ||     |  _  ||  |
-- |__   |_____|___._||__|__|_____|    |____|_____|__| |__|__|__||__||__|__|___._||__|
--    |__|
-- ########################################################################
-- Initialization #########################################################
-- ########################################################################
local spawn = require('awful.spawn')
local app = require('configuration.apps').default.quake

local quake_id = 'notnil'
local quake_client
local opened = false
local function create_shell()
    quake_id =
        spawn(
        app,
        {
            skip_decoration = true
        }
    )
end
-- ########################################################################
-- control functions#######################################################
-- ########################################################################
local function open_quake()
    print('Opening quake terminal')
    quake_client.hidden = false
end

local function close_quake()
    print('Closing quake terminal')
    quake_client.hidden = true
end

local toggle_quake = function()
    opened = not opened
    if not quake_client then
        create_shell()
    else
        if opened then
            open_quake()
        else
            close_quake()
        end
    end
end

_G.toggle_quake = toggle_quake
-- ########################################################################
-- Geometry ###############################################################
-- ########################################################################

_G.client.connect_signal(
    'manage',
    function(c)
        if (c.pid == quake_id) then
            quake_client = c
            c.width = (c.screen.geometry.width * 0.9)
            c.height = (c.screen.geometry.height * 0.3)
            c.x = (c.screen.geometry.width * 0.05)
            c.y = 100
            c.opacity = 0.9
            c.floating = true
            c.skip_taskbar = true
            c.ontop = true
            c.above = true
            c.sticky = true
            c.hidden = not opened
        --c.maximized_horizontal = true
        end
    end
)
-- ########################################################################
-- exit handling ##########################################################
-- ########################################################################
_G.client.connect_signal(
    'unmanage',
    function(c)
        if (c.pid == quake_id) then
            opened = false
            quake_client = nil
        end
    end
)

-- create_shell()
