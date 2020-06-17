#! /bin/bash

mkdir -p bin code build

# install package manager : spack
(cd code; git clone https://github.com/spack/spack.git)

# fetch dotfiles
(cd code; git clone https://github.com/teonnik/dotfiles.git)

# ------------------------------
# zsh

# install zsh
spack install zsh
ln -sf $(spack location -i zsh)/bin/zsh ${HOME}/bin/zsh
# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
# install zsh autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# ------------------------------
# vim

# install vim
spack install vim
ln -sf $(spack location -i vim)/bin/vim ${HOME}/bin/vim
# install vim plugin manager
curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# install vim plugins
vim +PlugInstall +qall

# TODO: cmake
