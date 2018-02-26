function fish_right_prompt
    if __fish_is_git_repository
        set -l git_branch (git rev-parse --abbrev-ref HEAD ^/dev/null)
        if test -z "$git_branch"
            return
        end
        set -l git_status (git status --porcelain ^/dev/null|cut -c 1-2|sort -u)
        set -l normal_color 778
        set_color $normal_color
        echo -n 'git['
        echo -n $git_branch
        if test -z "$git_status"
            set_color green
            echo -n '•'
            set_color $normal_color
        else
            set_color red
            echo -n '•'
            set_color $normal_color
        end
        echo -n ']'
    end
    set_color normal
    echo ' '(prompt_pwd)
end
