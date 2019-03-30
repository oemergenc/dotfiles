#!/bin/bash

# ZPLUG
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# SDKMan
curl -s "https://get.sdkman.io" | zsh

# SpaceVim
curl -sLf https://spacevim.org/install.sh | zsh
