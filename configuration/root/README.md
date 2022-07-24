#  Root Configurations 

This subdirectory exists to house configurations that apply to the entire interface, not just client windows. This contrasts with the `../client` subdirectory in that its content applies only to client windows whereas here, no client window is necessary for it to be applied. 

As usual, the content of this directory is ennumerated below with an explanation as to its functionality:

| File/Directory | Functionality                                             |
| -------------- | --------------------------------------------------------- |
| apps           | calls the default apps from `../../settings`              |
| buttons        | global button bindings (apply over wallpaper basically)   |
| init           | calls everything but keys, which are called independently |
| keys           | global keybinds, from media keys to application launching |