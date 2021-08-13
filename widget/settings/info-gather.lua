--  _______         ___             _______         __   __
-- |_     _|.-----.'  _|.-----.    |     __|.---.-.|  |_|  |--.-----.----.-----.----.
--  _|   |_ |     |   _||  _  |    |    |  ||  _  ||   _|     |  -__|   _|  -__|   _|
-- |_______||__|__|__|  |_____|    |_______||___._||____|__|__|_____|__| |_____|__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
--
local signals = require("module.settings.signals")
local hardware = require("module.hardware.hardware-check")
local filehandle = require("module.functions.file")
local config = require("module.functions")
local delayed_timer = require("lib.function.delayed-timer")
local statvfs = require("posix.sys.statvfs").statvfs
local common = require("lib.function.common")
local beautiful = require("beautiful")
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function get_username()
    -- get the username
    local username = os.getenv("USER")

    -- make the first letter capital
    local name = username:sub(1, 1):upper() .. username:sub(2)
    signals.emit_username(name)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function get_distro_name()
    -- get the distro
    if filehandle.exists("/etc/os-release") then
        local lines = filehandle.lines("/etc/os-release")
        for _, line in ipairs(lines) do
            if string.find(line, "NAME") then
                local distroname = line:match('"(.*)"')
                signals.emit_distro(distroname)
                break
            end
        end
    end
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function get_uptime()
    -- get the uptime
    awful.widget.watch(
        "uptime -p",
        beautiful.modal_height,
        function(_, stdout)
            local uptime = string.gsub(stdout, "%\n", "") or ""
            signals.emit_uptime(uptime)
        end
    )
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function get_ram_info()
    delayed_timer(
        config.ram_poll,
        function()
            local usage, total = hardware.getRamInfo()
            signals.emit_ram_usage(usage)
            signals.emit_ram_total(common.num_to_str(total))
            print("Ram usage: " .. usage .. "%")
        end,
        config.ram_startup_delay
    )
end

-- ########################################################################
-- ########################################################################
-- ########################################################################
local function get_cpu_info()
    delayed_timer(
        config.cpu_poll,
        function()
            local out = hardware.getCpuInfo()
            signals.emit_cpu_usage(out)
            print("CPU usage: " .. out .. "%")
        end,
        config.cpu_startup_delay
    )
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function get_disk_info()
    delayed_timer(
        config.harddisk_poll,
        function()
            local res = statvfs("/")
            local usage = ((res.f_blocks - res.f_bfree) / res.f_blocks) * 100

            -- by default f_blocks is in 512 byte chunks
            local block_size = res.f_frsize or 512
            local size_in_bytes = res.f_blocks * block_size

            print("Hard drive size: " .. size_in_bytes .. "b")
            print("Hard drive usage: " .. usage .. "%")

            signals.emit_disk_usage(usage)
            signals.emit_disk_space(common.bytes_to_grandness(size_in_bytes))
        end,
        config.harddisk_startup_delay
    )
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function init()
    get_username()
    get_distro_name()
    get_uptime()
    get_cpu_info()
    get_ram_info()
    get_disk_info()
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
init()
