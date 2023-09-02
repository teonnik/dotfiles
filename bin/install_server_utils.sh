#!/bin/bash

# git-delta
DELTA_VERSION=0.16.5
wget https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/delta-${DELTA_VERSION}-x86_64-unknown-linux-musl.tar.gz

# neovim
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz

# ripgrep
RG_VERSION=13.0.0
wget https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz

# ninja
NINJA_VERSION=1.11.1
wget https://github.com/ninja-build/ninja/releases/download/v${NINJA_VERSION}/ninja-linux.zip

# cmake
CMAKE_VERSION=3.27.4
wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz

# direnv
DIRENV_VERSION=2.32.3
wget https://github.com/direnv/direnv/releases/download/v${DIRENV_VERSION}/direnv.linux-amd64

# clangd
CLANGD_VERSION=16.0.2
wget https://github.com/clangd/clangd/releases/download/${CLANGD_VERSION}/clangd-linux-${CLANGD_VERSION}.zip

# libtree
LIBTREE_VERSION=3.1.1
wget https://github.com/haampie/libtree/releases/download/v${LIBTREE_VERSION}/libtree_x86_64

# LLVM+clang+lldb
LLVM_VERSION=16.0.0
wget https://github.com/llvm/llvm-project/releases/download/llvmorg-${LLVM_VERSION}/clang+llvm-${LLVM_VERSION}-x86_64-linux-gnu-ubuntu-18.04.tar.xz

# bat
BAT_VERSION=0.23.0
wget https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat-v${BAT_VERSION}-x86_64-unknown-linux-musl.tar.gz

# fd
FD_VERSION=8.7.0
wget https://github.com/sharkdp/fd/releases/download/v${FD_VERSION}/fd-v${FD_VERSION}-x86_64-unknown-linux-musl.tar.gz

# fzf
FZF_VERSION=0.42.0
wget https://github.com/junegunn/fzf/releases/download/${FZF_VERSION}/fzf-${FZF_VERSION}-linux_amd64.tar.gz

# exa (replacement for ls and tree)
EXA_VERSION=0.10.1
wget https://github.com/ogham/exa/releases/download/v${EXA_VERSION}/exa-linux-x86_64-musl-v${EXA_VERSION}.zip

# ccache
CCACHE_VERSION=4.8.3
wget https://github.com/ccache/ccache/releases/download/v${CCACHE_VERSION}/ccache-${CCACHE_VERSION}-linux-x86_64.tar.xz

# TODO: spack
#spack compiler find
#spack external find
#cat >> ~/.spack/packages.yaml << EOF
#  python:
#    externals:
#    - spec: python@<version>
#      prefix: <path>
#  ncurses:
#    externals:
#    - spec: ncurses@<version>
#      prefix: <path>
#EOF

# TODO: zsh -- depends on spack
# spi zsh

# TODO: !! bear
# spi bear

# TODO: unzip
# spi unzip

# TODO: jedi
# spi py-jedi
