## Install zsh

```shell
wget -O zsh.tar.gz https://sourceforge.net/projects/zsh/files/latest/download
mkdir zsh && tar -xvzf zsh.tar.gz -C zsh --strip-components 1
cd zsh

./configure --prefix=<install/dir>
make
make install
```

Put the lines below in `.profile`

```shell
export SHELL=`which zsh`
[ -z "$ZSH_VERSION" ] && exec "$SHELL" -l
```

## Install oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

## Install 'gnome-terminal-solarized' and 'dircolors-solorized'

```shell
sudo apt-get install dconf-cli
git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git
cd gnome-terminal-colors-solarized
./install.sh
```

## Install Vundle

For `bash`

```shell
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

For `zsh`

```shell
vundle
```

## Install YouCompleteMe

```shell
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer
```

## Install tmux
Plugin manager
```shell
git clone https://github.com/tmux-plugins/tpm.git  

```

State capture
```shell
git clone https://github.com/tmux-plugins/tmux-resurrect
```

Set options for 'ssh' and 'vim' remote
