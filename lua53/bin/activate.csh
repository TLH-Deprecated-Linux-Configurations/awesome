which deactivate-lua >&/dev/null && deactivate-lua

alias deactivate-lua 'if ( -x '\''/home/tlh/.config/awesome/lua53/bin/lua'\'' ) then; setenv PATH `'\''/home/tlh/.config/awesome/lua53/bin/lua'\'' '\''/home/tlh/.config/awesome/lua53/bin/get_deactivated_path.lua'\''`; rehash; endif; unalias deactivate-lua'

setenv PATH '/home/tlh/.config/awesome/lua53/bin':"$PATH"
rehash
