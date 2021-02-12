export CRAYPE_LINK_TYPE=dynamic
module swap PrgEnv-${PE_ENV,,} PrgEnv-gnu
module unload craype-hugepages2M
module load cray-libsci
module load cray-fftw #try with nersc fftw for now
module load python

topdir=$(pwd)

#using 3.8 instead of 3.6
#overwriting existing gpaw env
conda create --name gpaw python=3.8 pip numpy scipy matplotlib -y --force

source activate gpaw

#clone ase
cd $HOME
rm -rf $HOME/ase
git clone -b 3.21.1 https://gitlab.com/ase/ase.git
cd ase
python setup.py install

export PATH=$HOME/ase/bin:$PATH
export PYTHONPATH=$HOME/ase:$PYTHONPATH

#clone gpaw
cd $HOME
rm -rf $HOME/gpaw
git clone -b 21.1.0 https://gitlab.com/gpaw/gpaw.git
cd gpaw
cp $topdir/siteconfig.py siteconfig.py

python setup.py build_ext
python setup.py install

