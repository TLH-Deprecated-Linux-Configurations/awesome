---
created: ["{{date}} {{time}}"]
tags: ["#list/"]
---
# {Project Name}
## Project Task List
- [x] 001 fix cursor theme for consistency
  - [001-log](001-log.md)
- [x] 002 Fix the annoying and persistent null value errors presented when turning the volume up or down, coinciding with a significant spike in CPU cycles
- [ ] 003 Deal with mute icon setting but not unsetting at unmute 
- [x] 004 convert entire configuration over to the `colors.color` colors (instead of using the color hash wantonly around the config as is now the case)
- [x] 005 work out the issue with the timing of notifications, prefer them to vanish eventually 
  - critical was set to 0 now its set to 8
- [x] 006 move awestore and freeedesktop to modules, with comments and some modifications as necessary (might as well)
- [ ] 007 connect the volume center to the overall volume signals
- [x] 008 remove library and module calls from remaining files 
- [ ] 009 move clickable container to utils form widgets 
- [ ] 010 fix the title text of the centers (volume, bluetooth, notifications ) to be like control center
- [ ] 011 sudden onset of lagging-ness (maybe due to some suboptimal signals adaptations, possible need to rewrite the whole volume everything )