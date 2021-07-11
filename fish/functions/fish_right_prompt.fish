function fish_right_prompt
    set -l git_branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if test -n "$git_branch"
        set -l git_status (git status --porcelain 2> /dev/null)
        set -l git_line_color 778
        set_color $git_line_color
        echo -n 'git['
        echo -n $git_branch
        if test -z "$git_status"
            set_color green --bold
            echo -n '•'
            set_color reset
            set_color $git_line_color
        else
            set_color red --bold
            echo -n '•'
            set_color reset
            set_color $git_line_color
        end
        echo -n ']'
    end
    set_color 889
    echo -n ' '(prompt_pwd)
end
