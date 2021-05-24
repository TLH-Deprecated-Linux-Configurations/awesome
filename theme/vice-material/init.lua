
local filesystem = require("gears.filesystem")
local mat_colors = require("theme.mat-colors")
local theme_dir = filesystem.get_configuration_dir() .. "/theme"
local dpi = require("beautiful").xresources.apply_dpi
local config = require("theme.config")

local function color(value)
  if value == nil then
    return nil
  end
  return "#" .. value
end

local function loadtheme(standard, override, prefix)
  standard["hue_50"] = color(override[prefix .. "hue_50"]) or standard["hue_50"]
  standard["hue_100"] = color(override[prefix .. "hue_100"]) or standard["hue_100"]
  standard["hue_200"] = color(override[prefix .. "hue_200"]) or standard["hue_200"]
  standard["hue_300"] = color(override[prefix .. "hue_300"]) or standard["hue_300"]
  standard["hue_400"] = color(override[prefix .. "hue_400"]) or standard["hue_400"]
  standard["hue_500"] = color(override[prefix .. "hue_500"]) or standard["hue_500"]
  standard["hue_600"] = color(override[prefix .. "hue_600"]) or standard["hue_600"]
  standard["hue_700"] = color(override[prefix .. "hue_700"]) or standard["hue_700"]
  standard["hue_800"] = color(override[prefix .. "hue_800"]) or standard["hue_800"]
  standard["hue_900"] = color(override[prefix .. "hue_900"]) or standard["hue_900"]
  standard["hue_A100"] = color(override[prefix .. "hue_A100"]) or standard["hue_A100"]
  standard["hue_A200"] = color(override[prefix .. "hue_A200"]) or standard["hue_A200"]
  standard["hue_A400"] = color(override[prefix .. "hue_A400"]) or standard["hue_A400"]
  standard["hue_A700"] = color(override[prefix .. "hue_A700"]) or standard["hue_A700"]
  return standard
end

local theme = {}
theme.icons = theme_dir .. "/icons/"
theme.font = "Hurmit Nerd Font Mono bold 10"
theme.taglist_font = "awesomewm-font 24"
--HERE
theme.titlebars_enabled = true
theme.titlebar_size = dpi(54)
-- Colors Pallets

-- Primary
theme.primary = mat_colors[config["primary"]] or mat_colors.purple
--theme.primary.hue_500 = '#8AB4F8' --#003f6b

-- Accent
theme.accent = mat_colors[config["accent"]] or mat_colors.hue_purple

-- Background
theme.background = mat_colors[config["background"]] or mat_colors.blue_grey

theme.primary = loadtheme(theme.primary, config, "primary_")
theme.accent = loadtheme(theme.accent, config, "accent_")
theme.background = loadtheme(theme.background, config, "background_")

theme.background.hue_800 = theme.background.hue_800 .. (config["background_transparent"] or "66") --99

if config["background_800"] ~= nil then
  theme.background.hue_800 = "#" .. config["background_800"] .. (config["background_transparent"] or "66")
end

theme.background.hue_900 = theme.background.hue_900 .. (config["background_transparent"] or "66") -- 121e25

if config["background_900"] ~= nil then
  theme.background.hue_900 = "#" .. config["background_900"] .. (config["background_transparent"] or "66")
end

local awesome_overrides = function(_)
  --
end
return {
  theme = theme,
  awesome_overrides = awesome_overrides
}
