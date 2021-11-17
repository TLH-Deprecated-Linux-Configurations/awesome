which deactivate-lua >&/dev/null && deactivate-lua

alias deactivate-lua 'if ( -x '\''/home/tlh/.config/awesome/bin/lua'\'' ) then; setenv PATH `'\''/home/tlh/.config/awesome/bin/lua'\'' '\''/home/tlh/.config/awesome/bin/get_deactivated_path.lua'\''`; rehash; endif; unalias deactivate-lua'

setenv PATH '/home/tlh/.config/awesome/bin':"$PATH"
rehash
