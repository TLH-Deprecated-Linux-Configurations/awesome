# Luajit

The files within this subdirectory's subdirectories are not managed by me, but the necessary files for the luajit implementation of luarocks and the configuration's luarocks based dependencies that provided various functionality vital to the overall functionality of the configuration but because of package conflicts, are no longer installed system wide but instead provided within this subdirectory.

If on your system, no lua51 v. luajit package conflicts would arise, you can safely delete this subdirectory after installing the below listed depedencies.

| Package       | Functionality Provided                                     |
| ------------- | ---------------------------------------------------------- |
| luaposix      | POSIX bindings easing use of various shell functionalities |
| luasec        | OpenSSL support for luasocket                              |
| luasocket     | provides network support for lua                           |
| luacheck      | error checking for development                             |
| luafilesystem | critical file system access from within lua                |
| argparse      | a dependency of multiple other lua packages                |
| lpeg          | parses expression grammars for lua                         |

## Set Up Process

In case you delete this subdirectory and then do find utility in having these modules locally after all, it is easy enough to re-implement it using the following commands in terminal, assuming you have pip installed.

```bash

pip install hererocks

cd ~/.config/awesome

hererocks luajit -j2.0.5 -rlatest

source luajit/bin/activate

luarocks install luaposix

luarocks install luasec

luarocks install luacheck

luarocks install luafilesystem

luarocks install argparse

luarocks install lpeg

```

Now these dependencies will be located in `~/.config/awesome/luajit/lib/lua/5.1` and `~/.config/awesome/luajit/share/lua/5.1` if you need to link to them directly though thanks to awesome combing the configuration directory, it should just work from the above.
