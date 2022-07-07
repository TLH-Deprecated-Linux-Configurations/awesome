function prompt(action, textbox, prompt, callback)
    if action == 'run' then
        awful.prompt.run(
            {
                prompt = prompt,
                -- prompt       = "<b>Run: </b>",
                textbox = textbox,
                font = beautiful.font .. 'Regular 12',
                done_callback = callback,
                exe_callback = awful.spawn,
                completion_callback = awful.completion.shell,
                history_path = awful.util.get_cache_dir() .. '/history'
            }
        )
    elseif action == 'web_search' then
        awful.prompt.run(
            {
                prompt = prompt,
                -- prompt       = '<b>Web search: </b>',
                textbox = textbox,
                font = beautiful.font .. 'Regular 12',
                history_path = awful.util.get_cache_dir() .. '/history_web',
                done_callback = callback,
                exe_callback = function(input)
                    if not input or #input == 0 then
                        return
                    end
                    awful.spawn.with_shell(
                        'noglob ' .. 'xdg-open https://www.google.com/search?q=' .. "'" .. input .. "'"
                    )
                    naughty.notify(
                        {
                            title = 'Searching the web for',
                            text = input,
                            icon = gears.color.recolor_image(icons.web_browser, beautiful.accent),
                            urgency = 'low'
                        }
                    )
                end
            }
        )
    end
end

return prompt
