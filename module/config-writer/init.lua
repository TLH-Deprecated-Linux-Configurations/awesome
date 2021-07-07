--  ______               ___ __             ________        __ __
-- |      |.-----.-----.'  _|__|.-----.    |  |  |  |.----.|__|  |_.-----.----.
-- |   ---||  _  |     |   _|  ||  _  |    |  |  |  ||   _||  |   _|  -__|   _|
-- |______||_____|__|__|__| |__||___  |    |________||__|  |__|____|_____|__|
--                              |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local parser = require("module.parser")
local file_handle = require("module.file")
-- ########################################################################
-- ########################################################################
-- ########################################################################
--- Update an entry in a configuration file
-- @tparam string file The path to the file, can be both absolute or relative.
-- @tparam string field The specific configuration field to update
-- @tparam string value The value that the configuration field should contain
-- @treturn bool if the write was successful
-- @staticfct update_entry
-- @usage -- This will create the content in hallo.txt to var=value
-- module.file.update_entry("hallo.txt", "var", "value")
local function update_entry(file, field, value)
    if not file_handle.exists(file) then
        return false
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- lets parse the existing file
    local parsed = parser(file)
    -- our field doesn't exist, let's add it
    if parsed[field] == nil then
        print("Appending file")
        file_handle.write(file, "\n" .. field .. '="' .. value .. '"\n')
        return true
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- our field already exists, we need to alter them
    local lines = file_handle.lines(file)
    local result = ""
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    for i, line in ipairs(lines) do
        if string.match(line, "^ *" .. field .. ' *= *[\'"].*[\'"]') then
            -- ########################################################################
            -- ########################################################################
            -- ########################################################################
            result = result .. field .. '="' .. value .. '"\n'
        else
            -- otherwise a lot of newlines will appear in the config file
            if not (i == #lines) then
                result = result .. line .. "\n"
            else
                result = result .. line
            end
        end
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    print("Overwriting file")
    return file_handle.overwrite(file, result)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################

return {update_entry = update_entry}
