# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.zplug/repos/robbyrussell/oh-my-zsh/
ZSH_THEME=agnoster

source /opt/ros/melodic/setup.zsh
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

source ~/.zplug/init.zsh

# Zplug plugins
zplug "zplug/zplug"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "rimraf/k"
zplug "b4b4r07/enhancd", use:init.sh
zplug 'plugins/git', from:oh-my-zsh
zplug "themes/agnoster", from:oh-my-zsh
zplug "momo-lab/zsh-abbrev-alias"

source $ZSH/oh-my-zsh.sh

# Install packages that have not been installed yet
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

zplug load 

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
prompt_dir() {
    prompt_segment blue black "%$(( $COLUMNS - 61 ))<...<%3~%<<"
}

prompt_end() {                                        
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}
$SEGMENT_SEPARATOR"
  CURRENT_BG=''
}

## abbreviations
abbrev-alias -i
abbrev-alias -g gp="git push"
abbrev-alias -g gs="git status"
abbrev-alias -g gpa="git pull --all"
abbrev-alias -g gacm="git add -A; git commit -m \"\""
abbrev-alias -g gpa="git pull --all"

# Ros
export RI_ROS_WS=~/development/workspaces/ri-ws
alias sr='source $RI_ROS_WS/devel/setup.zsh'
alias kg="kill \$(ps aux| grep -E 'gazebo|simulation.launch' | grep -v grep | awk '{print \$2}')"

# util functions
# copy to clipbaord
alias pbcopy='xclip -selection clipboard'
