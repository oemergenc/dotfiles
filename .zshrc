export TERM="xterm-256color"
ZSH_TMUX_AUTOSTART=true

source ~/.zplug/init.zsh

# Zplug plugins
zplug "zplug/zplug"
zplug 'plugins/tmux',             from:oh-my-zsh
zplug "plugins/vi-mode",          from:oh-my-zsh
zplug "plugins/docker",           from:oh-my-zsh
zplug "plugins/docker-compose",   from:oh-my-zsh
zplug "zsh-users/zsh-completions"
zplug "tarruda/zsh-autosuggestions",              defer:1
zplug "zsh-users/zsh-syntax-highlighting",        defer:2
zplug "zsh-users/zsh-history-substring-search",   defer:3
zplug "matthieusb/zsh-sdkman", use:zsh-sdkman.plugin
zplug "romkatv/powerlevel10k", as:theme
zplug "junegunn/fzf", as:command, hook-build:"./install --all", use:"bin/{fzf-tmux,fzf}"
zplug "wfxr/forgit"
zplug "zdharma/zsh-diff-so-fancy", as:command, use:bin/diff-so-fancy
zplug "mnowotnik/docker-fzf-completion", use:"docker-fzf-completion.plugin.zsh"
zplug "Aloxaf/fzf-tab", use:"*.zsh" defer:2

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

set -o vi

if zplug check tarruda/zsh-autosuggestions; then
    ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down)
    ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#(up|down)-line-or-history}")
    bindkey '^ ' autosuggest-accept
fi

if zplug check zsh-users/zsh-history-substring-search; then
    bindkey '\eOA' history-substring-search-up
    bindkey '\eOB' history-substring-search-down
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh
# history options
HISTFILE="$HOME/.zhistory"
HISTSIZE=10000000
SAVEHIST=10000000

unsetopt histverify              # Do not verify expansion cmds
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.

source $HOME/.dot/env/env_ros.sh
source $HOME/.dot/env/env_helm.sh
source $HOME/.dot/aliases/aliases

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# autoload -Uz compinit ; compinit
# autoload -Uz compinit
# for dump in ~/.zcompdump(N.mh+24); do
#   compinit
# done
# compinit -C

if [ -x "$(command -v rbenv)" ]; then
  eval "$(rbenv init -)"
  export PATH=$HOME/.rbenv/versions/2.6.2/bin/:$PATH
fi

# krew kubectl plugin manager
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export LC_ALL=en_US.UTF-8

if [ -x "$(command -v helm)" ]; then
  source <(helm completion zsh)
fi

# POWERLEVEL9K Setup
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source ~/.zplug/repos/Aloxaf/fzf-tab/fzf-tab.plugin.zsh
