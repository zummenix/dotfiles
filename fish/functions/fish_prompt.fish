function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    set -l line_color 778
    set -l git_branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)

    set_color $line_color
    echo ""
    echo -n "in  "(prompt_pwd)"  "

    if test -n "$git_branch"
        set -l jj_info (jj log --no-graph --limit 1 -r ..@ -T prompt_show_oneline 2> /dev/null)
        if test -n "$jj_info"
            echo -n "jj  $jj_info"
        else
            set -l git_status (git status --porcelain 2> /dev/null)
            echo -n "git "
            if test -z "$git_status"
                set_color green --bold
                echo -n "•"
            else
                set_color red --bold
                echo -n "•"
            end
            set_color reset
            set_color $line_color
            echo -n " [$git_branch]"
        end
    end

    echo ""

    if not test $last_status -eq 0
        set_color red
    else
        set_color 778
    end
    echo -n "λ "
end
