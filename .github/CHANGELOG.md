# Changelog

## Below is the changelog, arranged by dates. In it you will find most of the items I completed from a given day I worked on this project with the template coming first. The last day's `To Do Items` are copied to the top of the day work is actively being done, this is because if the to-do is finished, it goes into one of the categories below and so that's sufficient tracking for my purposes here. This is a list of done items after all, not a determination of if I can wholly imagine all of the work before doing it.

---

### To Do Items

- turn meter tooltips for cpu, ram, temperature, harddrive into popup windows
  (after first release)
- more expansive annotation commentary (after first release)
- figure out why `meta+space` skips empathy layout the first time (after first
  release?)

- add keygrabber to terminate control center, info center, screen recorder, etc
  with escape at least (and probably expanding to include other keys as it was
  before)
- (meta) new wallpapers/enhance current wallpapers (25% done)
- fix the issue causing network display notification to display twice at
  awesomewm startup.

---

## Template

### Added

### Fixed

### Removed

### Changed

### Notes

---

## 01-13-2021

### Added

### Fixed

### Removed

### Changed

### Notes
- Why not spend some time trying to implement signals in place of present watch commands, at least in the case of the network widget.
  - there is a signal emit, but therefore if I add a connect to the update function, will that alone do?
---

---

## 01-12-2022

### Fixed

- added a kill statement to polkit to make the configuration idemopotent
- network timer to 30 since we don't change network that much, why even eat
  compute space for that

### Changed

- garbage collector settings have been adjusted while watching the performance
  metrics on my laptop to make sure that a huge spike in compute power occured
  - at present the spikes in processing power are truly bedeviling me, I have to
    get the cpu usage down before releas but where the spikes are coming from is
    beyond me

### Notes

- continuing to explore the network app looking to find out why its displaying
  the notification twice
  - so far everything I have turned off either does nothing or makes it still
    display twice
  - not being caused by the network cable being plugged in with the wifi
    connected
  - I also tried to determine if an alternative means of implementing the network widget (or other widgets functioning as daemons, aka running all the time in the background) to help improve compute performance of the configuration, but alas I have not yet determined one other than the labor intensive addition of an onerous amount of signals 

---

# 1-11-2022

### Added

- added `raise = false` to the client focus signal

### Fixed

- have the layoyut popup display on the same screen as its changing layouts for

### Removed

- signals changing the shape of maximized windows (maximized by layout or window
  control action) to rectangles since I will still apply gap to them, this makes
  little sense as it was
- redundant rules
  - artifacts of tags having classes assigned to them, without tag assignments
    meant different sets of rules that all did the same thing, so this was
    condensed.

### Changed

- rules reflect my older set of rules while retaining the functional design I
  have moved to using
- signals include some of the functions from before I found invaluable
- Notification background
- removed requiring `not c.rounded_corners` in the client signals

### Notes

- the level of debugging currently presently underway is way in excess of any
  configuration I have ever used
  - goal is to eliminate all the bugs I am aware of before posting this
    anywhere,
    - luckily I wrote this pretty well, debugging most issues along the way and
      have been at this project in some way or another for a while
  - partially foot dragging about the onerous ISO compilation process
  - partially due to professional facing quality of this project
  - mostly due to the saying I live by "if you are gonna do something, do it
    well"
  - trying to use my old rules entirely failed, as did my first set of attempts
    to integrate old signals into this configuration, however this was fixed by
    using the function based approach of this rewrite with the rules from the
    last version and by experimenting with signals
    - neither respond well to being wrapped in `_M` functions in this config
      - broke client keybindings
      - broke focus
        - this was easily mitigated thanks to the window menu `alt+escape`

---

## 01-10-2021

### Added

- custom icon, needs more work but the idea is coming together.
  - done, that process was miserable as always and way longer than it should
    have been but the new one features elements of the Kali Yantra and my logo
    so its completed.

### Fixed

- empathy layout, now it actually works
- documentation for the layouts
- make `dropdown` not apply the same dimensions and rules to new, unrelated
  windows <-- no longer necessary as the `sticky` attribute is removed and I am
  thinking that was the source of this issue

### Removed

- Showall function from dropdown that apparently wasn't working and I don't
  really need with the scratchpad appearing on the taskbar
-

### Changed

- taskbar close button, switched with a close button generated by the GTK theme
  (duh! can't believe I didn't think of this immeadiately)

---

## 2022-01-08

### Added

- New icon for app menu widget on bottom panel, using the void linux logo for
  now
  - now have a tenative icon placed instead that is subject to change but
    invokes the yantra

### Fixed

- fix button borders in control panel
- fix button borders on the screen recorder

### Removed

- rubato - no offense its an awesome library, just not what I need right now
  with some lingering ineffciencies already taking my CPU cycles higher than I
  would prefer.

### Changed

- colors of the panel and menu to reflect the firefox theme (of personal
  interest since not likely to be reflected in the Electric Tantra Linux's final
  form)

