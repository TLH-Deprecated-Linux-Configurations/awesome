# Directory Structure 

I have looked over a lot of complex `awesomewm` configurations to finish this one, which means I have a decent sense of how other people structure their configurations. From this, I am convinced no two people mean the same thing when using terms like `module` or `widget`, so I thought it is best to define my meanings here and give the user a sense of what can be found and where. 

On the top level the only files are `rc.lua`, the project's `.gitignore` and a symlink from the `rc.lua` to `rc.lua.test` intended to mitigate an annoying error message when I remember to test changes first using `awmtt`. Everything else is delegated to a subdirectory which bares as the title of the subdirectory the functionality of the files therein. Additionally, the README, CHANGELOG and other files of interest to those inspecting the source code, likely using a platform like Github, in a `.github` subdirectory for purposes of keeping the root level as tidy as possible. 

The subdirectories and a bit about their contents is as follows:

| Subdirectory  | Notes                                                                                                            |
| ------------- | ---------------------------------------------------------------------------------------------------------------- |
| bin           | Where the config's bash scripts are located                                                                      |
| configuration | settings of the built in utilities that comes with the window manager                                            |
| layout        | The screen layout, which is mostly to hold things relating to the bottom bar and its associated widgets          |
| library       | Code I take no credt/responsibility for, ported in as-is                                                         |
| module        | Menus, control screens and other widgets that allow operation of the computer as one would expect of a modern DE |
| signal        | This is a recent adaption from elenapan to normalize the widget signals in the configuration                     |
| theme         | Definition of configuration wide variables, icons, wallpapers and other style related settings                   |


## Nesting of Widgets

I have opted to nest the widgets associated with various components of the configuration within the subdirectory that is housing the widgets' host. For instance, the widgets that appear on the bottom panel can be found at `/layout/bottom-panel/widget/`. 

This can sometimes be somewhat confusing, as in the case of `/layout/bottom-panel/widget/control-center/widget/` when looking at it for the first time, however keeping all of these widgets in locations such as this has proven to make the configuration less daunting than having all the widgets in the top level widget directory. 

### Icons

While not always true, as I am still working this out and at times icons are needed in multiple locations, I have also tried to constrain the icons used in the various widgets to a subdirectory within that widget's subdirectory. Thus if one is looking to find the icons used for the dropbox widget, the location would be `/layout/bottom-panel/widget/control-center/widget/dropbox/icons/`. 

The other location for icons needed in multiple locations, is assigned not by the widget but by one of the theme files or which I have yet to move into such an arrangement is `/theme/icons/`. 

