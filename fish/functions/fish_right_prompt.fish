function fish_right_prompt
    if __fish_is_git_repository
        set -l git_branch (git rev-parse --abbrev-ref HEAD ^/dev/null)
        if test -z "$git_branch"
            return
        end
        set -l git_status (git status --porcelain ^/dev/null|cut -c 1-2|sort -u)
        set_color blue
        echo -n 'git['
        echo -n $git_branch
        if test -z "$git_status"
            echo -n '•'
        else
            set_color red
            echo -n '•'
            set_color blue
        end
        echo -n ']'
    end
    set_color normal
    echo ' '(prompt_pwd)
end
