function git-show-base(){
  git show-branch | sed "s/].*//" | grep "\*" | grep -v "$(git rev-parse --abbrev-ref HEAD)" | head -n1 | sed "s/^.*\[//" 
}

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
alias gco='forgit::checkout::file'
alias fstash='forgit::stash::show'
