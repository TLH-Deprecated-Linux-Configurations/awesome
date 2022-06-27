#!/bin/bash 
sudo pacman -S python-pip python 
pip install hererocks
hererocks luajit -j2.1 -rlatest
source luajit/bin/activate 
luarocks install luacheck
luarocks install luasec
luarocks install luaposix 
luarocks install luafilesystem 
luarocks install ldoc 
luarocks install lpeg


sudo cp -rvf themes/fonts/* /usr/share/fonts
sudo fc-cache -vf
