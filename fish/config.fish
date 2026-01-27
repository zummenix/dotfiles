set -Ux EDITOR hx
set -Ux HELIX_RUNTIME "$HOME/projects/helix/runtime"
set PATH "$HOME/.cargo/bin" $PATH
set PATH "$HOME/projects/dotfiles/scripts" $PATH
set -Ux fish_user_paths /opt/homebrew/bin/ $fish_user_paths
set -Ux LC_ALL "en_US.UTF-8"

set --global fish_color_autosuggestion 555 brblack
set --global fish_color_cancel -r
set --global fish_color_host normal
set --global fish_color_host_remote yellow
set --global fish_color_normal normal
set --global fish_color_operator 00a6b2
set --global fish_color_search_match white --background=brblack
set --global fish_color_selection white --bold --background=brblack
set --global fish_color_status red
set --global fish_color_user brgreen
set --global fish_pager_color_completion
set --global fish_pager_color_prefix normal --bold --underline
set --global fish_pager_color_progress brwhite --background=cyan
set --global fish_pager_color_selected_background -r

set fish_greeting ""

status --is-interactive; and rbenv init - fish | source
