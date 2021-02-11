#test on interactive haswell node
#salloc -N 1 -t 30 -C haswell -q interactive

module swap PrgEnv-${PE_ENV,,} PrgEnv-gnu
module unload craype-hugepages2M
module load python
source activate gpaw
export OMP_NUM_THREADS=1

export PATH=$SCRATCH/ase/bin:$PATH
export PYTHONPATH=$SCRATCH/ase:$PYTHONPATH

export MKL_CBWR="AVX"
#gpaw-python deprecated
gpaw test

#result:

#*** Error in `/global/homes/s/stephey/.conda/envs/gpaw/bin/python': break
#adjusted to free malloc space: 0x0000010000000000 *** ./test-brandon.sh: line
#8: 60165 Aborted
