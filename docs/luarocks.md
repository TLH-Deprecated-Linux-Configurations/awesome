# Luarocks & Hererocks, A Primer

This configuration makes use of a few dependencies that are specific to Lua and while most can be obtained using the AUR (for fellow Arch-derivative users, probably the best reason to use such systems altogether because its not the fake KISS bs they push but don't actually follow) but some require the use of the Lua-specific package manager that is as awfully named as anything else associated with `AwesomeWM`, Luarocks.

Luarocks is easily obtained by your package manager and works as one would expect installing lua packages for system wide use that awesome will find and use if necessary by virtue of the first line of code in `rc.lua` but if you are like me, a more clean and neat approach would be to use a local directory within the awesome configuration itself to house the needed `rocks` and if possible using Luarocks from lua's 5.3 edition since Awesome still is not ported to 5.4 for a host of reasons. To do this, there is a program called Hererocks (I know these names kill me too). To install and use hererocks with the needed `rocks` I have prepared a step by step for you to enter in your terminal assuming you are located in `~/.config/awesome`

```bash
# Depending on your set up omit sudo or not, this is always a pain
sudo pip install hererocks
# Install lua 5.3
hererocks lua53 -l5.3 -rlatest


# Add the installed Lurarocks environment to your PATH (temporarily)
source lua53/bin/activate
# Tedious but won't take it any other way, its lua after all.
luarocks install luafilesystem
luarocks install ldoc
luarocks install luasocket
luarocks install luaposix
luarocks install lua2json
luarocks install lua-cjson
luarocks install mimetypes
luarocks install openssl
luarocks install awestore

# Remove the local luarocks environment from your path
deactivate-lua

```

And now, you have all the potentially useful modules installed locally allowing things like buttery smooth animations and the writing of configuration files dynamically. Awesome searches your `.config/awesome` directory first for most things, hence the `lib` directory including known variants of libraries included with the program's installation as it seems to add to its responsiveness and mitigates a source of trouble when it is most inconvenient as otherwise Linux loves to throw at you.
