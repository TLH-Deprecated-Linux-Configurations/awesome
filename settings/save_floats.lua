--  _______
-- |     __|.---.-.--.--.-----.
-- |__     ||  _  |  |  |  -__|
-- |_______||___._|\___/|_____|
--  _______ __               __
-- |    ___|  |.-----.---.-.|  |_.-----.
-- |    ___|  ||  _  |  _  ||   _|__ --|
-- |___|   |__||_____|___._||____|_____|
-- ------------------------------------------------- --
-- saves the geometry of floating windows for when they are restored to floating from tiling or at restart
-- ------------------------------------------------- --
-- relative positioning
local function rel(screen, win)
    return {
        x = (win.x - screen.x) / screen.width,
        y = (win.y - screen.y) / screen.height,
        width = win.width / screen.width,
        aspect = win.height / win.width
    }
end

-- ------------------------------------------------- --
-- un-relative the positioning ;]
local function unrel(s, rel)
    return rel and
        {
            x = s.x + s.width * rel.x,
            y = s.y + s.height * rel.y,
            width = s.width * rel.width,
            height = rel.aspect * s.width * rel.width
        }
end
-- ------------------------------------------------- --
-- object for storing the information in
local stored = {}
-- ------------------------------------------------- --
-- function to clear memory
local function forget(c)
    stored[c] = nil
end

local floating = awful.layout.suit.floating

-- ------------------------------------------------- --
-- function for remembering said positioning
function remember(c)
    if floating == awful.layout.get(c.screen) or c.floating then
        stored[c.window] = rel(c.screen.geometry, c:geometry())
    end
end
-- ------------------------------------------------- --
-- all of which means nada without a function to restore the geometry
function restore(c)
    local s = stored[c.window]
    if s then
        c:geometry(unrel(c.screen.geometry, stored[c.window]))
        return true
    else
        return false
    end
end
-- ------------------------------------------------- --
-- signals
client.connect_signal("manage", remember)
client.connect_signal("property::geometry", remember)
client.connect_signal("unmanage", forget)

tag.connect_signal(
    "property::layout",
    function(t)
        if floating == awful.layout.get(t.screen) then
            for _, c in ipairs(t:clients()) do
                c:geometry(unrel(t.screen.geometry, stored[c.window]))
            end
        end
    end
)

return restore
