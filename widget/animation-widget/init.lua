
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local animate = require("lib.animations").createAnimObject

local dpi = beautiful.xresources.apply_dpi

-- a widget container that is clickable
local clickable_container = require("widget.material.clickable-container")

-- the sizes to animate between
local start_size = dpi(100)
local end_size = dpi(400)

local offset = dpi(200)

-- convert the above widget into a button using clickable_container
local widget_button =
    clickable_container(
    --dpi(14) is used to take different screen sizes into consideration
    wibox.container.margin(wibox.widget.textbox("Press to start animating"), dpi(14), dpi(14), dpi(6), dpi(6))
)

local function bounce_animation_size(initial_offset)
    -- this rectangle will be animated
    local rect =
        wibox(
        {
            ontop = true,
            visible = true,
            x = mouse.screen.geometry.x + offset + initial_offset,
            y = mouse.screen.geometry.y + (mouse.screen.geometry.height / 2),
            type = "dock",
            bg = beautiful.accent.hue_800 .. "44",
            border_width = dpi(2),
            border_color = beautiful.accent.hue_800,
            width = dpi(100),
            height = dpi(100),
            screen = mouse.screen
        }
    )

    local startx = mouse.screen.geometry.x + offset - start_size + initial_offset
    local starty = mouse.screen.geometry.y + ((mouse.screen.geometry.height - start_size) / 2)
    local endx = mouse.screen.geometry.x + offset - end_size + initial_offset
    local endy = mouse.screen.geometry.y + ((mouse.screen.geometry.height - end_size) / 2)

    rect.x = startx
    rect.y = starty

    animate(
        2.5,
        rect,
        {width = end_size, height = end_size, x = endx, y = endy},
        "inBounce",
        function()
            animate(
                3.5,
                rect,
                {width = start_size, height = start_size, x = startx, y = starty},
                "outBounce",
                function()
                    rect.visible = false
                end
            )
        end
    )
end

local function bounce_animation_gravity(initial_offset)
    -- this rectangle will be animated
    local rect =
        wibox(
        {
            ontop = true,
            visible = true,
            x = mouse.screen.geometry.x + (offset * 2) + initial_offset,
            y = mouse.screen.geometry.y + (mouse.screen.geometry.height / 2),
            type = "dock",
            bg = beautiful.accent.hue_800 .. "44",
            border_width = dpi(2),
            border_color = beautiful.accent.hue_800,
            width = dpi(100),
            height = dpi(100),
            screen = mouse.screen
        }
    )

    local starty = mouse.screen.geometry.y + mouse.screen.geometry.height - start_size
    local endy = mouse.screen.geometry.y + (start_size * 2)

    rect.y = starty

    animate(
        3,
        rect,
        {y = endy},
        "inBounce",
        function()
            animate(
                3,
                rect,
                {y = starty},
                "outBounce",
                function()
                    rect.visible = false
                end
            )
        end
    )
end

local function bounce_animation_inout(initial_offset)
    -- this rectangle will be animated
    local rect =
        wibox(
        {
            ontop = true,
            visible = true,
            x = mouse.screen.geometry.x + mouse.screen.geometry.width + initial_offset,
            y = mouse.screen.geometry.y + (mouse.screen.geometry.height / 2),
            type = "dock",
            bg = beautiful.accent.hue_800 .. "44",
            border_width = dpi(2),
            border_color = beautiful.accent.hue_800,
            width = dpi(100),
            height = dpi(100),
            screen = mouse.screen
        }
    )

    local startx = mouse.screen.geometry.x + mouse.screen.geometry.width + initial_offset
    local endx = mouse.screen.geometry.x + (offset * 3) + initial_offset

    rect.x = startx

    animate(
        4,
        rect,
        {x = endx},
        "inOutBack",
        function()
            rect.visible = false
        end
    )
end

widget_button:buttons(
    gears.table.join(
        awful.button(
            {},
            -- 1 denotes left mouse button
            1,
            nil,
            -- function that is ran when left mouse button is pressed
            function()
                local box_size = dpi(100) + offset
                local total_size = box_size * 3 + (offset * 3)
                local start_center = mouse.screen.geometry.x + ((mouse.screen.geometry.width - total_size) / 2)
                bounce_animation_size(start_center)
                bounce_animation_gravity(start_center + box_size)
                bounce_animation_inout(start_center + (box_size * 2))
            end
        )
    )
)

-- return the clickable widget to be used as the widget
return widget_button
