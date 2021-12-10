.DEFAULT_GOAL := help
.PHONY: all allinstall 

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: allinstall 

goautolock:
	cd /root && git clone https://gitlab.com/mrvik/goautolock
	cd /root/goautolock &&	sudo make && sudo make install
	rm -rvf /root/goautolock

awesomefont:
	curl https://awesomewm.org/recipes/awesomewm-font.ttf --output awesomewm-font.ttf
	sudo mv awesomewm-font.ttf /usr/share/fonts
	sudo fc-cache -vf && fc-cache -vf 

hererocks:
	sudo pip3 install hererocks 
	hererocks lua53 -l5.3 -rlatest
	source lua53/bin/activate
	lua -v 
	luarocks install luacheck 
	luarocks install lgi 
	luarocks install luasec 
	luarocks install luafilesystem 
	luarocks install luafilesystem-ffi 
	luarocks install luasocket 
	luarocks install lua-cjson
	luarocks install lua-json


void-dependencies: 
	sudo xbps-install -S --noconfirm brightnessctl iwd iw kitty firefox caja ranger rofi rofi-devel 
	sudo xbps-install -S --noconfirm caja-dropbox  caja-extensions  caja-image-converter  caja-open-terminal  caja-xattr-tags
	sudo xbps-install -S --noconfirm xdotool xsel libluv libluv-devel  lua lua-devel lua-cjson lua-lpeg lua-luadbi lua-lualdap lua-stdlib-debug lua-stdlib-normalize lia-zlib
	sudo xbps-install -S --noconfirm lua53 lua53-MessagePack lua53-cjson lua53-devel lua53-lgi lua53-lpeg lua53-luadbi lua53-luaexpat lua53-luafilesystem lua53-lualdap lua53-luaposix 
	sudo xbps-install -S --noconfirm lua53-luasec lua53-stdlib-debug lua53-stdlib-normalize lua53-vicious lua53-zlib luaposix luasec luasocket 	
	sudo pip install rofimoji 

allinstall: goautolock awesomefont hererocks void-dependencies




