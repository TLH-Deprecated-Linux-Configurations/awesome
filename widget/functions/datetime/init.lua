--  _____         __
-- |     \.---.-.|  |_.-----.
-- |  --  |  _  ||   _|  -__|
-- |_____/|___._||____|_____|

--  _______ __
-- |_     _|__|.--------.-----.
--   |   | |  ||        |  -__|
--   |___| |__||__|__|__|_____|

-- ########################################################################
-- ########################################################################
-- ########################################################################
local split = require("widget.functions.common").split
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- leading zeros, makes dates look normal
--
local function numberZeroPadding(number)
    if not (type(number) == "number") then
        return "00"
    end
    if number < 0 then
        return tostring(number)
    end
    if number < 10 then
        return "0" .. number
    end
    return tostring(number)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- convert seconds to a more readable format
--
local function numberInSecToMS(number)
    if not (type(number) == "number") then
        return "00:00"
    end
    if number < 0 then
        return "00:00"
    end

    local minutes = math.floor(number / 60)
    local seconds = math.floor(number % 60)
    return numberZeroPadding(minutes) .. ":" .. numberZeroPadding(seconds)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- check if within band of time (in case you buy the light filter bs)
local function current_time_inbetween(time_start, time_end, mock_time)
    local time = os.date("*t")

    -- mock time is used in unit tests to verify if this function works as intended
    if not (mock_time == nil) then
        time = mock_time
    end

    if not (type(time_start) == "string") then
        return false
    end

    if not (type(time_end) == "string") then
        return false
    end

    local time_start_split = split(time_start, ":")
    local time_end_split = split(time_end, ":")
    local time_start_hour = tonumber(time_start_split[1])
    local time_start_min = tonumber(time_start_split[2])
    local time_end_hour = tonumber(time_end_split[1])
    local time_end_min = tonumber(time_end_split[2])

    if
        not (type(time_start_hour) == "number") or not (type(time_start_min) == "number") or
            not (type(time_end_hour) == "number") or
            not (type(time_end_min) == "number")
     then
        return false
    end

    if time_start_hour < 0 or time_start_min < 0 or time_end_hour < 0 or time_end_min < 0 then
        return false
    end

    if time_start_hour > 24 or time_start_min > 60 or time_end_hour > 24 or time_end_min > 60 then
        return false
    end

    local currentTimeInMin = (time.hour * 60) + time.min

    return currentTimeInMin >= ((time_start_hour * 60) + time_start_min) and
        currentTimeInMin <= ((time_end_hour * 60) + time_end_min)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- returns these functions so they are useful
return {
    numberZeroPadding = numberZeroPadding,
    numberInSecToMS = numberInSecToMS,
    current_time_inbetween = current_time_inbetween,
    unit_test_split = split
}
