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
	 luarocks install luasocket 

void-dependencies: 
	sudo xbps-install -S brightnessctl iwd iw kitty firefox caja ranger rofi rofi-devel 
	sudo xbps-install -S  caja-dropbox  caja-extensions  caja-image-converter  caja-open-terminal  caja-xattr-tags
	sudo xbps-install -S  xdotool xsel 
	sudo pip install rofimoji

allinstall: goautolock awesomefont hererocks void-dependencies




