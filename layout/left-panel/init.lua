--  _____          ___ __        ______                     __      ______         __   __
-- |     |_.-----.'  _|  |_     |   __ \.---.-.-----.-----.|  |    |   __ \.--.--.|  |_|  |_.-----.-----.
-- |       |  -__|   _|   _|    |    __/|  _  |     |  -__||  |    |   __ <|  |  ||   _|   _|  _  |     |
-- |_______|_____|__| |____|    |___|   |___._|__|__|_____||__|    |______/|_____||____|____|_____|__|__|

-- ########################################################################
-- ########################################################################
-- ########################################################################

local PATH_TO_ICONS = HOME .. "/.config/awesome/layout/left-panel/icons/"

-- Load panel rules, it will create panel for each screen
require("layout.left-panel.panel-rules")
local left_panel = require("layout.left-panel.left-panel")
-- ########################################################################
-- ########################################################################
-- ########################################################################
local widget =
	wibox.widget(
	{
		{
			id = "icon",
			widget = wibox.widget.imagebox,
			resize = true
		},
		layout = wibox.layout.align.horizontal
	}
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local home_button = clickable_container(wibox.container.margin(widget, dpi(7), dpi(7), dpi(7), dpi(7)))

home_button:buttons(
	gears.table.join(
		awful.button(
			{},
			1,
			nil,
			function()
				_G.screen.primary.left_panel:toggle()
			end
		)
	)
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
_G.screen.primary.left_panel:connect_signal(
	"opened",
	function()
		widget.icon:set_image(icons.sidebar_open)
		_G.menuopened = true
	end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
_G.screen.primary.left_panel:connect_signal(
	"closed",
	function()
		widget.icon:set_image(icons.sidebar)
		_G.menuopened = false
	end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
widget.icon:set_image(icons.sidebar)

return home_button
