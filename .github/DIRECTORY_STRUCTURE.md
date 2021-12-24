# Directory Structure 

Just as a system of organization that is readily explainable and useful for my purposes maintaining the code base on the level of individual files, so to have I attempted to approach the layout of the configuration's subdirectories in such a way as to achieve the same results. 

On the top level the only files are `rc.lua`, the project's `.gitignore` and a symlink from the `rc.lua` to `rc.lua.test` intended to mitigate an annoying error message when I remember to test changes first using `awmtt`. Everything else is delegated to a subdirectory which bares as the title of the subdirectory the functionality of the files therein. Additionally, the README, CHANGELOG and other files of interest to those inspecting the source code, likely using a platform like Github, in a `.github` subdirectory for purposes of keeping the root level as tidy as possible. 

The subdirectories and a bit about their contents is as follows:

| Subdirectory | Notes |
|--------------|-------|
| bin | Where the config's bash scripts are located |
| configuration | settings of the built in utilities that comes with the window manager |
| layout | The screen layout, which is mostly to hold things relating to the bottom bar and its associated widgets |
| 