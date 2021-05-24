
local wibox = require("wibox")

local gears = require("gears")

local clickable_container = require("widget.material.clickable-container")
local dpi = require("beautiful").xresources.apply_dpi
local HOME = os.getenv("HOME")
local widget_icon_dir = HOME .. "/.config/awesome/widget/xdg-folders/icons/"
local menubar = require("menubar")

local function icon(item)
	return menubar.utils.lookup_icon(item)
end
local trash_widget =
	wibox.widget {
	{
		id = "trash_icon",
		image = widget_icon_dir .. "user-trash-empty" .. ".svg",
		resize = true,
		widget = wibox.widget.imagebox
	},
	layout = wibox.layout.align.horizontal
}

local trash_menu =
	awful.menu(
	{
		items = {
			{
				"Open trash",
				function()
					awful.spawn.easy_async_with_shell(
						"gio open trash:///",
						function(_)
						end,
						1
					)
				end,
				widget_icon_dir .. "open-folder" .. ".svg"
			},
			{
				"Delete forever",
				{
					{
						"Yes",
						function()
							awful.spawn.easy_async_with_shell(
								"gio trash --empty",
								function(_)
								end,
								1
							)
						end,
						widget_icon_dir .. "yes" .. ".svg"
					},
					{
						"No",
						"",
						widget_icon_dir .. "no" .. ".svg"
					}
				},
				widget_icon_dir .. "user-trash-empty" .. ".svg"
			}
		}
	}
)

local trash_button =
	wibox.widget {
	{
		trash_widget,
		margins = dpi(10),
		widget = wibox.container.margin
	},
	widget = clickable_container
}

-- Tooltip for trash_button
local trash_tooltip =
	awful.tooltip {
	objects = {trash_button},
	mode = "outside",
	align = "right",
	markup = i18n.translate("Trash"),
	margin_leftright = dpi(8),
	margin_topbottom = dpi(8),
	preferred_positions = {"right", "left", "top", "bottom"}
}

-- Mouse event for trash_button
trash_button:buttons(
	gears.table.join(
		awful.button(
			{},
			1,
			nil,
			function()
				awful.spawn({"gio", "open", "trash:///"}, false)
			end
		),
		awful.button(
			{},
			3,
			nil,
			function()
				trash_menu:toggle()
				trash_tooltip.visible = not trash_tooltip.visible
			end
		)
	)
)

-- Update icon on changes
local check_trash_list = function()
	awful.spawn.easy_async_with_shell(
		"gio list trash:/// | wc -l",
		function(stdout)
			if tonumber(stdout) > 0 then
				trash_widget.trash_icon:set_image(icon("user-trash-empty") or (widget_icon_dir .. "user-trash-full" .. ".svg"))

				awful.spawn.easy_async_with_shell(
					"gio list trash:///",
					function(stdout_2)
						trash_tooltip.markup = "<b>" .. i18n.translate("Trash contains:") .. "</b>\n" .. stdout_2:gsub("\n$", "")
					end,
					false
				)
			else
				trash_widget.trash_icon:set_image(icon("user-trash") or (widget_icon_dir .. "user-trash-empty" .. ".svg"))

				trash_tooltip.markup = i18n.translate("Trash empty")
			end
		end,
		false
	)
end

-- Check trash on awesome (re)-start
check_trash_list()

-- Kill the old process of gio monitor trash:///
awful.spawn.easy_async_with_shell(
	"ps x | grep 'gio monitor trash:///' | grep -v grep | awk '{print  $1}' | xargs kill",
	function()
		awful.spawn.with_line_callback(
			"gio monitor trash:///",
			{
				stdout = function(_)
					check_trash_list()
				end
			}
		)
	end,
	false
)

return trash_button
