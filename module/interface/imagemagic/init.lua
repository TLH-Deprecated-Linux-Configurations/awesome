--  _______
-- |_     _|.--------.---.-.-----.-----.
--  _|   |_ |        |  _  |  _  |  -__|
-- |_______||__|__|__|___._|___  |_____|
--                         |_____|
--  _______               __        __
-- |   |   |.---.-.-----.|__|.----.|  |--.
-- |       ||  _  |  _  ||  ||  __||    <
-- |__|_|__||___._|___  ||__||____||__|__|
--                |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local hardware = require("module.hardware.hardware-check")

local is_installed = hardware.has_package_installed("imagemagick")

local LOG_ERROR = "\27[0;31m[ ERROR "
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function check()
    if not is_installed then
        print("Cannot use imagemagic api, it is not installed!", LOG_ERROR)
    end
    return not is_installed
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
--- Scale an image to a specific size
local function scale(input, width, height, output, callback)
    -- make sure it works
    if check() then
        return
    end
    local cmd = "convert '" .. input .. "' -resize " .. width .. "x" .. height .. "\\! '" .. output .. "'"
    awful.spawn.easy_async_with_shell(
        cmd,
        function()
            print("Finished converting image " .. input .. " to " .. width .. "x" .. height)
            callback()
        end
    )
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
--- Convert your image to be grayscale
local function grayscale(input, output, callback)
    -- make sure it works
    if check() then
        return
    end
    local cmd = "convert '" .. input .. "' -type Grayscale '" .. output .. "'"
    awful.spawn.easy_async_with_shell(
        cmd,
        function()
            print("Finished converting image " .. input .. " to grayscale")
            callback()
        end
    )
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
--- Make a color in an image transparent
local function transparent(input, output, color, callback)
    -- make sure it works
    if check() then
        return
    end
    local cmd = "convert '" .. input .. "' -fuzz 10% -transparent " .. color .. " '" .. output .. "'"
    awful.spawn.easy_async_with_shell(
        cmd,
        function()
            print("Finished color " .. color .. " to be transparent in " .. input)
            callback()
        end
    )
end

-- ########################################################################
-- ########################################################################
-- ########################################################################
--- Compress an image to save disk space and memory consumption
local function compress(input, output, rate, callback)
    -- make sure it works
    if check() then
        return
    end
    local cmd =
        "convert '" ..
        input ..
            "' -sampling-factor 4:2:0 -strip -quality " ..
                tostring(rate) .. " -interlace JPEG -colorspace RGB '" .. output .. "'"
    awful.spawn.easy_async_with_shell(
        cmd,
        function()
            print("Finished compressing " .. input)
            callback()
        end
    )
end

-- ########################################################################
-- ########################################################################
-- ########################################################################
--- Convert from one image type to another
local function convert(input, output, callback)
    -- make sure it works
    if check() then
        return
    end
    local cmd = "convert '" .. input .. "' '" .. output .. "'"
    awful.spawn.easy_async_with_shell(
        cmd,
        function()
            print("Finished converting from " .. input .. " to " .. output)
            callback()
        end
    )
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
return {
    scale = scale,
    grayscale = grayscale,
    transparent = transparent,
    compress = compress,
    convert = convert
}
