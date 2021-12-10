--  _______               __         ______                    __
-- |_     _|.---.-.-----.|  |--.    |   __ \.----.-----.--.--.|__|.-----.--.--.--.
--   |   |  |  _  |__ --||    <     |    __/|   _|  -__|  |  ||  ||  -__|  |  |  |
--   |___|  |___._|_____||__|__|    |___|   |__| |_____|\___/ |__||_____|________|
-- ########################################################################
-- ########################################################################
-- ########################################################################

local function draw_widget(
    c,
    widget_template,
    screen_radius,
    widget_bg,
    widget_border_color,
    widget_border_width,
    margin,
    widget_width,
    widget_height)
    if
        not pcall(
            function()
                return type(c.content)
            end
        )
     then
        return
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local content = gears.surface(c.content)
    local cr = cairo.Context(content)
    local x, y, w, h = cr:clip_extents()
    local img = cairo.ImageSurface.create(cairo.Format.ARGB32, w - x, h - y)
    cr = cairo.Context(img)
    cr:set_source_surface(content, 0, 0)
    cr.operator = cairo.Operator.SOURCE
    cr:paint()
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local widget =
        wibox.widget(
        {
            (widget_template or
                {
                    {
                        {
                            {
                                {
                                    {
                                        id = "image_role",
                                        resize = true,
                                        clip_shape = beautiful.window_shape,
                                        widget = wibox.widget.imagebox
                                    },
                                    valign = "center",
                                    halign = "center",
                                    widget = wibox.container.place
                                },
                                top = dpi(1),
                                widget = wibox.container.margin
                            },
                            fill_space = true,
                            layout = wibox.layout.fixed.vertical
                        },
                        margins = margin,
                        widget = wibox.container.margin
                    },
                    bg = beautiful.bg_normal,
                    shape_border_width = dpi(1),
                    shape_border_color = beautiful.border_color,
                    shape = beautiful.window_shape,
                    widget = wibox.container.background
                }),
            width = widget_width,
            height = widget_height,
            widget = wibox.container.constraint
        }
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    for _, w in ipairs(widget:get_children_by_id("image_role")) do
        w.image = img
    end

    return widget
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local enable = function(opts)
    local opts = opts or {}

    local widget_x = dpi(40)
    local widget_y = dpi(40)
    local widget_height = dpi(300)
    local widget_width = dpi(500)
    local placement_fn = opts.placement_fn or nil
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local margin = dpi(2)
    local screen_radius = dpi(12)
    local widget_bg = beautiful.bg_normal
    local widget_border_color = beautiful.menu_border_color
    local widget_border_width = dpi(1)

    local task_preview_box =
        awful.popup(
        {
            visible = false,
            ontop = true,
            placement = placement_fn,
            widget = wibox.container.background, -- A dummy widget to make awful.popup not scream
            input_passthrough = true,
            bg = beautiful.xcolor0 .. "00"
        }
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    awesome.connect_signal(
        "task_preview::visibility",
        function(s, v, c)
            if not c.minimized then
                local geo =
                    c.screen:get_bounding_geometry(
                    {
                        honor_padding = true,
                        honor_workarea = true
                    }
                )
                if v then
                    -- Update task preview contents
                    task_preview_box.widget =
                        draw_widget(
                        c,
                        opts.structure,
                        screen_radius,
                        widget_bg,
                        widget_border_color,
                        widget_border_width,
                        margin,
                        widget_width,
                        widget_height
                    )
                end
                -- ########################################################################
                -- ########################################################################
                -- ########################################################################
                if not placement_fn then
                    task_preview_box.x = s.geometry.x + widget_x
                    task_preview_box.y = s.geometry.y + widget_y
                end
            else
                v = false
            end
            task_preview_box.visible = v
        end
    )
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
return {enable = enable}
