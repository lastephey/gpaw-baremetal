#!/bin/bash
set -e
prgenv=${prgenv:=gnu}
version=${version:=3.3.9}
prefix_root=${prefix_root:=~/opt}
name=fftw
prefix=$prefix_root/$name/$version/$prgenv
filename=$name-$version.tar.gz
module list
module swap PrgEnv-${PE_ENV,,} PrgEnv-$prgenv
export CRAYPE_LINK_TYPE=dynamic
build_dir=$(mktemp -d --tmpdir $name.XXXXXXX)
cd $build_dir
wget http://fftw.org/fftw-3.3.9.tar.gz
tar -xvf fftw-3.3.9.tar.gz
cd fftw-3.3.9
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
./configure --prefix=$prefix --host=x86_64-linux-gnu CC=cc FC=ftn F77=ftn\
    CFLAGS="$FLAGS" FCFLAGS="$FLAGS" \
    --enable-shared \
    --enable-static \
    --enable-mpi
make -j 64
if [ $? -eq 0 ]; then
    make install
fi
rm -fr $build_dir
rm -fr /tmp/$name.*

