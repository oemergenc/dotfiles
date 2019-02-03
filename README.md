# dotfiles
```
mkdir -p ~/fonts
cd ~/fonts
git clone https://github.com/powerline/fonts.git --depth=1
./install.sh
fc-cache -vf

sudo apt-get install zsh git curl wget vim-gnome xclip tmux

ln -s $HOME/.dotfiles/bashrc $HOME/.bashrc
ln -s $HOME/.dotfiles/zshrc $HOME/.zshrc
ln -s $HOME/.dotfiles/vimrc $HOME/.vimrc
ln -s $HOME/.dotfiles/vim $HOME/.vim
ln -s $HOME/.dotfiles/tmux.conf $HOME/.tmux.conf

vim -c PlugInstall +qall

cd $HOME/.zplug/repos/robbyrussell/oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions

git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
tmux source $HOME/.tmux.conf

```
