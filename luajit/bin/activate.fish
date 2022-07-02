if functions -q deactivate-lua
    deactivate-lua
end

function deactivate-lua
    if test -x '/home/tlh/Samsung/Work/awesome/luajit/bin/lua'
        eval ('/home/tlh/Samsung/Work/awesome/luajit/bin/lua' '/home/tlh/Samsung/Work/awesome/luajit/bin/get_deactivated_path.lua' --fish)
    end

    functions -e deactivate-lua
end

set -gx PATH '/home/tlh/Samsung/Work/awesome/luajit/bin' $PATH
