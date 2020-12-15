function v --description 'Shortcut for neovim with background jobs support'
    jobs | grep -ie "nvim" | head -n1 | cut -f 2 - | fg || nvim $argv
end
