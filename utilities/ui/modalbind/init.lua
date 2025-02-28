--  _______           __         __
-- |   |   |.-----.--|  |.---.-.|  |
-- |       ||  _  |  _  ||  _  ||  |
-- |__|_|__||_____|_____||___._||__|

--  ______ __           __
-- |   __ \__|.-----.--|  |
-- |   __ <  ||     |  _  |
-- |______/__||__|__|_____|

-- awesome-modalbind - modal keybindings for awesomewm
-- https://github.com/crater2150/awesome-modalbind
-- ------------------------------------------------- --
local awesome,
	client,
	mouse,
	screen,
	tag = awesome, client, mouse, screen, tag
local dpi = beautiful.xresources.apply_dpi
local modalbind = {}
local nesting = 0
local verbose = true

--local functions

local defaults = {}

defaults.opacity = 0.85
defaults.height = 42
defaults.x_offset = 5
defaults.y_offset = 5
defaults.show_options = true
defaults.show_default_options = true
defaults.position = 'top_left'
defaults.honor_padding = true
defaults.honor_workarea = true
defaults.bg = beautiful.bg_normal
-- Clone the defaults for the used settings
local settings = {}
for key, value in pairs(defaults) do
	settings[key] = value
end

local prev_layout = nil

local aliases = {}
aliases[' '] = 'space'

local function layout_swap(new)
	if type(new) == 'number' and new >= 0 and new <= 3 then
		prev_layout = awesome.xkb_get_layout_group()
		awesome.xkb_set_layout_group(new)
	end
end

local function layout_return()
	if prev_layout ~= nil then
		awesome.xkb_set_layout_group(prev_layout)
		prev_layout = nil
	end
end

function modalbind.init()
	local modewibox =
		wibox(
		{
			ontop = true,
			visible = false,
			x = 0,
			y = 0,
			-- width = dpi(550),
			height = dpi(650),
			opacity = defaults.opacity,
			bg = beautiful.bg_normal,
			fg = beautiful.fg_normal,
			shape = gears.shape.rounded_rect,
			margins = 5,
			type = 'dock'
		}
	)

	modewibox:setup(
		{
			{
				{
					{
						{
							id = 'text',
							align = 'left',
							font = 'Operator SSm  Normal 16',
							widget = wibox.widget.textbox
						},
						id = 'margin',
						margins = dpi(9),
						color = '#1c1c1c88',
						layout = wibox.container.margin
					},
					widget = wibox.container.background,
					bg = 'linear:0,0:0,21:0,#22222288:1,#30303088'
				},
				margins = dpi(9),
				color = '#1c1c1c88',
				layout = wibox.container.margin
			},
			widget = wibox.container.background,
			bg = 'linear:0,0:0,21:0,#22222288:1,#30303088'
		}
	)

	awful.screen.connect_for_each_screen(
		function(s)
			s.modewibox = modewibox
		end
	)
end

local function show_box(s, map, name)
	local mbox = s.modewibox
	local mar = mbox:get_children_by_id('margin')[1]
	local txt = mbox:get_children_by_id('text')[1]
	mbox.screen = s

	local label = '<big><b>' .. name .. '</b></big>'
	if settings.show_options then
		for _, mapping in ipairs(map) do
			if mapping[1] == 'separator' then
				label = label .. '\n\n<big>' .. mapping[2] .. '</big>'
			elseif mapping[1] ~= 'onClose' then
				label =
					label ..
					'\n<b>' ..
						gears.string.xml_escape(mapping[1]) .. '</b>\t' .. (mapping[3] or '???')
			end
		end
	end
	txt:set_markup(label)

	local x,
		y = txt:get_preferred_size(s)
	mbox.width = dpi(250) + x + mar.left + mar.right
	mbox.height = math.max(settings.height, y + mar.top + mar.bottom)
	awful.placement.align(
		mbox,
		{
			position = settings.position,
			honor_padding = settings.honor_padding,
			honor_workarea = settings.honor_workarea,
			offset = {
				x = settings.x_offset,
				y = settings.y_offset
			}
		}
	)
	mbox.opacity = settings.opacity

	mbox.visible = true
end

local function hide_box()
	screen[1].modewibox.visible = false
end

local function mapping_for(keymap, key, use_lower)
	local k = key
	if use_lower then
		k = k:lower()
	end
	for _, mapping in ipairs(keymap) do
		local m = mapping[1]
		if use_lower then
			m = m:lower()
		end
		if m == k or (aliases[k] and m == k) then
			return mapping
		end
	end
	return nil
