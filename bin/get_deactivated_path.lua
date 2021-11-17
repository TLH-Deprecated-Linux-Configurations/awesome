-- ########################################################################
--  _______         __
-- |     __|.-----.|  |_
-- |    |  ||  -__||   _|
-- |_______||_____||____|
--  _____                    __   __               __            __
-- |     \.-----.---.-.----.|  |_|__|.--.--.---.-.|  |_.-----.--|  |
-- |  --  |  -__|  _  |  __||   _|  ||  |  |  _  ||   _|  -__|  _  |
-- |_____/|_____|___._|____||____|__| \___/|___._||____|_____|_____|
--  ______         __   __
-- |   __ \.---.-.|  |_|  |--.
-- |    __/|  _  ||   _|     |
-- |___|   |___._||____|__|__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- I didn't have anything to do with this file, just the header above. This
-- was put here by hererocks which is lua's awesome way around pip virtualenv
-- hell or global, yarn path variable hells. Its like node_modules, but also
-- rolls in nvm functionality that stays in the repo no need for virtual nothing
-- just source the file and run luarocks in the directory and it will actually work
--
local path = os.getenv("PATH")
local dir_sep = package.config:sub(1, 1)
local path_sep = dir_sep == "\\" and ";" or ":"
local hererocks_path = "/home/tlh/.config/awesome" .. dir_sep .. "bin"
local new_path_parts = {}
local for_fish = arg[1] == "--fish"

if for_fish then
    io.stdout:write("set -gx PATH ")
end

for path_part in (path .. path_sep):gmatch("([^" .. path_sep .. "]*)" .. path_sep) do
    if path_part ~= hererocks_path then
        if for_fish then
            path_part = "'" .. path_part:gsub("'", [[''']]) .. "'"
        end

        table.insert(new_path_parts, path_part)
    end
end

io.stdout:write(table.concat(new_path_parts, for_fish and " " or path_sep))
