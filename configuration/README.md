# Configuration

This is the subdirectory where you will find a plethora of settings that are easily modifiable that set the built in functionality of the window manager and arrange that side of the internals according to my taste and prepare them to handle the extensions and more extensive modifications found elsewhere.

Of note, my collection of partially modified, custom layouts in this subduirectory at `tags/layouts` and my solution to the annoyance of having to remember to call obscene numbers of libraries at the head of each file: a file that calls the whole gang as global variables easily used elsewhere without need to call them in the other files.

### Contents

| File | Notes |
|------x-------|
| apps | sets the default applications used in the configuration |
| garbage | garbage collection, to keep the resource load nice and low |
| global_var | calls libraries for the entire configuration |
| tags/init | names the tags,sets the default layouts and applies them to tags |
|tags/layouts/center-master| creates a centered client as master with others tucked under it|
| tags/layouts/empathy| creates two top windows and then three on a second row |
|tags/layouts/stack |my primary layout, like mstab from bling minus the tab bar so its more functional and less in the way |
| tags/layouts/thrizen | the opposite of empathy essentially, collectively more useful than the default tiling paradigms as far as what's realistic|
|keys/global | Global keybindings, not client dependent |
| keys/mod | sets the voldemort key(windows key) as mod key |
| keys/init | calls the other key files obviously |
| client/buttons | mouse buttons relating to the client window |
| client/init | calls the other client files in one place |
| client/keys |key binds relating to client windows |
| client/remember-geometry | when cycling between floating and tiled, it restores the size of the client to what it was last time it was floating |
|client/rules| rules for specific clients, used to set up global rules mostly (dynamic tagging is not my style) |
|client/screenposition |
