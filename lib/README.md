# Lib
The library directory are files other people have wrote that are generally just as I found them. If I have nedd to do something more substantial than just use them as modules, I will dice them up and use my comment bars and obnoxious ASCII art method of making them readable, but these files I have not needed to or not wanted to and left as they were found deeply grateful to their authors for putting them out there for me to use. 

This directory includes files used by other configurations I am adapting to my purposes, as well as the more standard awesome libraries I make use of and are typically seen around configurations like this one. The long term goal of the majority of these is to phase them out, either eliminating them entirely or adapting the useful bits into my own configuration as the carrying capacity of the configuration reaches a level where such an infusions can again be tolerated. 

## Directory Contents 

| Directory | Contents |
|-----------|----------|
| awesome-freedesktop | Useful for the full and complete internally derived menu available if right clicking the root window |
| datastructure | Mostly useless examples of datastructures in Lua. Some of these are useful and the others are kept as novelty since they do no harm |
| lib-lua | essentially a combo of the lua and `.so` files installed by luarocks normally, kept for emergencies |
| vicious | library with some extra layouts and hardware polling widgets that are actually quite handy | 
| attachdrop | means of using scratchpad to enable dropdown terminal that is easily hidden off screen. Very useful |


## More About the Above

- I don't need to use awesome-freedesktop per se, it offers functionality I could constrain to just using menubar for, but as my grandpa always said, "Two is one and one is none!" May he rest in peace.
- Yes, the datastructure directory is also from luarocks originally, thus could be stuffed in lib-lua, but I am keeping it separated not for any particular reason, other than it seeming neater to me (for now, tomorrow I might just scrap the whole thing who knows?)
- the whole configuration is riddled with code from all over, yet that code is not in the lib directory because I have no reason to substantially modify it. So I don't and leave it in lib until I have a reason to and will do my whole process to it. 


## Why No Submodules 

I use this configuration to build an custom iso, which complicates that process in part, its not like I cannot use submodules at all, my z shell cobnfig depends on that feature to replace a heavy plugin manager when I don't really need much more than the plugins to be where I expect them. Here, I am just trying to insure awesome has as few reasons to show me that awful default gimp disaster wallpaper as possible, on top of my active attempts to introduce features from these files then removing them. 

So submodules don't make sense for this use case, just like I see no reason to reinstall using Ansible playbooks, when Bash scripts and Makefiles work far better and are just as idempotent, reliable and flexible (if you know how to use them, I guess ) and until configuring thousands of systems, I don't think this will change whereas that fad (and whatever totally unnecessary dotfile manager is this months way of virtue signalling on r/unixporn) will fade whereas BASH skills will be useful still. 