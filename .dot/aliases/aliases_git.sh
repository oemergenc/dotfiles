function git-clean-branches()
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

fcoc() 
{
  local commits commit
  commits=$(git log --pretty=format:"%Cgreen%h%Creset%x09%Cblue%an%Creset%x09%ad%x09%s" --reverse)
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | awk '{print $1}')
}

fbr() 
{
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
fstash() {
  local out q k sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
    fzf --ansi --no-sort --query="$q" --print-query \
        --expect=ctrl-d,ctrl-b);
  do
    mapfile -t out <<< "$out"
    q="${out[0]}"
    k="${out[1]}"
    sha="${out[-1]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git diff $sha
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" $sha
      break;
    else
      git stash show -p $sha
    fi
  done
}

alias gp="git push"
alias gs="git status"
alias gpla="git pull --all"
alias gaucm="git add -u; git commit -m \"\""
alias gaacm="git add -A; git commit -m \"\""
alias gbl="git branch -l"
alias gclb="git-clean-branches"
alias gsp="git stash pop"
alias gsc="git stash clear"
alias gst="git stash"
