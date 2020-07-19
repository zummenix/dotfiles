function fzfdir --description 'Use fzf to find a file and pushd into its directory'
    set dir (fzf | xargs -I{} dirname "{}")
    if test -n "$dir"
        echo "$dir"
        pushd "$dir"
    end
end

