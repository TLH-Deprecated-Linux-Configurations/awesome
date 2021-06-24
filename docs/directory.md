# Directories 

Below are the many subdirectories in the repository with a description as to what they should have as their content, but no guarentees as there is a lot of gradation between the imposed taxonomy. 


| Subdirectory      |  Contents     |
|------------------------|-------------------------|
|Configuration       | keybindings, client rules, tags, startup applications, credentials storage, and tag-list      |
| Layout      |  Panels, the main panel which appears when the mouse is on the last row of pixels on the screen and the two launched from buttons on it (or mod4+g/h)  |
| Module     |  Add functionality to the window manager, hopefully can be disabled without breaking the configuration but I use them all or they wouldn't be included     |
| Theme |   Where things relating to the appearance of the window manager as a whole are located   |
| Widgets |   Configuration units that function as self-contained functional portions of the configuration generally that appear on the UI in some form    |
| External | Program configurations for the limited use cases this configuration has for third party applications to provide functionality or convenience |
| Bin | These are shell scripts that are called by functions/keybindings/widgets for one reason or another |
| Lib | Code written by other developers without substantial modifications and thus kept apart from the core configuration. |

## 'Some Splainin to Do'

As I stated, the taxonomy is imposed on the configuration which by default would have just been one monolithic file, but for my own sanity I have broken into 400+ files (I know, it is truly obnoxious and I am always working to eliminate unneeded code as I can) and tried to usefully organize, which I will explain some aspects of below so you have a sense of what, if anything, I was thinking in my organization process and might be better able to track things down as needed. 

### Module vs. Widgets
This is the most tricky for me to accurately define, as widgets themselves aren't even defined by Awesome's documentation so who knows what the core developers were thinking on the subject, but within the context of this configuration by `modules` what is meant are those aspects of the configuration that are **independent, hopefully modular, aspects** of the configuration that the **user doesn't interact with directly** or **relates to some core aspect of the functionality of the window manager**(titlebar) whereas the `widgets` are either **something the user can interact with** (panel items) or those **things not essential to the basic functionality of the window manager**. I may separate out essential and non-essential items from these, into what directories I know not but its being considered as a means of reducing overall ambiguity. 

One useful rule of thumb is that all `widgets` will require `wibox.widget` within some aspect of themselves whereas this is not a necessary condition of the components found in `modules` (however, requiring `wibox.widget` is not sufficient to conclude that something is a widget as some modules will also have this requirement. The joys of logic). 

To give you a better sense of what is what, that one might better gleam by example than by my yodeling on the subject, the below table will list items found in the configuration and if they are a widget or a module

| Component | Module/Widget | Notes |
|-----------|---------------|-------|
| auto-start | module | not interactive |
| action-center | widget | interactive as part of the right bar | 
| clickable-container | widget | clicking is interacting, right? | 
| application-switcher | module | core functionality |
| titlebar | module | core functionality  |

As I wrote this, I first attempted to find an English definition of what is a widget in AwesomeWM but I found no such text, making me reflect on the differences between the code and rationalize a need to refactor these two directories as there are a lot more fringe cases than I would prefer. I have already moved the right and left bars to layout for purposes of making the arrangement more logically categorized but will spend some time eliminating fringe cases like if titlebar should be a module (or alternatively if taglist and tasklist should be modules with it)

### External vs. Bin
`external` is for configuration files that relate to specific programs as well as a glitched lockscreen shell script I did not write (but due to substantial modifications may actually move as otherwise it wouldn't even work). The reason the glitched lockscreen is not in bin is because it is technically a configuration file specific to i3lock. Whereas the `bin` directory is for general shell scripts I am maintaining in order to add some essential functionality easily into Awesome, and in each case may move to using Lua to provide this functionality in time just haven't gotten around to fighting with Lua over it yet considering what a pain that can be. 

### Themes and Widgets/*/icons

While the `theme` directory has a subdirectory that specifically contains icons, I have also appreciated and continued Meyers practice of including icons within the widgets themselves as this lends itself best to making them modular, as youhave the needed icons right there and need only adapt their location (which usually won't even break the configuration if there are not dozens of these errors, usually this configuration throws two or so such errors if run with awmtt which is a program that allows you to test your configuration with Xephyr). 

In the future I may include a copy of each icons from the widgets in the icons the theme provides as well, as my grandfather always said, "Two is one and one is none" which is a nugget of truth I try to live by and useful in this context but as of yet this project is still ongoing. 

### Lib
In `lib` there are a lot of files, haphazardly organized, that are entirely the work of Meyers that I have not modified and result from the process of me teasing out of **TDE** a single directory to house the configurations as Meyers uses several different system level directories and programs to achieve the same result (with alot more features I don't find useful but others may enjoy). Within lib are also all of the other dependencies I have required, including copies of the basic libraries used by awesome. They are included as copies of the code itself, as submodules proved a fickle and prone to issues with breaking while in the present method I am able to achieve a more stable experience by including code that is a known version with bugs I need not worry about multiplying at random times. 

In time, I expect portions of the **TDE** files to end up becoming a regular part of the configuration as modifying much of them is necessary still and when I do this, I tend to move them into the main configuration as I substantially modify them in the process by adding comment bars, titles and changing portions of the code to make it fit better into the assumptions of this configuration which differ widely from Meyers. 