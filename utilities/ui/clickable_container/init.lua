--  ______ __ __        __           __     __
-- |      |  |__|.----.|  |--.---.-.|  |--.|  |.-----.
-- |   ---|  |  ||  __||    <|  _  ||  _  ||  ||  -__|
-- |______|__|__||____||__|__|___._||_____||__||_____|
--  ______               __          __
-- |      |.-----.-----.|  |_.---.-.|__|.-----.-----.----.
-- |   ---||  _  |     ||   _|  _  ||  ||     |  -__|   _|
-- |______||_____|__|__||____|___._||__||__|__|_____|__|
-- ------------------------------------------------- --
local wibox = require('wibox')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi

local create_click_events = function(widget)
	local container =
		wibox.widget {
		widget,
		widget = wibox.container.background,
		shape = beautiful.client_shape_rounded,
		bg = beautiful.bg_button,
		border_width = dpi(2),
		border_color = colors.alpha(colors.black, '99')
	}

	-- ------------------ Placeholders ----------------- --
	local old_cursor,
		old_wibox

	-- ----------- Mouse hovers on the widget ---------- --
	container:connect_signal(
		'mouse::enter',
		function()
			container.bg = beautiful.accent
			-- container.shape = beautiful.client_shape_rounded_xl
			-- container.border_width = dpi(2)
			local w = mouse.current_wibox
			if w then
				old_cursor,
					old_wibox = w.cursor, w
				w.cursor = 'hand1'
			end
		end
	)

	-- --------------- Mouse exits widget -------------- --
	container:connect_signal(
		'mouse::leave',
		function()
			container.bg = beautiful.bg_button
			container.border_width = dpi(2)
			container.shape = beautiful.client_shape_rounded
			container.border_color = colors.alpha(colors.black, '99')

			if old_wibox then
				old_wibox.cursor = old_cursor
				old_wibox = nil
			end
		end
	)

	-- ------------ Mouse pressed the widget ----------- --
	container:connect_signal(
		'button::press',
		function()
			container.bg = beautiful.accent
			-- container.shape = beautiful.client_shape_rounded_xl
			-- container.border_width = dpi(2)
		end
	)

	-- ----------- Mouse releases the widget ----------- --
	container:connect_signal(
		'button::release',
		function()
			container.bg = beautiful.bg_button
			container.shape = beautiful.client_shape_rounded
			container.border_color = colors.alpha(colors.black, '99')
			container.border_width = dpi(2)
		end
	)

	return container
end

return create_click_events
