---------------------------------------------------------------------------
-- A container used to place smaller widgets into larger space.
--
--@DOC_wibox_container_defaults_place_EXAMPLE@
-- @author Emmanuel Lepage Vallee &lt;elv1313@gmail.com&gt;
-- @copyright 2016 Emmanuel Lepage Vallee
-- @release @AWESOME_VERSION@
-- @classmod wibox.container.place
---------------------------------------------------------------------------

local setmetatable = setmetatable
local base = require("wibox.widget.base")
local gtable = require("gears.table")

local place = { mt = {} }

-- Take the widget width/height and compute the position from the full
-- width/height
local align_fct = {
    left   = function(_  , _   ) return 0                         end,
    center = function(wdg, orig) return math.max(0, (orig-wdg)/2) end,
    right  = function(wdg, orig) return math.max(0, orig-wdg    ) end,
}
align_fct.top, align_fct.bottom = align_fct.left, align_fct.right

local function get_grown_size(self, context, width, height)
    local priv, dpi = self._private, context.dpi
    local w, h = base.fit_widget(self, context, self._private.widget, width, height)

    if priv.grow_horizontal then
        priv.grow_hcache[dpi] = math.max(w, priv.grow_hcache[dpi] or -1)
    end

    if priv.grow_vertical then
        priv.grow_vcache[dpi] = math.max(h, priv.grow_vcache[dpi] or -1)
    end

    return w, h, priv.grow_hcache[dpi], priv.grow_vcache[dpi]
end

-- Layout this layout
function place:layout(context, width, height)
    if not self._private.widget then return end

    local w, h = get_grown_size(self, context, width, height)
    w = self._private.content_fill_horizontal and width  or w
    h = self._private.content_fill_vertical   and height or h

    assert(w and h)

    local valign = self._private.valign or "center"
    local halign = self._private.halign or "center"

    local x, y = align_fct[halign](w, width), align_fct[valign](h, height)

    return { base.place_widget_at(self._private.widget, x, y, w, h) }
end

-- Fit this layout into the given area
function place:fit(context, width, height)
    if not self._private.widget then return 0, 0 end

    local priv = self._private
    local w, h, cw, ch = get_grown_size(self, context, width, height)

    width  = (priv.fill_horizontal or priv.content_fill_horizontal) and width or cw or w
    height = (priv.fill_vertical or priv.content_fill_vertical) and height or ch or h

    assert(width and height)

    return width, height
end

--- The widget to be placed.
-- @property widget
-- @tparam widget widget The widget

function place:set_widget(widget)
    if widget then
        base.check_widget(widget)
    end

    self._private.widget = widget
    self:emit_signal("widget::layout_changed")
end

function place:get_widget()
    return self._private.widget
end

--- Get the number of children element
-- @treturn table The children
function place:get_children()
    return {self._private.widget}
end

--- Replace the layout children
-- This layout only accept one children, all others will be ignored
-- @tparam table children A table composed of valid widgets
function place:set_children(children)
    self:set_widget(children[1])
end

--- Reset this layout. The widget will be removed and the rotation reset.
function place:reset()
    self:set_widget(nil)
end

--- The vertical alignment.
--
-- Possible values are:
--
-- * *top*
-- * *center* (default)
-- * *bottom*
--
-- @property valign
-- @param[opt="center"] string

--- The horizontal alignment.
--
-- Possible values are:
--
-- * *left*
-- * *center* (default)
-- * *right*
--
-- @property halign
-- @param[opt="center"] string

function place:set_valign(value)
    if value ~= "center" and value ~= "top" and value ~= "bottom" then
        return
    end

    self._private.valign = value
    self:emit_signal("widget::layout_changed")
end

function place:set_halign(value)
    if value ~= "center" and value ~= "left" and value ~= "right" then
        return
    end

    self._private.halign = value
    self:emit_signal("widget::layout_changed")
end

--- Fill the vertical space.
--
--@DOC_beforeafter_container_place_fillvertical_EXAMPLE@
--
-- @property fill_vertical
-- @param[opt=false] boolean
-- @see fill_horizontal
-- @see content_fill_horizontal
-- @see content_fill_vertical

--- Fill the horizontal space.
--
--@DOC_beforeafter_container_place_fillhorizontal_EXAMPLE@
--
-- @property fill_horizontal
-- @param[opt=false] boolean
-- @see fill_vertical
-- @see content_fill_horizontal
-- @see content_fill_vertical

--- Grow the vertical space.
--
--@DOC_beforeafter_container_place_growvertical_EXAMPLE@
--
-- When set, this property will record the previous maximum height size of
-- the content widget and use this as the minimum size of the container.  Note
-- that this does nothing when `fill_vertical` or `content_fill_vertical` are
-- set.
--
-- @property grow_vertical
-- @param[opt=false] boolean
-- @see fill_vertical
-- @see content_fill_vertical
-- @see grow_horizontal

--- Grow the horizontal space.
--
--@DOC_beforeafter_container_place_growhorizontal_EXAMPLE@
--
-- When set, this property will record the previous maximum width size of
-- the content widget and use this as the minimum size of the container. It
-- allows, for example, to avoid `wibox.widget.textbox` with rapidly changing
-- number of character, such as network traffic size, to shift the content
-- of the layout every few seconds. Note that this does nothing when
-- `fill_horizontal` or `content_fill_horizontal` are set.
--
-- @property grow_horizontal
-- @param[opt=false] boolean
-- @see fill_horizontal
-- @see content_fill_horizontal
-- @see grow_vertical

--- Stretch the contained widget so it takes all the vertical space.
--
--@DOC_beforeafter_container_place_fillcontentvertical_EXAMPLE@
--
-- @property content_fill_vertical
-- @param[opt=false] boolean
-- @see fill_vertical
-- @see content_fill_horizontal
-- @see fill_horizontal

--- Stretch the contained widget so it takes all the horizontal space.
--
--@DOC_beforeafter_container_place_fillcontenthorizontal_EXAMPLE@
--
-- @property content_fill_horizontal
-- @param[opt=false] boolean
-- @see fill_vertical
-- @see fill_horizontal
-- @see content_fill_vertical

for _, prop in ipairs { "fill_vertical"  , "fill_horizontal", "grow_vertical",
                        "grow_horizontal", "fill_vertical", "fill_horizontal" } do
    place["set_"..prop] = function(self, value)
        self._private[prop] = value
        self:emit_signal("widget::layout_changed")
    end
    place["get_"..prop] = function() return self._private[prop] end
end

--- Reset the `grow_horizontal` and `grow_vertical` size cache.
-- @see grow_horizontal
-- @see grow_vertical
function place:reset_grow_cache()
    self._private.grow_vcache, self._private.grow_hcache = {}, {}
    self:emit_signal("widget::layout_changed")
end

--- Returns a new place container.
-- @param[opt] widget The widget to display.
-- @tparam[opt="center"] string halign The horizontal alignment
-- @tparam[opt="center"] string valign The vertical alignment
-- @treturn table A new place container.
-- @function wibox.container.place
local function new(widget, halign, valign)
    local ret = base.make_widget(nil, nil, {enable_properties = true})

    gtable.crush(ret, place, true)

    ret:reset_grow_cache()
    ret:set_widget(widget)
    ret:set_halign(halign)
    ret:set_valign(valign)

    return ret
end

function place.mt:__call(_, ...)
    return new(_, ...)
end

--@DOC_widget_COMMON@

--@DOC_object_COMMON@

return setmetatable(place, place.mt)

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
