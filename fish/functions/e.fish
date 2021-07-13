function e --description 'Shortcut to open an editor (neovim) with background jobs support'
    jobs | grep -ie "nvim" | head -n1 | cut -f 2 - | fg || nvim $argv
end
