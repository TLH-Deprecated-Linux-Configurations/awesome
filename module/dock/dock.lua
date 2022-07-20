--  _____              __
-- |     \.-----.----.|  |--.
-- |  --  |  _  |  __||    <
-- |_____/|_____|____||__|__|
-- ------------------------------------------------- --
-- where the magic is happening
-- ------------------------------------------------- --
local Get_icon = require('utilities.ui.icon_handler')
-- helpful functions
local function helpers()
    local function overloaded()
        local fns = {}
        local mt = {}
        local function oerror()
            return error('Invalid argument types to overloaded function')
        end
        function mt:__call(...)
            local arg = {...}
            local default = self.default
            local signature = {}
            for i, arg in ipairs({...}) do
                signature[i] = type(arg)
            end
            signature = table.concat(signature, ',')
            return (fns[signature] or self.default)(...)
        end
        function mt:__index(key)
            local signature = {}
            local function __newindex(self, key, value)
                print(key, type(key), value, type(value))
                signature[#signature + 1] = key
                fns[table.concat(signature, ',')] = value
                print('bind', table.concat(signature, ', '))
            end
            local function __index(self, key)
                print('I', key, type(key))
                signature[#signature + 1] = key
                return setmetatable({}, {__index = __index, __newindex = __newindex})
            end
            return __index(self, key)
        end
        function mt:__newindex(key, value)
            fns[key] = value
        end
        return setmetatable({default = oerror}, mt)
    end
    -- ------------------------------------------------- --

    local function dec_hex(IN)
        local B, K, OUT, I, D = 16, '0123456789ABCDEF', '', 0
        while IN > 0 do
            I = I + 1
            IN, D = math.floor(IN / B), (IN % B) + 1
            OUT = string.sub(K, D, D) .. OUT
        end
        return #OUT == 2 and OUT or '0' .. OUT
    end

    -- ------------------------------------------------- --
    local color = {}

    color.col_shift = overloaded()
    color.col_shift.string.number = function(c, s)
        local r, g, b, o = gears.color.parse_color(c)
        return '#' .. dec_hex(r * 255 + s) .. dec_hex(g * 255 + s) .. dec_hex(b * 255 + s) .. dec_hex(o * 255)
    end
    color.col_shift.string.number.number.number = function(c, sr, sg, sb)
        local r, g, b, o = gears.color.parse_color(c)
        return '#' .. dec_hex(r * 255 + sr) .. dec_hex(g * 255 + sg) .. dec_hex(b * 255 + sb) .. dec_hex(o * 255)
    end
    color.col_shift.string.number.number.number.number = function(c, sr, sg, sb, so)
        local r, g, b, o = gears.color.parse_color(c)
        return '#' .. dec_hex(r * 255 + sr) .. dec_hex(g * 255 + sg) .. dec_hex(b * 255 + sb) .. dec_hex(o * 255 + so)
    end

    color.col_diff = function(f, s)
        local fr, fg, fb, fo = gears.color.parse_color(f)
        local sr, sg, sb, so = gears.color.parse_color(s)
        return sr - fr, sg - fg, sb - fb, so - fo
    end
    --}}}
    return {
        color = color
    }
end

