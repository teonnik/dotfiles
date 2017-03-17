#!/bin/sh

# TRILINOS_SOURCE_PATH=
TRILINOS_INSTALL_PATH=${HOME}/apps
#BLAS_PATH=/usr/local/software/jureca/Stages/2016a/software/OpenBLAS/0.2.15-GCC-5.3.0-2.26-LAPACK-3.6.0/libopenblas.so

rm -f CMakeCache.txt

cmake .. \
  -DCMAKE_INSTALL_PREFIX:PATH=${TRILINOS_INSTALL_PATH} \
  -DMPI_BASE_DIR=$HOME/apps \
  -DTrilinos_ENABLE_CXX11=ON \
  -DTrilinos_ENABLE_Fortran=OFF \
  -DTPL_ENABLE_MPI=ON \
  -DTrilinos_ENABLE_OpenMP=ON \
  -DTrilinos_ENABLE_EXPLICIT_INSTANTIATION=ON \
  -DTrilinos_EXTRA_LINK_FLAGS:STRING=-lgfortran \
  -DTrilinos_ENABLE_Tpetra=ON \
  -DTrilinos_ENABLE_Ifpack2=ON \
  -DTrilinos_ENABLE_Belos=ON \
  -DTrilinos_ENABLE_Amesos2=ON \
  -DTrilinos_ENABLE_Anasazi=ON \
  -DTrilinos_ENABLE_Thyra=ON \
  -DTrilinos_ENABLE_Teuchos=ON \
  -DTrilinos_ENABLE_Kokkos=ON \
  -DTrilinos_VERBOSE_CONFIGURE=ON \

#  -DCMAKE_C_COMPILER=/home/wmaisrv1/nikolov/apps/bin/gcc \
#  -DCMAKE_CXX_COMPILER=/home/wmaisrv1/nikolov/apps/bin/gcc \

#  -DTPL_BLAS_LIBRARIES=${BLAS_PATH} \
#  -DTPL_LAPACK_LIBRARIES=${BLAS_PATH} \

#  -DTrilinos_ENABLE_Galeri=ON \
#  -DTrilinos_ENABLE_Didasko=ON \

#  -DBLAS_LIBRARY_DIRS= ${BLAS_PATH} \  
#  -DTPL_ENABLE_BLAS=OFF \
#  -TPL_BLAS_LIBRARIES:STRING=
#  -TPL_LAPACK_LIBRARIES:SRING=

#  -D -D TPL_ENABLE_<TPLNAME>=ON \
#  -D TPL_SomeTPL_INCLUDE_DIRS="${LIB_BASE}/include/a;${LIB_BASE}/include/b" \
#  -D TPL_SomeTPL_LIBRARIES="${LIB_BASE}/lib/liblib1.so;${LIB_BASE}/lib/liblib2.so" \


#  -DCMAKE_BUILD_TYPE=Release \

# Comments
#  Trilinos packages: ./do-configure.sh 2>&1 | grep "Trilinos_SE_PACKAGES: " (Trilinos_ENABLE)
#  Third party libraries (TPL): "./do-configure.sh 2>&1 | grep "Final set of .* TPLs"
#  Build reference: https://trilinos.org/docs/files/TrilinosBuildReference.html
#  Remove all but 'do-configure.sh' : find . ! -name 'do-configure.sh' -type f -exec rm -f {} +
