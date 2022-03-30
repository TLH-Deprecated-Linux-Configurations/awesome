---
created: ["{{date}} {{time}}"]
tags: ["#list/"]
---
# {Project Name}
## Project Task List
- [x] 001 fix cursor theme for consistency
  - [001-log](001-log.md)
- [x] 002 Fix the annoying and persistent null value errors presented when turning the volume up or down, coinciding with a significant spike in CPU cycles
- [x] **003** Deal with mute icon setting but not unsetting at unmute 
- [x] **004** convert entire configuration over to the `colors.color` colors (instead of using the color hash wantonly around the config as is now the case)
- [x] **005** work out the issue with the timing of notifications, prefer them to vanish eventually 
  - critical was set to 0 now its set to 8
- [x] **006** move awestore and freeedesktop to modules, with comments and some modifications as necessary (might as well)
- [x] **007** connect the volume center to the overall volume signals
  - no longer applicable due to **012**
- [x] 008 remove library and module calls from remaining files 
  - not always possible and where it caused issues it *should* be noted 
- [x] **009** move clickable container to utils form widgets 
  - surprisingly painless process, hopefully remains such after reboot 
- [x] **010** fix the title text of the centers (volume, bluetooth, notifications ) to be like control center
  
- [x] **011** reconsider the arrangement and placement of the centers, all of them, condense what can be condensed, rearrange, etc.
  - complete rewrite of this section , see [log](011-log.md)
- [ ] **012** sudden onset of lagging-ness (maybe due to some suboptimal signals adaptations, possible need to rewrite the whole volume everything )
  - functional now but lag persists 
- [x] **013** fix bluetooth, it interferes with the use of the bluetooth on the system by reseting to off constantly 
- [x] **014**fix ram bar
  - required immense testing of scripts and considerations abound, stole the functional variant of the signals from Chocolate Bread's psuedo-neumorphic configuration, which was useful for other reasons as well.....  
- [x] **015** fix the disk free read out 
- [x] **016** remove volume center 
- [x] **017** move to awesome-git compiled using luajit
- [ ] **018** move some of the skeudomorphic elements to my true neumorphic form 
- [ ] **019** fix dropbox button on control panel, image rendering off center.