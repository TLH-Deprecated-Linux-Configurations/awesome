--  ______
-- |      |.-----.--------.--------.-----.-----.
-- |   ---||  _  |        |        |  _  |     |
-- |______||_____|__|__|__|__|__|__|_____|__|__|

--  _______                    __   __
-- |    ___|.--.--.-----.----.|  |_|__|.-----.-----.-----.
-- |    ___||  |  |     |  __||   _|  ||  _  |     |__ --|
-- |___|    |_____|__|__|____||____|__||_____|__|__|_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- basic functions, not worth their own file but worth having written out
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- split - a separator
local function split(inputstr, sep)
    if not (type(sep) == "string") then
        sep = "%s"
    end
    if sep == "" then
        sep = "%s"
    end
    if not (type(inputstr) == "string") then
        return
    end
    local t = {}
    if inputstr == nil then
        return t
    end
    if inputstr == "" then
        return {""}
    end
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- turn numeric value into string
--
local function num_to_str(num, precision)
    if precision == nil then
        precision = 2
    end
    if type(num) == "number" then
        return string.format("%." .. tostring(precision) .. "f", num)
    end
    return tostring(num)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- sleep - idles for given length of time
local function sleep(time)
    if type(time) == "number" then
        if time < 0 then
            return
        end
        socket.select(nil, nil, time)
    end
end

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- provide number's si prefix
local function num_to_si_prefix(num, start)
    -- sanitize the input
    local number = num
    if type(num) == "string" then
        number = tonumber(num) or 0
    elseif not (type(num) == "number") then
        return num
    end

    local prefix = {"k", "M", "G", "T", "P", "E"}
    local index = start or 0
    while number >= 1000 do
        index = index + 1
        number = number / 1000
    end
    if index == 0 then
        return number
    end
    return num_to_str(number, 1) .. prefix[index]
end

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- make bytes comprehensible
local function bytes_to_grandness(bytes, start)
    -- sanitize the input
    local number = bytes
    if type(bytes) == "string" then
        number = tonumber(bytes) or 0
    elseif not (type(number) == "number") then
        return number
    end
    return num_to_si_prefix(number, start) .. "B"
end

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- returned focused screen, in case you don't trust awesome to do this
local function focused_screen()
    if mouse ~= nil and mouse.screen ~= nil then
        return mouse.screen
    end
    return awful.screen.focused() or screen[1]
end

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- make this available to the configuration
return {
    split = split,
    sleep = sleep,
    num_to_si_prefix = num_to_si_prefix,
    bytes_to_grandness = bytes_to_grandness,
    num_to_str = num_to_str,
    focused_screen = focused_screen
}