local chel = helpers().color
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- -------------------- Methods -------------------- --
--local function init(s, h, o, shape, pinneds)
local function init(args)
    local s = args.screen
    local h = args.height or dpi(50)
    local o = args.offset or dpi(5)
    local inner_shape = beautiful.client_shape_rounded_xl
    local outer_shape = beautiful.client_shape_rounded_lg

    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    local tasklist =
        awful.widget.tasklist(
        {
            screen = s,
            source = function()
                local ret = {}
                for _, t in ipairs(s.tags) do
                    gears.table.merge(ret, t:clients())
                end
                return ret
            end, --sorts clients in order of their tags
            filter = awful.widget.tasklist.filter.currenttags,
            forced_height = h,
            layout = {
                layout = wibox.layout.fixed.horizontal
            },
            widget_template = {
                {
                    {
                        nil,
                        {
                            {
                                nil,
                                {
                                    id = 'icon',
                                    image = icons.awesome,
                                    resize = true,
                                    widget = wibox.widget.imagebox,
                                    halign = 'center',
                                    valign = 'center'
                                },
                                nil,
                                layout = wibox.layout.align.horizontal,
                                shape = inner_shape,
                                id = 'layout_icon',
                                widget = wibox.container.background,
                                bg = beautiful.bg_button
                            },
                            widget = wibox.container.margin,
                            margins = dpi(10)
                        },
                        {
                            {
                                wibox.widget.base.make_widget(),
                                forced_height = h / 10,
                                forced_width = h / 10,
                                id = 'status',
                                bg = beautiful.bg_button,
                                shape = inner_shape,
                                widget = wibox.container.background
                            },
                            widget = wibox.container.place --so the bg widget doesnt get stretched
                        },
                        layout = wibox.layout.align.vertical
                    },
                    id = 'bg',
                    widget = wibox.container.background,
                    bg = beautiful.bg_button,
                    shape = outer_shape
                },
                widget = wibox.container.margin,
                margins = dpi(5),
                forced_height = h,
                forced_width = h,
                create_callback = function(self, c, _, _)
                    self:get_children_by_id('icon')[1].image = Get_icon(beautiful.icon_theme, nil, c.name, c.class)
                    local function hover(p, t) --so gc can collect all the timed objects that are flying around
                        local on_hover =
                            rubato.timed(
                            {
                                intro = 0.02,
                                outro = 0.02,
                                duration = 0.2,
                                rate = 30,
                                pos = p,
                                subscribed = function(pos)
                                    self:get_children_by_id('bg')[1].bg = beautiful.bg_menu
                                end
                            }
                        )
                        on_hover.target = t
                    end
                    local function release(p, t) --so gc can collect all the timed objects that are flying around
                        local on_release =
                            rubato.timed(
                            {
                                intro = 0.02,
                                outro = 0.02,
                                duration = 0.2,
                                rate = 30,
                                pos = p,
                                subscribed = function(pos)
                                    self:get_children_by_id('bg')[1].bg = beautiful.bg_button
                                end
                            }
                        )
                        on_release.target = t
                    end
                    self:connect_signal(
                        'mouse::enter',
                        function()
                            hover(0, 60)
                        end
                    )
                    self:connect_signal(
                        'mouse::leave',
                        function()
                            release(60, 0)
                        end
                    )
                    self:add_button(
                        awful.button(
                            {
                                modifiers = {},
                                button = 1,
                                on_press = function()
                                    if not c.active then
                                        c:activate(
                                            {
                                                context = 'through_dock',
                                                switch_to_tag = true
                                            }
                                        )
                                    else
                                        c.minimized = true
                                    end
                                end
                            }
                        )
                    )
                end,
                update_callback = function(self, c, _, _) --praying to the gc that this is getting cleared properly, didnt show problems in testing
                    collectgarbage('collect')
                    local status_w =
                        rubato.timed(
                        {
                            intro = 0.02,
                            outro = 0.02,
                            duration = 0.1,
                            rate = 30,
                            pos = self:get_children_by_id('status')[1].forced_width,
                            subscribed = function(pos)
                                self:get_children_by_id('status')[1].forced_width = pos
                            end
                        }
                    )
                    local bg_col = beautiful.bg_button
                    local accent_col = beautiful.accent

                    local status_c =
                        rubato.timed(
                        {
                            intro = 0.04,
                            outro = 0.04,
                            duration = 0.2,
                            rate = 30,
                            pos = 0,
                            subscribed = function(pos)
                                self:get_children_by_id('status')[1].bg = colors.alpha(colors.white, '88')
                            end
                        }
                    )
                    -- ------------------------------------------------- --
                    --this here sets width and colors depending on the status of the client a widget in the tasklist represents
                    if c.active then
                        status_w.target = h / 2
                        status_c.target = 1
                    elseif c.minimized then
                        status_w.target = h / 6
                        status_c.target = 0
                    else
                        status_w.target = h / 4
                        status_c.target = 0
                    end
                end
            }
        }
    )
    -- ------------------------------------------------- --
    local dock_box =
        awful.popup(
        {
            ontop = true,
            screen = s,
            x = s.geometry.x + s.geometry.width / 2,
            y = s.geometry.y + s.geometry.height - (h + o),
            shape = outer_shape,
            widget = {
                {
                    {
                        tasklist,
                        layout = wibox.layout.fixed.horizontal
                    },
                    widget = wibox.container.margin,
                    margin = dpi(2)
                },
                widget = wibox.container.background,
                shape = inner_shape
            }
        }
    )

    dock_box:connect_signal(
        'property::width',
        function()
            --for centered placement, wanted to keep the offset
            dock_box.x = s.geometry.x + s.geometry.width / 2 - dock_box.width / 2
        end
    )

    local autohideanim =
        rubato.timed(
        {
            intro = 0.3,
            outro = 0.1,
            duration = 0.4,
            pos = 0,
            rate = 60,
            easing = rubato.quadratic,
            subscribed = function(pos)
                dock_box.y = s.geometry.y + s.geometry.height - ((pos * h) + o)
                dock_box.opacity = pos
            end
        }
    )
    local autohidetimer =
        gears.timer(
        {
            timeout = 4,
            single_shot = true,
            callback = function()
                autohideanim.target = 0
            end
        }
    )
    dock_box:connect_signal(
        'mouse::leave',
        function()
            autohidetimer:again()
        end
    )
    dock_box:connect_signal(
        'mouse::enter',
        function()
            autohideanim.target = 1
            autohidetimer:stop()
        end
    )
    return dock_box
end

return {
    init = init
}
