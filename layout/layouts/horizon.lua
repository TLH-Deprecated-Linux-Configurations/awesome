--  _______              __
-- |   |   |.-----.----.|__|.-----.-----.-----.
-- |       ||  _  |   _||  ||-- __|  _  |     |
-- |___|___||_____|__|  |__||_____|_____|__|__|

-- ------------------------------------------------- --
-- NOTE: Area is divided into 1-3 even rows, then new
-- columns start after that. Basically thrizen on its side
-- ------------------------------------------------- --
-- --------------------- calls --------------------- --
local pairs = pairs

local horizon = {
    name = 'horizon'
}
-- --------------------- method -------------------- --
function horizon.arrange(p)
    local area = p.workarea
    local t = p.tag or screen[p.screen].selected_tag
    local mwfact = t.master_width_factor
    local nmaster = math.min(t.master_count, #p.clients)
    local nslaves = #p.clients - nmaster

    local master_area_height = area.height * mwfact
    local slave_area_height = area.height - master_area_height

    -- NOTE: Special case: no slaves
    if nslaves == 0 then
        master_area_height = area.height
        slave_area_height = 0
    end

    -- NOTE: Special case: no masters
    if nmaster == 0 then
        master_area_height = 0
        slave_area_height = area.height
    end

    -- NOTE: itearte through masters
    for idx = 1, nmaster do
        local c = p.clients[idx]
        local g = {
            x = area.x + (idx - 1) * (area.width / nmaster),
            y = area.y,
            width = area.width / nmaster,
            height = master_area_height
        }
        p.geometries[c] = g
    end

    -- NOTE: iterate through slaves
    for idx = 1, nslaves do
        local c = p.clients[idx + nmaster]
        local g = {
            x = area.x,
            y = area.y + master_area_height + (idx - 1) * (slave_area_height / nslaves),
            width = area.width,
            height = slave_area_height / nslaves
        }
        p.geometries[c] = g
    end
end

return horizon
