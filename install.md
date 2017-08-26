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
    - sample scripts: https://github.com/trilinos/Trilinos/blob/master/sampleScripts/do-configure-mkl-mpi-gcc-linux

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
  -DTrilinos_ENABLE_FLOAT=ON \
  -DTrilinos_ENABLE_COMPLEX=ON \
#  -DTrilinos_ENABLE_OpenMP=ON \
#  -DTpetra_INST_PTHREAD=ON \
#  -DKokkos_ENABLE_Pthread=ON \
#  -Tpetra_INST_SERIAL:BOOL=OFF \

  -DTrilinos_ENABLE_Tpetra=ON \
  -DTrilinos_ENABLE_MueLu=ON \
  -DTrilinos_ENABLE_Ifpack2=ON \
  -DTrilinos_ENABLE_Belos=ON \

  -DTPL_ENABLE_MPI=ON \
#  -DTPL_ENABLE_Pthread=ON \
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
