export TERM="xterm-256color"
if [ "$TERMINAL_EMULATOR" != "JetBrains-JediTerm" ]
then
   ZSH_TMUX_AUTOSTART=true
fi

source ~/.zplug/init.zsh

# Zplug plugins
zplug "zplug/zplug"
zplug "romkatv/powerlevel10k",    as:theme, depth:1
zplug 'plugins/tmux',             from:oh-my-zsh
zplug "plugins/vi-mode",          from:oh-my-zsh
zplug "plugins/docker",           from:oh-my-zsh
zplug "plugins/docker-compose",   from:oh-my-zsh
zplug "zsh-users/zsh-completions"
zplug "tarruda/zsh-autosuggestions",              defer:1
zplug "zsh-users/zsh-syntax-highlighting",        defer:2
zplug "zsh-users/zsh-history-substring-search",   defer:3
zplug "matthieusb/zsh-sdkman", use:zsh-sdkman.plugin
zplug "junegunn/fzf", as:command, hook-build:"./install --all", use:"bin/{fzf-tmux,fzf}"
zplug "wfxr/forgit"
zplug "zdharma/zsh-diff-so-fancy", as:command, use:bin/diff-so-fancy
zplug "mnowotnik/docker-fzf-completion", use:"docker-fzf-completion.plugin.zsh"
zplug "Aloxaf/fzf-tab", use:"*.zsh" defer:2

zplug load

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.zplug/repos/robbyrussell/oh-my-zsh

# source completions
#fpath=(~/.zsh/completion $fpath)

# source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# enable vi mode
set -o vi

if zplug check tarruda/zsh-autosuggestions; then
    ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down)
    ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#(up|down)-line-or-history}")
    bindkey '^ ' autosuggest-accept
    bindkey '^f' forward-word
fi

if zplug check zsh-users/zsh-history-substring-search; then
    bindkey '\eOA' history-substring-search-up
    bindkey '\eOB' history-substring-search-down
    bindkey '^p' history-substring-search-up
    bindkey '^n' history-substring-search-down
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=1
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

export LC_ALL=en_US.UTF-8

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$GOBIN:$PATH

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

source ~/.zplug/repos/Aloxaf/fzf-tab/fzf-tab.plugin.zsh
