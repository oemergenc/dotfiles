# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export TERM="xterm-256color"

source ~/.zplug/init.zsh

# Zplug plugins
zplug "zplug/zplug"
zplug 'plugins/git',              from:oh-my-zsh
zplug 'plugins/virtualenv',       from:oh-my-zsh
zplug 'plugins/docker',           from:oh-my-zsh
zplug 'plugins/docker-compose',   from:oh-my-zsh
zplug "plugins/vagrant",          from:oh-my-zsh
zplug "zsh-users/zsh-completions"
zplug "tarruda/zsh-autosuggestions",            defer:1
zplug "zsh-users/zsh-syntax-highlighting",      defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "matthieusb/zsh-sdkman", use:zsh-sdkman.plugin
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
zplug "b4b4r07/git-open", as:command, at:patch-1
zplug "junegunn/fzf", as:command, hook-build:"./install --all", use:"bin/{fzf-tmux,fzf}"
zplug "kubermatic/fubectl", use:"fubectl.source"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.zplug/repos/robbyrussell/oh-my-zsh

fpath=(~/.zsh/completion $fpath)

source $ZSH/oh-my-zsh.sh

if zplug check zsh-users/zsh-autosuggestions; then
    ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down)
    ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#(up|down)-line-or-history}")
fi


if zplug check zsh-users/zsh-history-substring-search; then
    bindkey '\eOA' history-substring-search-up
    bindkey '\eOB' history-substring-search-down
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# POWERLEVEL9K Setup
function get_kube_context(){
  rd_kube_context=$(grep "current-context" $HOME/.kube/config | sed s/gke_//g | sed s/_europe-west1-c_bigdata//g | sed s/"current-context: "//g)
  echo $rd_kube_context
}
POWERLEVEL9K_CUSTOM_KUBE_CONTEXT="get_kube_context"
POWERLEVEL9K_CUSTOM_KUBE_CONTEXT_BACKGROUND="green"
POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status custom_kube_context virtualenv dir vcs newline)
## Fish style path truncation behavior 
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"

# history options
HISTFILE="$HOME/.zhistory"
HISTSIZE=10000000
SAVEHIST=10000000

unsetopt histverify              # Do not verify expansion cmds
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.

source $HOME/.dot/env/env_ros.sh
source $HOME/.dot/aliases/aliases

source <(kubectl completion zsh)

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

autoload -Uz compinit ; compinit
