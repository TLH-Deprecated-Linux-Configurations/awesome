--  _______
-- |   |   |.-----.--.--.-----.-----.----.
-- |       ||  _  |  |  |__ --|  -__|   _|
-- |__|_|__||_____|_____|_____|_____|__|

-- ------------------------------------------------- --
----------------- variables ------------------- --
-- these classes prevent mouse from shift if in this a clinet that is a member thereof.
local stay_classes = {
    awesome,
    taskbar,
    'gimp',
    'krita'
}

-- -------------------- Methods -------------------- --

local function set_contains(set, key)
    return set[key] ~= nil
end

-- ------------------------------------------------- --
--+ relocate mouse after slightly waiting for focus to
--> complete. you can adjust the timer if you are on a slow
--> cpu to give more time for the client to appear.

local mouser = function()
    gears.timer.weak_start_new(
        0.05,
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
            0.15,
            function()
                local client_under_mouse = mouse.current_client
                local should_stay = set_contains(stay_classes, client_under_mouse.class)

                if should_stay then
                    return false
                end
                --+ exclusions

                -- if compare_coords(focused_client) then return false end
                --+ avoid tabs

                if not client_under_mouse then
                    mouser()
                    return false
                end
                --+ nothing under the mouse, move directly

                if focused_client:geometry().x ~= client_under_mouse:geometry().x or focused_client:geometry().y ~= client_under_mouse:geometry().y then
                    mouser()
                    return false
                end
                --+ no need to relocate the mouse if already over
                --> the client.
            end
        )
        --+ mouse.current_client would point to the previous
        --> client without the callback.
    end
)
-- ------------------------------------------------- --
client.connect_signal(
    'unmanage',
    function(c)
        local client_under_mouse = mouse.current_client

        if not client_under_mouse then
            return false
        end

        if client_under_mouse ~= c then
            mouser()
        end
        --+ no need for the callback here.
    end
)

-- ------------------------------------------------- --
return mouser
