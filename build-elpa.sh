#!/bin/bash
set -e
prgenv=${prgenv:=gnu}
version=${version:=2020.11.01}
prefix_root=${prefix_root:=~/opt}
name=elpa
prefix=$prefix_root/$name/$version/$prgenv
filename=$name-$version.tar.gz
module list
module swap PrgEnv-${PE_ENV,,} PrgEnv-$prgenv
module load cray-libsci
module load cray-fftw
export CRAYPE_LINK_TYPE=dynamic
build_dir=$(mktemp -d --tmpdir $name.XXXXXXX)
cd $build_dir
wget https://elpa.mpcdf.mpg.de/html/Releases/2020.11.001/elpa-2020.11.001.tar.gz
tar -xvf elpa-2020.11.001.tar.gz
cd elpa-2020.11.001   
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
    --disable-avx512
make -j 64
if [ $? -eq 0 ]; then
    make install
fi
rm -fr $build_dir
rm -fr /tmp/$name.*

