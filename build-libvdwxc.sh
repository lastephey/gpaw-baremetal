#!/bin/bash
set -e
prgenv=${prgenv:=gnu}
version=${version:=0.4.0}
prefix_root=${prefix_root:=~/opt}
name=libvdwxc
prefix=$prefix_root/$name/$version/$prgenv
filename=$name-$version.tar.gz
url=https://gitlab.com/libvdwxc/libvdwxc
module list
module swap PrgEnv-${PE_ENV,,} PrgEnv-$prgenv
module load cray-libsci
module load cray-fftw
export CRAYPE_LINK_TYPE=dynamic
build_dir=$(mktemp -d --tmpdir $name.XXXXXXX)
cd $build_dir
git clone --branch $version $url
cd $name
# compiler options
case "$prgenv" in
    intel)
	FLAGS="-O3 -fp-model strict"
	;;
    gnu)
	FLAGS="-O3 -fPIC"
	;;
    cray)
	FLAGS="-O1 -hfp0"
	;;
esac
autoreconf -i
./configure --prefix=$prefix CC=cc FC=ftn F77=ftn\
    CFLAGS="$FLAGS" FCFLAGS="$FLAGS" \
    --enable-shared \
    --enable-static \
    --with-mpi
#    FFTW3_INCLUDES="-I/global/homes/s/stephey/opt/fftw/3.3.9/gnu/include" \
#    FFTW3_LIBS="-L/global/homes/s/stephey/opt/fftw/3.3.9/gnu/lib -lfftw3"
make -j 64
if [ $? -eq 0 ]; then
    make install
fi
rm -fr $build_dir
rm -fr /tmp/$name.*

