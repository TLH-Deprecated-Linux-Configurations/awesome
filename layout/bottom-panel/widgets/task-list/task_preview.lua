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
                                        id = 'image_role',
                                        resize = true,
                                        clip_shape = beautiful.window_shape,
                                        widget = wibox.widget.imagebox
                                    },
                                    valign = 'center',
                                    halign = 'center',
                                    widget = wibox.container.place
                                },
                                top = margin * 0.25,
                                widget = wibox.container.margin
                            },
                            fill_space = true,
                            layout = wibox.layout.fixed.vertical
                        },
                        margins = margin,
                        widget = wibox.container.margin
                    },
                    bg = widget_bg,
                    shape_border_width = dpi(0),
                    shape_border_color = beautiful.xcolor0 .. '33',
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
    for _, w in ipairs(widget:get_children_by_id('image_role')) do
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
    local widget_height = dpi(500)
    local widget_width = dpi(500)
    local placement_fn = opts.placement_fn or nil
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local margin = beautiful.task_preview_widget_margin or dpi(0)
    local screen_radius = beautiful.task_preview_widget_border_radius or dpi(0)
    local widget_bg = beautiful.task_preview_widget_bg or '#000000'
    local widget_border_color = beautiful.task_preview_widget_border_color or '#ffffff'
    local widget_border_width = beautiful.task_preview_widget_border_width or dpi(3)

    local task_preview_box =
        awful.popup(
        {
            type = 'dropdown_menu',
            visible = false,
            ontop = true,
            placement = placement_fn,
            widget = wibox.container.background, -- A dummy widget to make awful.popup not scream
            input_passthrough = true,
            bg = '#00000000'
        }
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    awesome.connect_signal(
        'task_preview::visibility',
        function(s, v, c)
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

            task_preview_box.visible = v
        end
    )
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
return {enable = enable}
