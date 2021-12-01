if functions -q deactivate-lua
    deactivate-lua
end

function deactivate-lua
    if test -x '/home/tlh/.config/awesome/lua53/bin/lua'
        eval ('/home/tlh/.config/awesome/lua53/bin/lua' '/home/tlh/.config/awesome/lua53/bin/get_deactivated_path.lua' --fish)
    end

    functions -e deactivate-lua
end

set -gx PATH '/home/tlh/.config/awesome/lua53/bin' $PATH
