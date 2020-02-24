export TERM="xterm-256color"
ZSH_TMUX_AUTOSTART=true

source ~/.zplug/init.zsh

zplug "zplug/zplug"
zplug 'plugins/tmux',             from:oh-my-zsh
zplug "plugins/vi-mode",          from:oh-my-zsh
zplug "zsh-users/zsh-completions"
zplug "romkatv/powerlevel10k", as:theme

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

export ZSH=$HOME/.zplug/repos/robbyrussell/oh-my-zsh

source $ZSH/oh-my-zsh.sh

HISTFILE="$HOME/.zhistory"
HISTSIZE=10000000
SAVEHIST=10000000

unsetopt histverify              # Do not verify expansion cmds
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export LC_ALL=en_US.UTF-8

if [ -x "$(command -v helm)" ]; then
  source <(helm completion zsh)
fi

[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
