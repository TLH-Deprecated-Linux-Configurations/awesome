--  _______
-- |   |   |.-----.--.--.-----.-----.----.
-- |       ||  _  |  |  |__ --|  -__|   _|
-- |__|_|__||_____|_____|_____|_____|__|
-- ------------------------------------------------- --
-- inspiration: https://github.com/basaran/awesomewm-micky/blob/master/init.lua
-- ------------------------------------------------- --
----------------- variables ------------------- --
-- -- these classes prevent mouse from shift if in this a clinet that is a member thereof.
local stay_classes = {
    awesome,
    wibox
    -- 'gimp',
    -- 'krita'
}
-- ------------------------------------------------- --
-- -------------------- Methods -------------------- --

local function set_contains(set, key)
    return set[key] ~= nil
end

local mouser = function()
    gears.timer.weak_start_new(
        0.01,
        function()
            local c = client.focus
            local cgeometry = c:geometry()

            mouse.coords(
                {
                    x = cgeometry.x + cgeometry.width / 2,
                    y = cgeometry.y + cgeometry.height / 2
                }
            )
        end
    )
end
-- ------------------------------------------------- --
-- -------------------- signals -------------------- --

client.connect_signal(
    'focus',
    function(c)
        local focused_client = c
        --+ client the focus is going towards

        gears.timer.weak_start_new(
            0.1,
            function()
                local client_under_mouse = mouse.current_client
                local should_stay = set_contains(stay_classes, client_under_mouse.class)

                if should_stay then
                    return
                end

                -- if compare_coords(focused_client) then return false end
                --+ avoid tabs

                if not client_under_mouse then
                    mouser()
                    return
                end
                --+ nothing under the mouse, move directly

                if
                    focused_client:geometry().x ~= client_under_mouse:geometry().x or
                        focused_client:geometry().y ~= client_under_mouse:geometry().y
                 then
                    mouser()
                    return
                end
                --+ no need to relocate the mouse if already over
                --> the client.
            end
        )
        --+ mouse.current_client would point to the previous
        --> client without the callback.
    end
)

client.connect_signal(
    'manage',
    function(c)
        local client_under_mouse = mouse.current_client

        if client_under_mouse ~= c then
            mouser()
            return
        end
        --+ no need for the callback here.
    end
)

-- ------------------------------------------------- --
return mouser
