fhelm(){
    ns=${1:-"omm"}
    helm tiller run $ns -- helm list --all| sed -e '1,8d' | sed -e '$ d' | \
        fzf \
            --header="CTRL-Y/E/F/B to scroll preview, CTRL-S to copy release-name, CTRL-X to delete and purge, CTRL-C to exit" \
            --preview="echo {} | sed 's/ .*//' | sed 's/[0-9]*//g' | xargs -I% helm tiller run $ns -- helm status  %" \
            --bind "j:down,k:up,ctrl-e:preview-down,ctrl-y:preview-up,ctrl-f:preview-page-down,ctrl-b:preview-page-up,q:abort" \
            --bind "ctrl-s:execute(echo {} | sed 's/ .*//' | sed 's/[0-9]*//g' | pbcopy)+accept" \
            --bind "ctrl-x:execute(echo {} | sed 's/ .*//' | sed 's/[0-9]*//g' | xargs -I % sh -c 'helm tiller run $ns -- helm del --purge  % | less')+accept" \
            --preview-window=right:60% \
            --height 80%
}
