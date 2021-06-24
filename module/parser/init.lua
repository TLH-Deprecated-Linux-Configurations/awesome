--  ______
-- |   __ \.---.-.----.-----.-----.----.
-- |    __/|  _  |   _|__ --|  -__|   _|
-- |___|   |___._|__| |_____|_____|__|

-- ########################################################################
-- ########################################################################
-- ########################################################################
local file_exists = require('module.file').exists
local split = require('lib.function.common').split

local function extract(line)
    local splitted = split(line, '=')
    if splitted[1] == nil or splitted[2] == nil then
        return nil
    end
    return splitted[1]:gsub('%s+', ''), splitted[2]:gsub('%s+', ''):gsub('"', ''):gsub("'", ''):gsub('`', '')
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function parse_file(file)
    local lines = {}
    for line in io.lines(file) do
        if not (line:sub(1, 1) == '#') then
            line = split(line, '#')[1]
            local data, payload = extract(line)
            if not (data == nil) then
                if type(lines[data]) == 'table' then
                    table.insert(lines[data], payload)
                elseif lines[data] == nil then
                    lines[data] = payload
                else
                    lines[data] = {lines[data]}
                    table.insert(lines[data], payload)
                end
            end
        end
    end
    return lines
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
return function(file)
    if not (type(file) == 'string') then
        return {}
    end
    print('Parsing file: ' .. file)
    if file_exists(file) then
        local result = parse_file(file)
        print('Finished parsing file: ' .. file)
        return result
    end
    return {}
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
