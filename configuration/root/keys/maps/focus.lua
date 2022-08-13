--  _______
-- |    ___|.-----.----.--.--.-----.
-- |    ___||  _  |  __|  |  |__ --|
-- |___|    |_____|____|_____|_____|
-- ------------------------------------------------- --
-- NOTE: This keymap is to change focus between clients
-- ------------------------------------------------- --

local focusmap = {
    {'separator', 'Focus by Tags'},
    -- ------------------------------------------------- --
    {
        'j',
        function()
            awful.tag.viewprev()
        end,
        'Previous Tag'
    },
    -- ------------------------------------------------- --
    {
        'k',
        function()
            awful.tag.viewnext()
        end,
        'Next Tag'
    },
    -- ------------------------------------------------- --
    {'separator', 'Focus by Index'},
    -- ------------------------------------------------- --
    {
        'Left',
        function()
            awful.client.focus.byidx(-1)
        end,
        'Previous by Index'
    },
    -- ------------------------------------------------- --
    {
        'Right',
        function()
            awful.client.focus.byidx(1)
        end,
        'Next by Index'
    },
    -- ------------------------------------------------- --
    {'separator', 'Focus by Screen'},
    {
        'o',
        function()
            awful.screen.focus_relative(-1)
        end,
        'Focus to Previous Screen'
    },
    {
        'i',
        function()
            awful.screen.focus_relative(1)
        end,
        'Focus to Next Screen'
    },
    {'separator', 'Swap by Index'},
    -- ------------------------------------------------- --
    {
        'l',
        function()
            awful.client.swap.byidx(-1)
        end,
        'Swap with Previous'
    },
    {
        'h',
        function()
            awful.client.swap.byidx(1)
        end,
        'Swap with Next'
    },
    {'separator', 'Focus to Urgent'},
    {
        'u',
        function()
            awful.client.urgent.jumpto()
        end,
        'Jump to Urgent'
    },
    {'separator', ' '}
}

return focusmap
