function git-clean-branches()
{
    git fetch --prune
    git branch -vv | grep 'origin/.*: gone]' | awk '{print $1}' | xargs git branch -d
    git branch -l
}

fcoc() 
{
  local commits commit
  commits=$(git log --pretty=format:"%Cgreen%h%Creset%x09%Cblue%an%Creset%x09%ad%x09%s" --reverse)
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | awk '{print $1}')
}

fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

fco() {
  local filter
  if [ -n $@ ] && [ -f $@ ]; then
    filter="-- $@"
  fi

  git log \
    --graph --color=always --abbrev=7 --format='%C(auto)%h %an %C(blue)%s %C(yellow)%cr' $@ | \
    fzf \
      --ansi --no-sort --tiebreak=index \
      --preview "f() { set -- \$(echo -- \$@ | grep -o '[a-f0-9]\{7\}'); [ \$# -eq 0 ] || git show --color=always \$1 $filter; }; f {}" \
      --header="ENTER to view, CTRL-Y/E/F/B to scroll preview, CTRL-S to copy commit-hash, CTRL-X to checkout, CTRL-C to exit" \
      --bind "j:down,k:up,ctrl-e:preview-down,ctrl-y:preview-up,ctrl-f:preview-page-down,ctrl-b:preview-page-up,q:abort,ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
                FZF-EOF" \
      --bind "ctrl-s:execute(echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | pbcopy)+accept" \
      --bind "ctrl-x:execute(echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git checkout %')+accept" \
      --bind "ctrl-l:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 | 
                xargs -I % sh -c 'git show --pretty="format:" --name-only % | fzf') << 'FZF-EOF'
                {}
                FZF-EOF" \
      --preview-window=right:60% \
      --height 80%
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

# forgit option
FORGIT_FZF_DEFAULT_OPTS="
$FORGIT_FZF_DEFAULT_OPTS
--header='CTRL-Y/E/F/B to scroll preview, TAB to mark, CTRL-R toggle selection, CTRL-C/q to exit'
--bind='j:down,k:up,ctrl-e:preview-down,ctrl-y:preview-up,ctrl-f:preview-page-down,ctrl-b:preview-page-up,q:abort'
"
FORGIT_LOG_FZF_OPTS="
--header='CTRL-Y/E/F/B to scroll preview, CTRL-S to copy commit hash, CTRL-C/q to exit'
--bind=\"ctrl-l:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 | 
                xargs -I % sh -c 'git show --pretty="format:" --name-only % | fzf') << 'FZF-EOF'
                {}
                FZF-EOF\"
--bind=\"ctrl-l:execute(echo {} |grep -Eo '[a-f0-9]+' | head -1 | xargs -I% git show --pretty="format:" --name-only % $* | fzf)\"
--bind=\"ctrl-s:execute-silent(echo {} |grep -Eo '[a-f0-9]+' | head -1 | tr -d '\n' |${FORGIT_COPY_CMD:-pbcopy})\"
"
FORGIT_DIFF_FZF_OPTS="
--bind=\"ctrl-o:execute(git difftool --tool=vimdiff {})\"
--bind=\"ctrl-u:execute(echo {})+accept\"
"

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
alias gaa="git add --all"
alias gau="git add -u"
alias gcm="git checkout master"
alias gcma="git checkout main"
alias gmastertomain='git branch -m master main; git fetch origin; git branch -u origin/main main'
alias gcmsg='git commit -m'
alias gco='forgit::restore'
