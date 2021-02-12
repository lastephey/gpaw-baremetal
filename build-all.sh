export CRAYPE_LINK_TYPE=dynamic
module swap PrgEnv-${PE_ENV,,} PrgEnv-gnu
module unload craype-hugepages2M #see INC0161326
module load cray-libsci
module load cray-fftw
module load python

topdir=$(pwd)

#build libxc
./build-libxc.sh

#build libvdwxc which depends on fftw with mpi
./build-libvdwxc.sh

#build elpa
./build-elpa.sh

#create python env and build python packages ase and gpaw

#using 3.8 instead of 3.6
conda create --name gpaw python=3.8 pip numpy scipy matplotlib -y

source activate gpaw

#clone ase
cd $HOME
git clone -b 3.21.1 https://gitlab.com/ase/ase.git
cd ase
python setup.py install

export PATH=$SCRATCH/ase/bin:$PATH
export PYTHONPATH=$SCRATCH/ase:$PYTHONPATH

#clone gpaw
cd $HOME
git clone -b 21.1.0 https://gitlab.com/gpaw/gpaw.git
cd gpaw
cp $topdir/siteconfig.py siteconfig.py

#finally build gpaw which depends on all of the libraries we just built
python setup.py build_ext
python setup.py install

#see if this worked by getting an interactive compute node and running ./tesh.sh
#this sets up the appropriate env and runs `gpaw info`
