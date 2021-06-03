
local beautiful = require("beautiful")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi
local gears = require("gears")
local icons = require("theme.icons")
local menubar = require("menubar")
local filehandle = require("lib.file")
local hardware = require("lib.hardware-check")
local err = require("lib.logger").error
local signals = require("lib.signals")

local width = dpi(100)
local height = width

local amount = math.floor((mouse.screen.workarea.height / height) - 1)
local _count = 0

desktop_icons = {}
local text_name = {}
local icon_timers = {}

-- move all boxes relative to the selected box
local function move_selected_boxes(base, prev_base)
    local delta = {x = base.x - prev_base.x, y = base.y - prev_base.y}
    -- find all selected boxes (they have ontop = true)
    for _, value in ipairs(desktop_icons) do
        if value.ontop and not (value == base) then
            -- now we move this widget by the delta
            value.x = value.x + delta.x
            value.y = value.y + delta.y
        end
    end
end

-- clear all selected icons
local function clear_selections()
    for _, value in ipairs(desktop_icons) do
        value.unhover()
    end
end

_G.clear_desktop_selection = clear_selections

local function create_icon(icon, name, num, callback, drag)
    _count = _count + 1
    local x = 0
    local y = 0
    local active_theme = beautiful.accent

    if type(num) == "number" then
        x = dpi(10) + (math.floor((num / amount)) * (width + dpi(10)))
        y = dpi(36) + ((num % amount) * (height + dpi(10)))
    end

    if type(num) == "table" then
        x = num.x
        y = num.y
    end

    -- The offset used when dragging the icon
    local xoffset = 0
    local yoffset = 0
    -- To detect if a drag or a click happened
    local timercount = 0

    local box =
        wibox(
        {
            ontop = false,
            visible = true,
            x = x,
            y = y,
            type = "dock",
            bg = beautiful.background.hue_800 .. "00",
            width = width,
            height = height,
            screen = awful.screen.primary
        }
    )

    local timer =
        gears.timer {
        timeout = 1 / hardware.getDisplayFrequency(),
        call_now = false,
        autostart = false,
        callback = function()
            local offset = {x = box.x, y = box.y}
            local coords = mouse.coords()
            box.x = coords.x - xoffset
            box.y = coords.y - yoffset
            timercount = timercount + 1
            move_selected_boxes(box, offset)
        end
    }

    local started = false

    box:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                function()
                    -- Find the offset of the mouse relative to the start of the rectangle
                    local coords = mouse.coords()
                    xoffset = coords.x - box.x
                    yoffset = coords.y - box.y
                    if not started then
                        started = true
                        print("TIMER: started")
                        timer:start()
                    end
                    timercount = 0
                end,
                function()
                    if started then
                        started = false
                        print("TIMER: stopped")
                        timer:stop()
                    end
                    if type(drag) == "function" then
                        drag(name, box.x, box.y)
                    end
                    if timercount < 10 then
                        callback()
                    end
                end
            )
        )
    )

    local widget =
        wibox.widget {
        layout = wibox.layout.fixed.vertical,
        wibox.container.place(
            {
                image = icon,
                resize = true,
                forced_height = height - dpi(35),
                widget = wibox.widget.imagebox
            }
        ),
        wibox.container.place(
            {
                text = name,
                halign = "center",
                valign = "top",
                font = beautiful.title_font,
                widget = wibox.widget.textbox
            }
        ),
        forced_width = width
    }

    box.hover = function()
        box.ontop = true
        box.bg = active_theme.hue_600 .. "99"
    end

    box.unhover = function()
        box.ontop = false
        box.bg = active_theme.hue_800 .. "00"
    end

    widget:connect_signal("mouse::enter", box.hover)

    widget:connect_signal("mouse::leave", box.unhover)

    signals.connect_primary_theme_changed(
        function(theme)
            active_theme = theme
            box.bg = active_theme.hue_800 .. "00"
        end
    )

    box:setup {
        layout = wibox.layout.flex.vertical,
        widget,
        forced_width = width
    }
    table.insert(desktop_icons, box)
    table.insert(text_name, name)
    table.insert(icon_timers, timer)
    return box
end

local function desktop_file(file, _, index, drag)
    local name = "Desktop file"
    local icon = "application-x-executable"
    local lines = filehandle.lines(file)
    for _, line in ipairs(lines) do
        local nameMatch = line:match("Name=(.*)")
        local iconMatch = line:match("Icon=(.*)")

        if nameMatch and name == "Desktop file" then
            name = nameMatch
        elseif iconMatch and icon == "application-x-executable" then
            icon = iconMatch
        end
    end
    create_icon(
        menubar.utils.lookup_icon(icon) or icons.warning,
        name,
        index,
        function()
            print("Opened: " .. file)
            clear_selections()
            awful.spawn("gtk-launch " .. filehandle.basename(file))
        end,
        drag
    )
end

local function from_file(file, index, x, y, drag)
    local name = filehandle.basename(file)
    if name:match(".desktop$") then
        desktop_file(file, name, index or {x = x, y = y}, drag)
    else
        -- can be found here https://specifications.freedesktop.org/icon-naming-spec/latest/ar01s04.html
        create_icon(
            menubar.utils.lookup_icon("text-x-generic") or icons.warning,
            name,
            index or {x = x, y = y},
            function()
                print("Opened: " .. file)
                clear_selections()
                awful.spawn("open " .. file)
            end,
            drag
        )
    end
end

local function delete(name)
    local i = -1
    for index, value in ipairs(text_name) do
        if value == name then
            i = index
        end
    end
    if i == -1 or i > #desktop_icons then
        print("Trying to remove: " .. name .. " from the desktop but it no longer exists", err)
    end
    desktop_icons[i].visible = false
    icon_timers[i]:stop()
    table.remove(desktop_icons, i)
    table.remove(icon_timers, i)
    table.remove(text_name, i)
end

local function location_from_name(name)
    local i = -1
    for index, value in ipairs(text_name) do
        if value == name then
            i = index
        end
    end
    if not (i == -1) then
        return {x = desktop_icons[i].x, y = desktop_icons[i].y}
    end
    return {x = nil, y = nil}
end

return {
    from_file = from_file,
    create_icon = create_icon,
    delete = delete,
    location_from_name = location_from_name,
    count = function()
        return _count
    end
}
