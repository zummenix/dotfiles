set -Ux EDITOR nvim
set PATH "$HOME/.cargo/bin" $PATH
set PATH "$HOME/projects/dotfiles/scripts" $PATH
set -Ux LC_ALL "en_US.UTF-8"

if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

set fish_color_command white
set fish_color_comment white
set fish_color_cwd white
set fish_color_cwd_root white
set fish_color_end white
set fish_color_error white
set fish_color_history_current white
set fish_color_match white
set fish_color_param white
set fish_color_redirection white
set fish_color_valid_path white
set fish_color_escape white
set fish_color_quote white
set fish_pager_color_description normal

set fish_greeting ""
