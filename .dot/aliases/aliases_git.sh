function git-clean-branches ()
{
    git fetch --prune
    git branch -vv | grep 'origin/.*: gone]' | awk '{print $1}' | xargs git branch -d
    git branch -l
}

function ggf()
{
    while true; 
    do
        clear
        git log --max-count=50 --graph --topo-order --decorate --oneline --all --pretty=format:"%Cgreen%h%Creset - %Cblue%an%Creset @ %ai : %s"
        sleep 2
    done 
}

alias gp="git push"
alias gs="git status"
alias gpa="git pull --all"
alias gaucm="git add -u; git commit -m \"\""
alias gaacm="git add -A; git commit -m \"\""
alias gbl="git branch -l"
alias gclb="git-clean-branches"
