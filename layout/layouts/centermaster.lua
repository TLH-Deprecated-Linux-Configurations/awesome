--  ______               __                   _______               __
-- |      |.-----.-----.|  |_.-----.----.    |   |   |.---.-.-----.|  |_.-----.----.
-- |   ---||  -__|     ||   _|  -__|   _|    |       ||  _  |__ --||   _|  -__|   _|
-- |______||_____|__|__||____|_____|__|      |__|_|__||___._|_____||____|_____|__|
-- ------------------------------------------------- --
-- NOTE: Adapted from https://github.com/kotbaton/awesomewm-config
--
-- NOTE: The nelow demonstrates the tiling arrangement
-- provided by this file
--    +---+-----+---+
--    | 5 |     | 2 |
--    |   |     +---+
--    +---+  1  | 3 |
--    |   |     +---+
--    | 6 |     | 4 |
--    +---+-----+---+

-- --------------------- calls --------------------- --
local math = math
local screen = screen
-- --------------------- object -------------------- --
local centermaster = {}
-- -------------------- methods -------------------- --
function arrange(p)
    local area = p.workarea
    local t = p.tag or screen[p.screen].selected_tag
    local mwfact = t.master_width_factor
    local nmaster = math.min(t.master_count, #p.clients)
    local nslaves = #p.clients - nmaster

    local master_area_width = area.width * mwfact
    local slave_area_width = area.width - master_area_width
    local master_area_x = area.x + 0.5 * slave_area_width

    local number_of_left_sided_slaves = math.floor(nslaves / 2)
    local number_of_right_sided_slaves = nslaves - number_of_left_sided_slaves
    local left_iterator = 0
    local right_iterator = 0
    -- ------------------------------------------------- --
    -- NOTE: Special case: no maters -> rrelapse into awesomes fair layout
    if t.master_count == 0 then
        awful.layout.suit.fair.arrange(p)
        return
    end
    -- ------------------------------------------------- --
    -- NOTE: Special case: one slave -> relapse into awesomes masterstack tile layout
    if nslaves == 1 then
        awful.layout.suit.tile.right.arrange(p)
        return
    end
    -- ------------------------------------------------- --
    -- NOTE: Special case: no slaves -> fullscreen master area
    if nslaves < 1 then
        master_area_width = area.width
        master_area_x = area.x
    end
    -- ------------------------------------------------- --
    -- NOTE: iterate through masters
    for idx = 1, nmaster do
        local c = p.clients[idx]
        local g
        g = {
            x = master_area_x,
            y = area.y + (nmaster - idx) * (area.height / nmaster),
            width = master_area_width,
            height = area.height / nmaster
        }
        p.geometries[c] = g
    end
    -- ------------------------------------------------- --
    -- NOTE: iterate through slaves
    for idx = 1, nslaves do -- NOTE: idx=nmaster+1,#p.clients do
        local c = p.clients[idx + nmaster]
        local g
        if idx % 2 == 0 then
            g = {
                x = area.x,
                y = area.y + left_iterator * (area.height / number_of_left_sided_slaves),
                width = slave_area_width / 2,
                height = area.height / number_of_left_sided_slaves
            }
            left_iterator = left_iterator + 1
        else
            g = {
                x = area.x + master_area_width + slave_area_width / 2,
                y = area.y + right_iterator * (area.height / number_of_right_sided_slaves),
                width = slave_area_width / 2,
                height = area.height / number_of_right_sided_slaves
            }
            right_iterator = right_iterator + 1
        end
        p.geometries[c] = g
    end
end
-- ------------------------------------------------- --
centermaster.name = 'centermaster'

function centermaster.arrange(p)
    return arrange(p)
end
-- ------------------------------------------------- --
return centermaster
