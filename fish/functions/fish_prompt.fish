function fish_prompt --description 'Write out the prompt'
    if not test $status -eq 0
        set_color red
    else
        set_color 778
    end
    echo 'λ '
end
