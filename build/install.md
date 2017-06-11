## zsh

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

## oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

## 'gnome-terminal-solarized' and 'dircolors-solorized'

```shell
sudo apt-get install dconf-cli
git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git
cd gnome-terminal-colors-solarized
./install.sh
```

## Vundle

For `bash`

```shell
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

For `zsh`

```shell
vundle
```

## YouCompleteMe

```shell
cd ~/.vim/bundle/YouCompleteMe
./install.py
```

## tmux
From source:
  - libevent

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


## LAPACK & BLAS

```shell
sudo apt-get install libblas-dev liblapack-dev (LAPACK, BLAS)
```

## Trilinos

Information
    - reference: https://trilinos.org/docs/files/TrilinosBuildReference.html
                 https://github.com/trilinos/Trilinos/wiki/Tools-%7C--CMake

    - packages: https://github.com/trilinos/Trilinos/blob/master/PackagesList.cmake
    - TPLs: https://github.com/trilinos/Trilinos/blob/master/TPLsList.cmake

Dependencies 
    - Pthreads
    - MPI
    - LAPACK
    - BLAS

```shell
cmake .. \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=~/soft \
#  -DCMAKE_C_COMPILER=/home/wmaisrv1/nikolov/apps/bin/gcc \
#  -DCMAKE_CXX_COMPILER=/home/wmaisrv1/nikolov/apps/bin/gcc \

  -DTrilinos_HIDE_DEPRECATED_CODE=ON \
  -DTrilinos_ENABLE_EXPLICIT_INSTANTIATION=ON \
  -DTrilinos_ENABLE_Fortran=OFF \
  -DTrilinos_ENABLE_ALL_OPTIONAL_PACKAGES=OFF \

  -DTrilinos_ENABLE_Tpetra=ON \
  -DTrilinos_ENABLE_MueLu=ON \
  -DTrilinos_ENABLE_Ifpack2=ON \
  -DTrilinos_ENABLE_Belos=ON \

  -DTPL_ENABLE_MPI=ON \
  -DTPL_ENABLE_Pthread=ON \
#  -DTPL_BLAS_LIBRARIES=${BLAS_PATH} \
#  -DTPL_LAPACK_LIBRARIES=${BLAS_PATH} \
```

## Boost
Instructions
    http://www.boost.org/doc/libs/1_64_0/more/getting_started/unix-variants.html

```shell
cd $BOOST
bootstrap --prefix=<where to install boost>
./b2 -j<N> --build-type=complete
./b2 install
```

# hwloc
Instructions:
    - http://www.open-mpi.de/software/hwloc/v1.11/

## HPX
Instructions: 
    http://stellar-group.github.io/hpx/docs/html/index.html
    http://stellar-group.github.io/hpx/docs/html/hpx/manual/build_system/building_hpx/cmake_variables.html

Dependencies
    - boost 
    - hwloc 
    - gperftools

```shell
cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=~/soft \

#  -DPAPI_ROOT=<path> \   
    -DBOOST_ROOT=~/soft \
    -DHWLOC_ROOT=~/soft \

#  -DHPX_WITH_MAX_CPU_COUNT:STRING \
#  -DHPX_WITH_GOOGLE_PERFTOOLS \
    
    -DHPX_WITH_PARCELPORT_MPI=On \
    -DHPX_WITH_DATAPAR_VC=ON \  
    -DHPX_WITH_MALLOC="tcmalloc" \
    -DTCMALLOC_ROOT=~/soft 
```
# google perf tools
- libunwind
