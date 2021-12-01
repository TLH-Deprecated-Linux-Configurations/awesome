--  _______
-- |   _   |.-----.-----.
-- |       ||  _  |  _  |
-- |___|___||   __|   __|
--          |__|  |__|
--  ______
-- |   __ \.--.--.-----.
-- |      <|  |  |     |
-- |___|__||_____|__|__|

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- A not so impressive way of running the program just once
-- configuration.settings.application_runner.run_once("echo 'hello'")
-- ########################################################################
-- ########################################################################
-- ########################################################################
local ran_before = {}
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- If the input is empty, return false
--
local function run_once(cmd)
    if cmd == "" then
        return false
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Obviously, whatever is being run should be provided as a path, in string
    -- form, otherwise wtf is happening even
    --
    if not (type(cmd) == "string") then
        return false
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- if the command has not been run before, return false
    --
    if not (ran_before[cmd] == nil) then
        return false
    end

    ran_before[cmd] = true
    local findme = cmd
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- spaces make us able to read output
    --
    local firstspace = cmd:find(" ")
    if firstspace then
        findme = cmd:sub(0, firstspace - 1)
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Execute the command, with posix or bash, since the vast majority are written for one or the other.
    --
    print("Executing: " .. " " .. cmd)
    if findme == "sh" or findme == "bash" then
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- underlying functionality we are going to run the program with, else for
        -- when GNU names process and application differently
        awful.spawn.easy_async_with_shell(
            string.format("%s", cmd),
            function(stdout)
                print(stdout)
            end
        )
    else
        awful.spawn.easy_async_with_shell(
            string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd),
            function(stdout)
                print(stdout)
            end
        )
    end
    return true
end

return run_once
