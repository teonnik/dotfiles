# Sample .bashrc for SuSE Linux
# Copyright (c) SuSE GmbH Nuernberg

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)
#export EDITOR=/usr/bin/vim
#export EDITOR=/usr/bin/mcedit

# For some news readers it makes sense to specify the NEWSSERVER variable here
#export NEWSSERVER=your.news.server

# If you want to use a Palm device with Linux, uncomment the two lines below.
# For some (older) Palm Pilots, you might need to set a lower baud rate
# e.g. 57600 or 38400; lowest is 9600 (very slow!)
#
#export PILOTPORT=/dev/pilot
#export PILOTRATE=115200

test -s ~/.alias && . ~/.alias || true
export PATH=/usr/NX/bin:/usr/lib64/mpi/gcc/openmpi/bin:/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/X11R6/bin:/usr/games:/usr/lib/mit/bin:/usr/lib/mit/sbin


# local bin directory
export CPATH="/home/wmaisrv1/nikolov/apps/include:$CPATH"
export LIBRARY_PATH="/home/wmaisrv1/nikolov/apps/lib:/home/wmaisrv1/nikolov/apps/lib64:$LIBRARY_PATH"
export LD_LIBRARY_PATH="/home/wmaisrv1/nikolov/apps/lib:/home/wmaisrv1/nikolov/apps/lib64:$LD_LIBRARY_PATH"
export PATH="/home/wmaisrv1/nikolov/apps/bin:$PATH"

# C/C++ compiler
export CC=/home/wmaisrv1/nikolov/apps/bin/clang
export CXX=/home/wmaisrv1/nikolov/apps/bin/clang++

# added by Anaconda3 4.1.1 installer
export PATH="/home/wmaisrv1/nikolov/anaconda3/bin:$PATH"
