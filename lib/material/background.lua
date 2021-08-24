local wibox = require('wibox')
local beautiful = require('beautiful')
local helper = require('lib.material.helper')
local function new(self, ...)
    local instance = setmetatable({}, {__index = self})
    return instance:init(...) or instance
end

-- Function to create object in lua - used globally
local function class(base)
    return setmetatable({new = new}, {__call = new, __index = base})
end

local root_bg = class()

function root_bg:init(args)
    self.color = args.color
    self.shape = args.shape or helper.rrect(10)
    self.w =
        wibox.widget {
        bg = beautiful.xbackground .. '00',
        shape = self.shape,
        widget = wibox.container.background
    }
end

-- opacity state
-- https://material.io/design/color/dark-theme.html#states
function root_bg:signals()
    self.w:connect_signal(
        'mouse::enter',
        function()
            self.w.bg = self.color .. '0A' -- 4%
        end
    )
    self.w:connect_signal(
        'mouse::leave',
        function()
            self.w.bg = self.color .. '00'
        end
    )
    self.w:connect_signal(
        'button::press',
        function()
            self.w.bg = self.color .. '1F' -- 12%
        end
    )
    self.w:connect_signal(
        'button::release',
        function()
            self.w.bg = self.color .. '00'
        end
    )
end

local mat_bg = class(root_bg)

function mat_bg:init(args)
    root_bg.init(self, args)
    root_bg.signals(self)
    return self.w
end

return mat_bg
