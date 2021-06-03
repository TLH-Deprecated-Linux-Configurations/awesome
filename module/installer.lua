
local installed = require("lib.hardware-check").has_package_installed
local menubar = require("menubar")
local icons = require("theme.icons")
local desktop_icon = require("widget.desktop_icon")
local apps = require("configuration.apps")

local show_installer = installed("installer")

local icon = menubar.utils.lookup_icon("calamares") or icons.logo
local tutorial_icon = menubar.utils.lookup_icon("preferences-desktop-theme") or icons.logo
local settings_icon = menubar.utils.lookup_icon("preferences-desktop-theme") or icons.logo

if show_installer then
    desktop_icon.create_icon(
        icon,
        i18n.translate("Installer"),
        0,
        function()
            print("Starting installer")
            awful.spawn("/arch_install/setup.sh")
        end
    )
    desktop_icon.create_icon(
        tutorial_icon,
        i18n.translate("Tutorial"),
        1,
        function()
            print("Starting Tutorial")
            awful.spawn(apps.default.terminal .. " -e tos tutorial")
        end
    )
    desktop_icon.create_icon(
        settings_icon,
        i18n.translate("Settings"),
        1,
        function()
            print("Opening settings application")
            root.elements.settings.enable_view_by_index(-1, mouse.screen)
        end
    )
end