end

local function call_key_if_present(keymap, key, args, use_lower)
	local callback = mapping_for(keymap, key, use_lower)
	if callback then
		callback[2](args)
	end
end

function close_box(keymap, args)
	call_key_if_present(keymap, 'onClose', args)
	keygrabber.stop()
	nesting = 0
	hide_box()
	layout_return()
end

function modalbind.close_box()
	return close_box
end

modalbind.default_keys = {
	{'Escape', modalbind.close_box, 'Exit Modal'}
}

local function merge_default_keys(keymap)
	local result = {}
	for j, k in ipairs(modalbind.default_keys) do
		local no_add = false
		for i, m in ipairs(keymap) do
			if k[1] ~= 'separator' and m[1] == k[1] then
				no_add = true
				break
			end
		end
		if not no_add then
			table.insert(result, k)
		end
	end
	for _, m in ipairs(keymap) do
		table.insert(result, m)
	end
	return result
end

function modalbind.grab(options)
	local keymap = merge_default_keys(options.keymap or {})
	local name = options.name
	local stay_in_mode = options.stay_in_mode or false
	local args = options.args
	local layout = options.layout
	local use_lower = options.case_insensitive or false

	layout_swap(layout)
	if name then
		if settings.show_default_options then
			show_box(mouse.screen, keymap, name)
		else
			show_box(mouse.screen, options.keymap, name)
		end
		nesting = nesting + 1
	end
	call_key_if_present(keymap, 'onOpen', args, use_lower)

	keygrabber.run(
		function(mod, key, event)
			if event == 'release' then
				return true
			end

			mapping = mapping_for(keymap, key, use_lower)
			if mapping then
				if (mapping[2] == close_box or mapping[2] == modalbind.close_box) then
					close_box(keymap, args)
					return true
				end

				keygrabber.stop()
				mapping[2](args)

				-- mapping "stay_in_mode" takes precedence over mode-wide setting
				if mapping['stay_in_mode'] ~= nil then
					stay_in_mode = mapping['stay_in_mode']
				end

				if stay_in_mode then
					modalbind.grab {
						keymap = keymap,
						name = name,
						stay_in_mode = true,
						args = args,
						use_lower = use_lower
					}
				else
					nesting = nesting - 1
					if nesting < 1 then
						hide_box()
					end
					layout_return()
					return true
				end
			else
				if verbose then
					print('Unmapped key: "' .. key .. '"')
				end
			end

			return true
		end
	)
end

function modalbind.grabf(options)
	return function()
		modalbind.grab(options)
	end
end

--- Returns the wibox displaying the bound keys
function modalbind.modebox()
	return mouse.screen.modewibox
end

--- Change the opacity of the modebox.
-- @param amount opacity between 0.0 and 1.0, or nil to use default
function modalbind.set_opacity(amount)
	settings.opacity = amount or defaults.opacity
end

--- Change min height of the modebox.
-- @param amount height in pixels, or nil to use default
function modalbind.set_minheight(amount)
	settings.height = amount or defaults.height
end

--- Change horizontal offset of the modebox.
-- set location offset for the box. The box is shifted to the right
-- @param amount horizontal shift in pixels, or nil to use default
function modalbind.set_x_offset(amount)
	settings.x_offset = amount or defaults.x_offset
end

--- Change vertical offset of the modebox.
-- set location offset for the box. The box is shifted downwards.
-- @param amount vertical shift in pixels, or nil to use default
function modalbind.set_y_offset(amount)
	settings.y_offset = amount or defaults.y_offset
end

--- Set the position, where the modebox will be displayed
-- Allowed options are listed on page
-- https://awesomewm.org/apidoc/libraries/awful.placement.html#align
-- @param position of the widget
function modalbind.set_location(position)
	settings.position = position
end

---  enable displaying bindings for current mode
function modalbind.show_options()
	settings.show_options = true
end
--
---  disable displaying bindings for current mode
function modalbind.hide_options()
	settings.show_options = false
end
--
---  enable displaying bindings for current mode
function modalbind.show_default_options()
	settings.show_default_options = true
end
--
---  disable displaying bindings for current mode
function modalbind.hide_default_options()
	settings.show_default_options = false
end

---  set key aliases table
function modalbind.set_aliases(t)
	aliases = t
end

return modalbind
