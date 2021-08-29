--  _______              __         __ __
-- |     __|.-----.----.|__|.---.-.|  |__|.-----.-----.
-- |__     ||  -__|   _||  ||  _  ||  |  ||-- __|  -__|
-- |_______||_____|__|  |__||___._||__|__||_____|_____|

-- ########################################################################
-- ########################################################################
-- ########################################################################
local json = require("cjson")
local filehandle = require("module.functions.file")
-- ########################################################################
-- ########################################################################
-- ########################################################################
--- Serialize tables into a string representation
-- module.functions.serialize.serialize({1,2,3,4, {hello='world'}})
local function serialize(tbl)
    collectgarbage("collect")
    return json.encode(tbl)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
--- Deserialize a string into a tables
-- module.functions.serialize.deserialize("[1,2,3,4, {hello='world'}]")
local function deserialize(str)
    collectgarbage("collect")
    return json.decode(str)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
--- Serialize table and save it to a file
-- module.functions.serialize.serialize_to_file("file.json", {1,2,3,4, {hello='world'}})
local function serialize_to_file(file, tbl)
    collectgarbage("collect")
    local serialized = serialize(tbl)
    filehandle.overwrite(file, serialized)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
--- Deserialize data found in a file
-- local object = module.functions.serialize.deserialize_from_file("file.json")
local function deserialize_from_file(file)
    collectgarbage("collect")
    local str = filehandle.string(file)
    return deserialize(str)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
return {
    serialize = serialize,
    deserialize = deserialize,
    serialize_to_file = serialize_to_file,
    deserialize_from_file = deserialize_from_file
}
