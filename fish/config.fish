set -Ux EDITOR nvim
set PATH "$HOME/.cargo/bin" $PATH

if status --is-interactive
    eval sh $HOME/.config/base16-shell/scripts/base16-ocean.sh
end
