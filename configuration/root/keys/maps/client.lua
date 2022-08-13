--  ______ __ __               __
-- |      |  |__|.-----.-----.|  |_
-- |   ---|  |  ||  -__|     ||   _|
-- |______|__|__||_____|__|__||____|
-- ------------------------------------------------- --
-- NOTE: This keymap provides the client controls
-- ------------------------------------------------- --
local capi = {
    screen = screen,
    client = client
}

local clientmap = {
    -- ------------------------------------------------- --
    {'separator', 'Client Positioning'},
    -- ------------------------------------------------- --
    {
        'b',
        function(c)
            capi.client.focus:swap(awful.client.getmaster())
        end,
        'Move to Master'
    },
    -- ------------------------------------------------- --
    {
        'o',
        function(c)
            capi.client.focus:move_to_screen()
        end,
        'Move to Screen'
    },
    -- ------------------------------------------------- --
    {
        't',
        function()
            capi.client.focus.ontop = not c.ontop
        end,
        'Toggle Client On Top'
    },
    -- ------------------------------------------------- --
    {
        'n',
        function()
            capi.client.focus.minimized = true
        end,
        'Minimize Client'
    },
    -- ------------------------------------------------- --
    {
        'N',
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal('request::activate', 'key.unminimize', {raise = true})
            end
        end,
        'Minimize Client'
    },
    -- ------------------------------------------------- --
    {
        'x',
        function()
            capi.client.focus:kill()
        end,
        'Close Client'
    },
    -- ------------------------------------------------- --
    {
        'd',
        function()
            capi.client.focus.floating = not capi.client.focus.floating
        end,
        'Toggle Floating Client'
    },
    -- ------------------------------------------------- --
    {'separator', 'Maximize Client'},
    -- ------------------------------------------------- --
    {
        'm',
        function()
            capi.client.focus.maximized = not capi.client.focus.maximized
            capi.client.focus:raise()
        end,
        'Maximize Client'
    },
    -- ------------------------------------------------- --
    {
        'h',
        function()
            capi.client.focus.maximized_horizontal = not capi.client.focus.maximized
            capi.client.focus:raise()
        end,
        'Maximize Client Horizontally'
    },
    -- ------------------------------------------------- --
    {
        'v',
        function()
            capi.client.focus.maximized_vetical = not capi.client.focus.maximized_vertical
            capi.client.focus:raise()
        end,
        'Maximize Client'
    },
    {
        'f',
        function(c)
            capi.client.focus.fullscreen = not capi.client.focus.fullscreen
            capi.client.focus:raise()
        end,
        'Toggle Fullscreen'
    },
    -- ------------------------------------------------- --
    {'separator', ' '}
}

return clientmap
