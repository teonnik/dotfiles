HPCToolkit issues

Two repositories are cloned, one containing the tool and another for dependecies.
All dependecies are in `hpctoolkit-externals/distfiles/`


Linking issues with `libunwind`, had to manually build 
using `bfd` linker instead of `gold`. 

./configure --prefix=<install_path> CFLAGS='-fuse-ld=bfd' CXXFLAGS='-fuse-ld=bfd'


(TODO) Missing old-monitor, open-analysis and oprofile error.
- some of those are set as non-available by default.

 

HPCToolkit can't find external dependencies, had to do:

./configure --prefix=$HOME/<install_dir> --with_papi=<papi_install dir> --with-externals=<path_to_hpctoolkit_externals> 
 
Couldn't get --with-libunwind=<path_to_libunwind> to work

I get the following error when compiling /homeb/padc/padc013/downloads/hpctoolkit/src/lib/prof-lean/stdatomic.h(438): error: identifier "_Bool" is undefined `static __inline _Bool`
