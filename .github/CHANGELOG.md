# Changelog


## 2021-12-21

### To Do Items 
- make tooltip for resource monitors on control panel that displays the text that the bar is drawn with 

### Added 
- Definition for `beautiful.transparent`

### Changed 
- Theme name to reflect use of the vice color scheme 
- Added commentary + title to signals, rules, default theme, 
- network timer to 35 since we don't change networks often enough to justify the cpu load

### Fixed 
- Control Center Issue making the sliders not appear
- rules so spotify has a title again and is specifically styled
- fix backdrop, no longer allows items below to be visible. Was an issue with the picom configuration
- Lua autostart fixed

### Removed
- Unnecessary `bin/` scripts (still may remove autorun and others)
- garbage collection contributing to cyclical cpu spikes (unnecessary since every 30 seconds garbage is collected anyway)
- 


##  2021-12-20

### Added

- Comments/Styling to the Client Buttons/Control Center/Info Center
- added mod_key to the global variables 
- beginnings of a new readme for this (hopefully) final rewrite
### Changed

- Client buttons scrollwheel to page up & page down buttons
- Moved Readme to the `.github` folder
