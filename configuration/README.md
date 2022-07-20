# configuration

This directory contains files that configure various builtin functionality of
`awesomewm` such as client windows, the keybindings used across the
configuration (both root and client) as well as houses the configuration files
for the external GUI menu program `rofi` which I am working on eliminating the
need for but as of yet haven't gotten my own menu to the point I would prefer it
so `rofi` is retained for the time being.

| Directory | Files in It                                                                         |
| --------- | ----------------------------------------------------------------------------------- |
| Client    | files configuring client windows                                                    |
| Keys      | the keybindings globally, including mod keys in a separate file                     |
| rofi      | rofi's .rasi files for the several uses I have for it in this config                |
| root      | setting for the root window, like button bindings for mouse clicks on blank screens |

## Client

| File    | Function                                                          |
| ------- | ----------------------------------------------------------------- |
| buttons | Mouse bindings for mouse button presses over client windows       |
| init    | Initializes the files in this subdirectory in the necessary order |
| keys    |                                                                   |
| rules   | rules operative on specific client windows                        |
| signals | signals that emit or connect when clients appear or disappear     |

## Keys

| File   | Function                                                                          |
| ------ | --------------------------------------------------------------------------------- |
| global | keybindings that are applicable in contexts other than controlling client windows |
| init   | Initializes the files in this subdirectory in the necessary order                 |
| mod    | Defining the modifier keys, such as the Mod4/Win/Voldemort key                    |

## Rofi

These files have the extension rasi typically (or are lists of unicode
characters for the fontawesome_menu), which if a flavor of CSS used by rofi to
style windows. More expansive and interesting configurations for rofi exist.
This one was only intended to style the application menu I am trying to be rid
of soon. Nonetheless, my familiarity with the window

| File              | Function                                                                                    |
| ----------------- | ------------------------------------------------------------------------------------------- |
| fontawesome_menu/ | contains files necessary for the font awesome icon selecting popup (very handy for web dev) |
| centered.rasi     | Styling used in the Application Menu available with a single press of Mod4                  |
| colors.rasi       | provides the vice theme to the rofi menus use                                               |

## Root

| File    | Function                                                                                                 |
| ------- | -------------------------------------------------------------------------------------------------------- |
| apps    | calls the default applications from settings and assigns them as `default`, probably could be eliminated |
| buttons | Sensible mouse bindings for the root window _ie_ **no scrollwheel assignments**                          |
| init    | Initializes the files in this subdirectory in the necessary order                                        |
