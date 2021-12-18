--  _______                   ______                    __
-- |_     _|.---.-.-----.    |   __ \.----.-----.--.--.|__|.-----.--.--.--.
--   |   |  |  _  |  _  |    |    __/|   _|  -__|  |  ||  ||  -__|  |  |  |
--   |___|  |___._|___  |    |___|   |__| |_____|\___/ |__||_____|________|
--                |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function draw_widget(
    t,
    tag_preview_image,
    scale,
    screen_radius,
    client_radius,
    client_opacity,
    client_bg,
    client_border_color,
    client_border_width,
    widget_bg,
    widget_border_color,
    widget_border_width,
    geo,
    margin)
    local client_list = wibox.layout.manual()
    client_list.forced_height = geo.height
    client_list.forced_width = geo.width
    local tag_screen = t.screen
    for i, c in ipairs(t:clients()) do
        if not c.hidden and not c.minimized then
            local img_box =
                wibox.widget(
                {
                    image = gears.surface.load(c.icon),
                    resize = true,
                    forced_height = 100 * scale,
                    forced_width = 100 * scale,
                    widget = wibox.widget.imagebox
                }
            )

            if tag_preview_image then
                if c.prev_content or t.selected then
                    local content
                    if t.selected then
                        content = gears.surface(c.content)
                    else
                        content = gears.surface(c.prev_content)
                    end
                    local cr = cairo.Context(content)
                    local x, y, w, h = cr:clip_extents()
                    local img = cairo.ImageSurface.create(cairo.Format.ARGB32, w - x, h - y)
                    cr = cairo.Context(img)
                    cr:set_source_surface(content, 0, 0)
                    cr.operator = cairo.Operator.SOURCE
                    cr:paint()

                    img_box =
                        wibox.widget(
                        {
                            image = gears.surface.load(img),
                            resize = true,
                            opacity = client_opacity,
                            forced_height = math.floor(c.height * scale),
                            forced_width = math.floor(c.width * scale),
                            widget = wibox.widget.imagebox
                        }
                    )
                end
            end
            -- ########################################################################
            -- ########################################################################
            -- ########################################################################
            local client_box =
                wibox.widget(
                {
                    {
                        nil,
                        {
                            nil,
                            img_box,
                            nil,
                            expand = 'outside',
                            layout = wibox.layout.align.horizontal
                        },
                        nil,
                        expand = 'outside',
                        widget = wibox.layout.align.vertical
                    },
                    forced_height = math.floor(c.height * scale),
                    forced_width = math.floor(c.width * scale),
                    bg = client_bg,
                    shape_border_color = client_border_color,
                    shape_border_width = client_border_width,
                    shape = function(cr, width, height)
                        gears.shape.rounded_rect(cr, width, height, 12)
                    end,
                    widget = wibox.container.background
                }
            )

            client_box.point = {
                x = math.floor((c.x - geo.x) * scale),
                y = math.floor((c.y - geo.y) * scale)
            }

            client_list:add(client_box)
        end
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    return {
        {
            {
                {
                    {
                        client_list,
                        forced_height = geo.height,
                        forced_width = geo.width,
                        widget = wibox.container.place
                    },
                    layout = wibox.layout.align.horizontal
                },
                layout = wibox.layout.align.vertical
            },
            margins = margin,
            widget = wibox.container.margin
        },
        bg = widget_bg,
        shape_border_width = widget_border_width,
        shape_border_color = widget_border_color,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 12)
        end,
        widget = wibox.container.background
    }
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local enable = function(opts)
    local opts = opts or {}

    local tag_preview_image = true
    local widget_x = dpi(200)
    local widget_y = dpi(200)
    local scale = 0.25
    local work_area = true
    local padding = true
    local placement_fn = opts.placement_fn or nil

    local margin = dpi(3)
    local screen_radius = dpi(3)
    local client_radius = dpi(3)
    local client_opacity = 0.75
    local client_bg = beautiful.bg_focus
    local client_border_color = '#555e7099'
    local client_border_width = dpi(1)
    local widget_bg = {
        type = 'linear',
        from = {0, 0},
        to = {15, 12},
        stops = {{0, '#17191ecc'}, {6, '#3c3f4ccc'}, {12, '#22262dcc'}}
    }
    local widget_border_color = '#555e7099'
    local widget_border_width = dpi(1)

    local tag_preview_box =
        awful.popup(
        {
            type = 'dropdown_menu',
            visible = false,
            ontop = true,
            placement = placement_fn,
            widget = wibox.container.background,
            input_passthrough = true,
            bg = '#00000000'
        }
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    tag.connect_signal(
        'property::selected',
        function(t)
            for _, c in ipairs(t:clients()) do
                c.prev_content = gears.surface.duplicate_surface(c.content)
            end
        end
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    awesome.connect_signal(
        'tag_preview::update',
        function(t)
            local geo =
                t.screen:get_bounding_geometry(
                {
                    honor_padding = padding,
                    honor_workarea = work_area
                }
            )
            -- ########################################################################
            -- ########################################################################
            -- ########################################################################
            tag_preview_box.maximum_width = dpi(480)
            tag_preview_box.maximum_height = dpi(250)
            tag_preview_box:setup(
                draw_widget(
                    t,
                    tag_preview_image,
                    scale,
                    screen_radius,
                    client_radius,
                    client_opacity,
                    client_bg,
                    client_border_color,
                    client_border_width,
                    widget_bg,
                    widget_border_color,
                    widget_border_width,
                    geo,
                    margin
                )
            )
        end
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    awesome.connect_signal(
        'tag_preview::visibility',
        function(s, v)
            if not placement_fn then
                tag_preview_box.x = s.geometry.x + widget_x
                tag_preview_box.y = s.geometry.y + widget_y
            end

            tag_preview_box.visible = v
            collectgarbage()
        end
    )
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
return {enable = enable}
