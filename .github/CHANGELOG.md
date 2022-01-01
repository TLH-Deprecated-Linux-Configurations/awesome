# Changelog

## Below is the changelog, arranged by dates. In it you will find most of the items I completed from a given day I worked on this project with the template coming first. The last day's `To Do Items` are copied to the top of the day work is actively being done, this is because if the to-do is finished, it goes into one of the categories below and so that's sufficient tracking for my purposes here. This is a list of done items after all, not a determination of if I can wholly imagine all of the work before doing it.

## Template

### Added

### Fixed

### Removed

### Changed

### Notes

---

## 2021-12-31

### To Do Items

- make tooltip for resource monitors on control panel that displays the text
  that the bar is drawn with
  - or make it such that clicking one of the resource monitor buttons shows a
    window
- more expansive annotation commentary
- make the attachdrop windows appear on the tasklist
- in the menus, make bg of components different (probably lighter) than those of
  the menu itself.

### Added

- more to do items (of course)
- READMEs to the `configuration` subdirectory and its subdirectories.
-

### Fixed

-lock screen issue (path did not include bin, when wtf when did that happen?)

### Removed

- `bin/autorun.sh`, handling it all internally to the lua itself, hopefully

### Changed

- some aspects of the system start up commands from dotfiles to adjust for the
  lack of the autorun script, had to make sure things were the same to produce
  the more consistent environment I seek.
-

### Notes

- about the tooltip or the popup window on the resource monitor, so far all
  efforts to achieve this have been unsuccessful
  - issues arise in nesting it into the watch command, most clearly and my prior
    examples were leveraging the vicious library I would prefer not to use,
    simply to minimize the amount of external code and due to the modules
    themselves being simple enough if I had to I could easily replicate.
    - I could try to overlay the number into the bar
    - or I could put them on the same line
      - neither requiring additional portions be added to the widgets nor new
        files be tacted on.
- picom is an issue at startup still, implying an issue with the .xprofile or
  .xinit file will test now.
- personal note: still considering moving to luakit. My configuration of it
  would be the only viable one on Github, which means no examples but I am now
  practiced in the ways of Lua well enough I can probably achieve most of what I
  need or stare at its source code long enough to deduce as much from that
  source if need be.

---

## 2021-12-30

### Added

- blur kernel to picom
- `.github/docs` for documentation

### Fixed

- rofi stylesheets

### Removed

- modules lockscreen & json (again? God those stupid things)
- eliminate `configuration/config`

### Changed

- functions using picom.conf to correct source directory

---

## 2021-12-29

### Fixed

- rofi fontawesome menu
- volume increase with buttons on keyboard and OSD
  - the issue here came from the command being run including additional
    parameters (the `-D` flag and `pulse`) that it evidently did not want nor
    did it need. Their removal meant the keys work and when they are pressed,
    the OSD displays
- OSD for brightness appear on keypress
  - required copying the `rerun` signal and the `hide_osd` function from the
    volume osd and changing where the word `volume` was located to `brightness`

### Removed

- icons in svg format still in theme

### Changed

- icons in png to all `#f4f4f7`

---

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

---

## 2021-12-26

### Added

- Assets folder for screenshots in `.github`
  - screenshot of the control center

### Changed

- color of the bottom panel, made it `bg_focus` to match the GTK theme

### Fixed

- The issue where popups cause the other windows to be hidden re-emerged, picom
  based, needed to roll back that config

  - next time I feel the impulse to change that config, don't
  - if picom is started with any options through Awesome, it causes problems, so
    it is run as `picom -b &` and should work

### Removed

- utilities directory, eliminated
- widget directory, all widgets now nested and the template files (clickable
  container) are in modules

### Notes

- The bars of the slider cannot be styled with a linear gradient, so no
  skeudomorphism there.

## 2021-12-24

### Changed

- Commented and Titled everything in `layout`
- created bottom-panel subdirectory and changed `bottom-panel.lua` to
  `layout/bottom-panel/init.lua`
- Moved control panel widgets to
  `layout/bottom-panel/widget/control-panel/widget`

### Fixed

- blur 100% at startup

### Removed

- library directory, again.

---

## 2021-12-23

### Added

- Worked on documentation, contained in this folder, which will be used later to
  populate the Github wiki for the configuration.

---

## 2021-12-22

### Added

- Font and BG color for exit screen in default theme, adjusted exit screen
  accordingly
- Commentary and separation to Exit Screen, Airplane Mode, Menu, Client Init,
  Keys, Mod Key, Root Init, Config (planning to eliminate),

### Changed

- moved unused library/json.lua to modules instead
- wallpaper to 16.png, a new Kali Yantra Image
- ran optipng through configuration,
  - then oxipng
  - and svgo for the icons
    - should save the three run together in the working directory as a bin
      script (done)
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
- fix backdrop, was not allowing items below to be visible. Was an issue with
  the picom configuration
- Lua autostart fixed

### Removed

- Unnecessary `bin/` scripts (still may remove autorun and others)
- garbage collection contributing to cyclical cpu spikes (unnecessary since
  every 30 seconds garbage is collected anyway)
- timer from airplane mode because wtf
- timer form brightness osd, changing the timer into a function without removing
  functionality of the widget to change the backlight
- Annoying exit screen messages (they really weren't funny at all, just
  annoying)

---

## 2021-12-20

### Added

- Comments/Styling to the Client Buttons/Control Center/Info Center
- added mod_key to the global variables
- beginnings of a new readme for this (hopefully) final rewrite

### Changed

- Client buttons scrollwheel to page up & page down buttons
- Moved Readme to the `.github` folder
