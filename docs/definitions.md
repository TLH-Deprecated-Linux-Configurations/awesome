# Common Definitions

For a meaningful description of the directories contained within this configuration, a common set of definitions must first be determined so that everyone is on the same page. These definitions are not offered by AwesomeWM on its current documentation site, nor anywhere else I attempted to find them and so I am providing **my definitions** of these terms which is not to say that they are universal definitions by any means but will enable the reader to have a sense of what *I* means by the various terms relevant to this configuration.

## Defining Portions of the Configuration

Each of these have a subdirectory baring the defined term as its title.

**Bin** - These are shell scripts that are necessary for the functionality of the configuration, which I have yet to port into Lua (if possible even) and not a part of some other programs configuration, though launchers for other programs would be in this subdirectory (as they are not configuring the program just launching it).
**Configuration** - User provided arguments that determine the behavior of the default modules of AwesomeWM.

**External** - These are files that are specifically to configure programs other than AwesomeWM, like rofi and picom, and any shell script that is used within that configuration (not those only calling another program). While the user may have their own versions of these configurations, providing files that the configuration will call specifically if/when the program is called creates a more consistent and portable experience.

**Layout** - These are the bars that are central to the functionality of the
window manager, including the bottom bar and the left/right settings bars
(accessible via the bottom bar on icons furthest to their corresponding side).
The directory for each bar may contain files specifying things like panel rules,
the layout of the panel and other topically important aspects of that panel's
configuration. Generally the widgets contained within these bars are found in
files within the `widgets` directory, however subwidgets that call other widgets
in bundles will also be kept in the same directory as the bar that calls them
for purposes of keeping clutter in the `widgets` directory at a minimum.

**Lib** - Lua code I did not write nor modify to any substantial degree and is thus kept here in its (mostly) unaltered form until I find a need to alter it and move it elsewhere. This includes code inherited from TOSTDE which served as this configuration's basis as well as other projects like Bling and even copies of all of AwesomeWM's default modules. Known versions are kept exclusively, meaning no submodules on git will update and break my functionality, as updating them is a manual process thus I can know exactly from where the issue would arise and AwesomeWM, which scans the `.config/awesome` directory will find what it's looking for.

**Module** - These are files which add functionality to the configuration in some form. This includes widgets, but note that while all widgets are modules, not all modules are widgets.

**Theme** - files relating to the appearance of the window manager and a general suite of icons (specific icons should be included in the `widget` subdirectory local to the file calling it).

**Widget** - These are files that add functionality that the user interacts with, thus a type of module. Many of these are the applications one interacts with on the bottom bar, or the various components of the two settings applications (also accessed via icons on the bottom bar).