### Notes

- my void-packages template for the development branch of awesomewm works, so
  the efforts to pull this all together are about to begin

---

## 2022-01-08

### Fixed

- make the `dropdown` windows appear on the tasklist

---

## 2022-01-06

### Added

- Additional Documentation for potential contributors

### Fixed

- formating for Volume OSD and Wallpaper
- border of the clickable-container object so it is wider and has less opacity,
  enhancing the button effect

### Removed

### Changed

### Notes

- considering rewriting the README if not from scratch than through substantial
  modifications thereof.

## 2022-01-05

### Fixed

- volume OSD works as expected now

  - break was due to its last signal being badly configured and referring to
    brightness (oopsies)

- both OSDs background color, normalized to the rest of the config (`bg_focus`)

### Notes

- performance: after reboot we are averaging around 8% per core with code
  running but focus on htop. With focus on code, this jumps to about 20% per
  core (makes sense due to it being electron after all).
  - reduces to ~12% once core is running, but the spikes are dramatic, not
    awesomewm related it seems
  - obviously firefox is more resource hungry, especially with large numbers of
    tabs open
    - switching to neovim, drops to about 9%
      - at this level, it appears ram is down to about 900M used (wow)
      - being unnecessary to have on all the time, it may improve performance to
        turn off dropboxd most of the time.
      - makes a strong case for neovim in terms of using it as a daily code
        editor

---

## 2022-01-04

### Added

- additional documentation in several files in `module`

### Fixed

- brightness OSD shape

### Changed

- created a directory for code I don't want to maintain, `library`, to keep any
  external code I am not working on for whatever reason.
- added in rubato as a module in `library`

### Notes

- adding in rubato means I have some extra work ahead of me in terms of getting
  animations added in to various places, but hopefully not sacrificing too much
  performance in so doing. If it costs too much performance, I will scrap it.
- speaking of performance, I need to get that under control. Sure, there is only
  ~15% usage of ram and cpu at any given time, but still I can get this lower as
  it has been lower (down to like 6% cpu and 10% ram even). Not sure how to
  carve this bird, but there has to

---

## 2022-01-03

### Added

- default luarocks loader to rc.lua

#### Final Leg of the Race

- project is looking close, so I spent some time on NeoVim and Luakit, then had
  to go to San Bruno to go to Lowes so we can shower and use the sink again.
- first recorded some thoughts about moving forward
  - final portion of built up to final release of version one, two years in the
    making
  - fixing dropdown is the final obstacle
    - needs to show clients on bottom bar tasklist
    - they already do appear on the window list (alt+esc I always forget this
      binding)
    - that file is an inherited mess, that is powerful but a mess. Need to get
      some order over it and learn how its working.
    - need to prevent new clients opening into the scratch buffer, taking its
      size and being floating, which is extremely frustrating.
  - if possible fixing the backdrop blur darkness would be nice
  - while luarocks loader has been restored, I am not presently using **any**
    luarocks modules due to issues it presented before the latest reworking.

#### Putting It All Together

- need to finish the rest of the custom void iso creation process, including
  making awesome-git a template to build it in a way easily done via script (or
  fast remaster chroot maybe if the need be) **otherwise** prompt return to Arch
  based systems likely via Artix. I don't care about package size, nor debugging
  and devel split from packages (actually somewhat hate that aspect of void) but
  void is all sorts of light and its package manager schools any other I've used
  in terms of speed and power, though since I have all the repos archived from
  when the Electric Tantra Linux was Arch based, moving back to this wouldn't be
  too hard and I know what to do right away
  - this will be solved quickly once I am actually done with this part, I need
    not obsess too hard
- dependency round up of my own code and how to get it in the iso still is
  looming
  - gtk theme, easily included with `includeDir`
  - lightdm theme will require the inclusion of the theme and the configuration
    files
  - icon theme may have to be skipped or programmatically included, due to its
    sheer size. Though having access to the desktop again might mitigate the
    headache here
  - awesome's git version in void, likely using a template or some craftiness
  - include xfce4 desktop environment for the testing phase at least, provide
    more customizations for it with second release.
  -

---

## 2022-01-02

### Added

- Tooltip for CPU added and functional, including the rounding of the displayed
  number to the nearest whole number. Which is pretty slick. Still not the total
  ideal, but will work for now and the initial release. In time this will be
  replaced by the much more slick popup window inspired by streetturtle's
  awesomewm-widgets cpu pop up.
  - Additionally added a tooltip for ram, harddrive and temperature meters

### Fixed

- Made items in control center's bg lighter
- changed the shape of the control center to match everything else.

### Notes

- I did work on the project yesterday but slipped and forgot to record what I
  was doing, so I deleted the entry that was left blank. Oops.
- I was planning on not working on the project today, but personal issues mean I
  might as well get back to work

---

## 2021-12-31

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
  - quake_terminal - dropdown performs this role better

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
