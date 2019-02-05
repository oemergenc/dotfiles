# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.zplug/repos/robbyrussell/oh-my-zsh
# ZSH_THEME=agnoster

fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

source ~/.zplug/init.zsh

# Zplug plugins
zplug "zplug/zplug"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search"
zplug "$ZSH/custom/plugins/zsh-autosuggestions", from:local, use:zsh-autosuggestions.zsh
zplug "rimraf/k"
zplug "b4b4r07/enhancd", use:init.sh
zplug 'plugins/git', from:oh-my-zsh
zplug 'plugins/virtualenv', from:oh-my-zsh
zplug 'plugins/docker-compose', from:oh-my-zsh
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
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
POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status virtualenv dir vcs newline)
## history options

HISTFILE="$HOME/.zhistory"
HISTSIZE=10000000
SAVEHIST=10000000

unsetopt histverify              # Do not verify expansion cmds
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.

## abbreviations
abbrev-alias -i
abbrev-alias -g gp="git push"
abbrev-alias -g gs="git status"
abbrev-alias -g gpa="git pull --all"
abbrev-alias -g gacm="git add -A; git commit -m \"\""
abbrev-alias -g gpa="git pull --all"

# Ros
export RI_ROS_WS=~/development/workspaces/ri-ws
if [ -f $HOME/development/workspaces/ros/ri-robotics-shell/ri_robotics_shell.sh ]; then
    . $HOME/development/workspaces/ros/ri-robotics-shell/ri_robotics_shell.sh
    ri_source_ros
    if [ -f $HOME/development/workspaces/ri-ws/devel/setup.zsh ]; then
        ri_source_devel
    fi
fi

# util functions
# copy to clipbaord
alias pbcopy='xclip -selection clipboard'
alias uzshrc="source ~/.zshrc"
export LC_NUMERIC=en_US.UTF-8
