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
| 