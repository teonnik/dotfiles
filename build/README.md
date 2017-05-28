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

## tmux
Plugin manager
```shell
git clone https://github.com/tmux-plugins/tpm.git  

```

State capture
```shell
git clone https://github.com/tmux-plugins/tmux-resurrect
```

xclip: https://www.howtoforge.com/command-line-copy-and-paste-with-xclip-debian-ubuntu
clarification: https://askubuntu.com/questions/383462/unable-to-paste-with-xclip-outside-of-terminal

Set options for 'ssh' and 'vim' remote


## Trilinos

Information
Build reference: https://trilinos.org/docs/files/TrilinosBuildReference.html
List packages: ./do-configure.sh 2>&1 | grep "Trilinos_SE_PACKAGES: " (Trilinos_ENABLE)
List third party libraries (TPL): "./do-configure.sh 2>&1 | grep "Final set of . TPLs"

Dependencies: Pthreads, LAPACK, BLAS, MPI
1. sudo apt-get install libblas-dev liblapack-dev (LAPACK, BLAS)
2. Clone repository
3. Build with cmake from subdirectory using `trilinos_conf` script

```shell
cmake .. \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX:PATH=~/soft \
#  -DCMAKE_C_COMPILER=/home/wmaisrv1/nikolov/apps/bin/gcc \
#  -DCMAKE_CXX_COMPILER=/home/wmaisrv1/nikolov/apps/bin/gcc \


#  -DTrilinos_EXTRA_LINK_FLAGS:STRING=-lgfortran \
  -DTrilinos_ENABLE_EXPLICIT_INSTANTIATION=ON \
  -DTrilinos_ENABLE_Fortran=OFF \
  -DTrilinos_ENABLE_ALL_OPTIONAL_PACKAGES=OFF \

  -DTrilinos_ENABLE_Tpetra=ON \
  -DTrilinos_ENABLE_MueLu=ON \
  -DTrilinos_ENABLE_Ifpack2=ON \
  -DTrilinos_ENABLE_Belos=ON \

  -DTPL_ENABLE_MPI=ON \
#  -DTPL_BLAS_LIBRARIES=${BLAS_PATH} \
#  -DTPL_LAPACK_LIBRARIES=${BLAS_PATH} \
```

## HPX
Instructions: 
    http://stellar-group.github.io/hpx/docs/html/index.html

Dependencies
boost: 
    - Instruction: http://www.boost.org/doc/libs/1_64_0/more/getting_started/unix-variants.html
hwloc: http://www.open-mpi.de/software/hwloc/v1.11/
gperftools: clone repository

Command
```shell
cmake .. \
    -DBOOST_ROOT=~/soft \
    -DHWLOC_ROOT=~/soft \
    -DHPX_WITH_DATAPAR_VC=ON \  
    -DCMAKE_BUILD_TYPE=Release \
    -DTCMALLOC_ROOT=~/soft \
    -DHPX_WITH_MALLOC="tcmalloc" \
    -DCMAKE_INSTALL_PREFIX=~/soft \
```
