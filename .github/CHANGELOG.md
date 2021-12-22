# Changelog

## 2021-12-22

### To Do Items 
- make tooltip for resource monitors on control panel that displays the text that the bar is drawn with 
- blur 100% at startup
- why application switcher is not displaying 
- move widgets to directories nested in layout according to where they are utilized for purposes of keeping good order in the configuration

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


##  2021-12-20

### Added

- Comments/Styling to the Client Buttons/Control Center/Info Center
- added mod_key to the global variables 
- beginnings of a new readme for this (hopefully) final rewrite
### Changed

- Client buttons scrollwheel to page up & page down buttons
- Moved Readme to the `.github` folder
