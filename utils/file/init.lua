--  _______ __ __
-- |    ___|__|  |.-----.
-- |    ___|  |  ||  -__|
-- |___|   |__|__||_____|
-- ------------------------------------------------- --
-- provides interface for interacting with the filesystem
--  based on the work of Tom Meyers
-- ------------------------------------------------- --
-- check if a file or directory exists
local function exists(file)
    if not (type(file) == "string") then
        return false
    end
    -- we can't os.rename root but it exists (always)
    if file == "/" then
        return true
    end
    local ok, _, code = os.rename(file, file)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    return ok
end

--- Check if a file exists
local function file_exists(file)
    if type(file) ~= "string" then
        return false
    end
    return exists(file) and not exists(file .. "/")
end

--- Function equivalent to basename in POSIX systems
local function basename(str)
    if type(str) == "string" then
        local libgen = require("posix.libgen")
        return libgen.basename(str)
    end
    return nil
end

--- Function equivalent to dirname in POSIX systems
local function dirname(str)
    if type(str) == "string" then
        if string.sub(str, #str, #str) == "/" then
            return str
        end
        local libgen = require("posix.libgen")
        local result = libgen.dirname(str)

        if string.sub(result, #result, #result) == "/" then
            return result
        end

        return result .. "/"
    end
    return nil
end

--- Check if a directory exists

local function dir_exists(dir)
    if type(dir) ~= "string" then
        return false
    end
    if dir:sub(-1) == "/" then
        return exists(dir)
    end
    return exists(dir)
end

--- Recursively create a directory

local function dir_create(path)
    local stat = require("posix.sys.stat")
    local split = require("lib-tde.function.common").split
    local dir = dirname(path)
    if dir_exists(dir) then
        return
    end
    local components = split(dir, "/")

    local builder = ""
    if string.sub(dir, 1, 1) == "/" then
        builder = "/"
    end

    for _, component in ipairs(components) do
        builder = builder .. component .. "/"
        if not dir_exists(builder) then
            stat.mkdir(builder)
        end
    end
end

--- Override the entire file

local function overwrite(file, data)
    if type(file) ~= "string" then
        return false
    end
    dir_create(file)
    local fd = io.open(file, "w")
    fd:write(data .. "\n")
    fd:close()
    return true
end

--- Write data to a new file
local function write(file, data)
    if type(file) ~= "string" then
        return false
    end
    dir_create(file)
    local fd = io.open(file, "a")
    fd:write(data .. "\n")
    fd:close()
    return true
end

--- Get all lines from a file, returns an empty table if it doesn't exist
local function lines_from(file, match, head)
    local fullMatch = "^.*$"
    match = match or fullMatch
    if not file_exists(file) then
        return {}
    end
    local lines = {}
    local i = 0
    for line in io.lines(file) do
        i = i + 1

        if head ~= nil and i > head then
            return lines
        end
        if match == fullMatch then
            lines[#lines + 1] = line
        elseif string.match(line, match) then
            lines[#lines + 1] = line
        end
    end
    return lines
end

--- Put the content of a file into a string
local function getString(file, match, head)
    local res = lines_from(file, match, head)
    if type(res) == "string" then
        return res
    end
    return table.concat(res, "\n")
end

--- Return a table of filename found in a directory
local function list_dir(str)
    if not (type(str) == "string") then
        return {}
    end
    -- use posix compliant checks
    local M = require("posix.dirent")
    local ok, files = pcall(M.dir, str)
    if not ok then
        return {}
    end
    local ABS_files = {}
    for _, item in ipairs(files) do
        if not (item == ".") and not (item == "..") then
            table.insert(ABS_files, str .. "/" .. item)
        end
    end
    -- momentary check
    return ABS_files
end

--- Return a table of filename found in a directory and all child directories (be careful for big directories)
local function list_dir_full(str)
    if not (type(str) == "string") then
        return {}
    end
    local files = {}
    -- traverse the directory
    for _, value in ipairs(list_dir(str)) do
        if file_exists(value) then
            table.insert(files, value)
        else
            local filearr = list_dir_full(value)
            for _, val in ipairs(filearr) do
                table.insert(files, val)
            end
        end
    end
    return files
end

--- Function to remove a file for the filesystem
--@param string filename the path to the file
local function rm(filename)
    -- make sure we don't destroy the root :-)
    if filename == "/" then
        return
    end
    if dir_exists(filename) then
        local execute = require("lib-tde.hardware-check").execute

        return execute("rm -rf " .. filename)
    end
    return os.remove(filename)
end

--- Function to create a temporary file in /tmp
local function mktemp()
    local _, file = require("posix.stdlib").mkstemp("/tmp/tde.XXXXXX")
    return file
end

--- Function to create a temporary directory in /tmp
local function mktempdir()
    local dir = require("posix.stdlib").mkdtemp("/tmp/tde.d.XXXXXX")
    return dir
end

local function log(filename)
    -- tests the functions above
    local lines = lines_from(filename)

    -- print all line numbers and their contents
    for k, v in pairs(lines) do
        print("line[" .. k .. "]", v)
    end
end

return {
    log = log,
    lines = lines_from,
    string = getString,
    exists = file_exists,
    dir_exists = dir_exists,
    list_dir = list_dir,
    list_dir_full = list_dir_full,
    write = write,
    overwrite = overwrite,
    basename = basename,
    dirname = dirname,
    dir_create = dir_create,
    rm = rm,
    mktemp = mktemp,
    mktempdir = mktempdir
}
