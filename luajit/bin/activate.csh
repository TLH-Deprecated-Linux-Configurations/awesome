which deactivate-lua >&/dev/null && deactivate-lua

alias deactivate-lua 'if ( -x '\''/home/tlh/Samsung/Work/awesome/luajit/bin/lua'\'' ) then; setenv PATH `'\''/home/tlh/Samsung/Work/awesome/luajit/bin/lua'\'' '\''/home/tlh/Samsung/Work/awesome/luajit/bin/get_deactivated_path.lua'\''`; rehash; endif; unalias deactivate-lua'

setenv PATH '/home/tlh/Samsung/Work/awesome/luajit/bin':"$PATH"
rehash
