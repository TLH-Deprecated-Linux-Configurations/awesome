# Changelog

## 2021-12-30

### To Do Items

- make tooltip for resource monitors on control panel that displays the text that the bar is drawn with
  - or make it such that clicking one of the resource monitor buttons shows a window
- more expansive annotation commentary
- make the attachdrop windows appear on the tasklist


### Added 
- blur kernel to picom 

### Fixed 
- rofi stylesheets 
- 
### Removed 
- modules lockscreen & json (again? God those stupid things)
- eliminate `configuration/config`

### Changed
- functions using picom.conf to correct source directory

## 2021-12-29

### Fixed
- rofi fontawesome menu
- volume increase with buttons on keyboard and OSD
  - the issue here came from the command being run including additional parameters (the `-D` flag and `pulse`) that it evidently did not want nor did it need. Their removal meant the keys work and when they are pressed, the OSD displays
- OSD for brightness appear on keypress
  - required copying the `rerun` signal and the `hide_osd` function from the volume osd and changing where the word `volume` was located to `brightness`

### Removed

- icons in svg format still in theme

### Changed

- icons in png to all `#f4f4f7`

## 2021-12-28

### Added

- new module for wallpaper setting that is code from `rc.lua` originally



### Fixed

- why application switcher is not displaying

### Removed

- uneeded modules:
  - lockscreen - bin/blur.sh performs this beautifully
  - dynamic wallpaper - prefer a more stable wallpaper
  - json - not useful to me at present
  - quake_terminal - attachdrop performs this role better

## 2021-12-26

### Added

- Assets folder for screenshots in `.github`
  - screenshot of the control center

### Changed

- color of the bottom panel, made it `bg_focus` to match the GTK theme

### Fixed

- The issue where popups cause the other windows to be hidden re-emerged, picom based, needed to roll back that config

  - next time I feel the impulse to change that config, don't
  - if picom is started with any options through Awesome, it causes problems, so it is run as `picom -b &` and should work

### Removed

- utilities directory, eliminated
- widget directory, all widgets now nested and the template files (clickable container) are in modules

### Notes

- The bars of the slider cannot be styled with a linear gradient, so no skeudomorphism there.

## 2021-12-24

### Changed

- Commented and Titled everything in `layout`
- created bottom-panel subdirectory and changed `bottom-panel.lua` to `layout/bottom-panel/init.lua`
- Moved control panel widgets to `layout/bottom-panel/widget/control-panel/widget`

### Fixed

- blur 100% at startup

### Removed

- library directory, again.

---

## 2021-12-23

### Added

- Worked on documentation, contained in this folder, which will be used later to populate the Github wiki for the configuration.

---

## 2021-12-22

### Added

- Font and BG color for exit screen in default theme, adjusted exit screen accordingly
- Commentary and separation to Exit Screen, Airplane Mode, Menu, Client Init, Keys, Mod Key, Root Init, Config (planning to eliminate),

### Changed

- moved unused library/json.lua to modules instead
- wallpaper to 16.png, a new Kali Yantra Image
- ran optipng through configuration,
  - then oxipng
  - and svgo for the icons
    - should save the three run together in the working directory as a bin script (done)
- adjusted timing on the hardware monitor bars, changed their sizes to be larger

### Fixed

- shape of toggles on the control panel
- control panel slider colors, added contrast and border to the handles
- fixed bars on control panel to be within the color scheme

-

### Removed

- library directory

---

## 2021-12-21

### Added

- Definition for `beautiful.transparent`

### Changed

- Theme name to reflect use of the vice color scheme
- Added commentary + title to signals, rules, default theme, brightness_osd,
- network widget to run its initialization function without needing a timer
- bluetooth watch to be less frequent as its almost never necessary
- all examples of 'user.jpeg' to 'user.png'

### Fixed

- Control Center Issue making the sliders not appear
- rules so spotify has a title again and is specifically styled
- fix backdrop, was not allowing items below to be visible. Was an issue with the picom configuration
- Lua autostart fixed

### Removed

- Unnecessary `bin/` scripts (still may remove autorun and others)
- garbage collection contributing to cyclical cpu spikes (unnecessary since every 30 seconds garbage is collected anyway)
- timer from airplane mode because wtf
- timer form brightness osd, changing the timer into a function without removing functionality of the widget to change the backlight
- Annoying exit screen messages (they really weren't funny at all, just annoying)

---

## 2021-12-20

### Added

- Comments/Styling to the Client Buttons/Control Center/Info Center
- added mod_key to the global variables
- beginnings of a new readme for this (hopefully) final rewrite

### Changed

- Client buttons scrollwheel to page up & page down buttons
- Moved Readme to the `.github` folder
