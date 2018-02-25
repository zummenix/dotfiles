function fish_prompt --description 'Write out the prompt'
    if not test $status -eq 0
        set_color red
    else
        set_color blue
    end
    echo 'λ '
end
