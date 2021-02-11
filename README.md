# GPAW on NERSC Cori

Progress towards a bare-metal GPAW build on NERSC's Cori XC40 system.

## Procedure

GPAW depends on many libraries. We attempt to build them in the following order:

- libxc (`build-libxc.sh`)
- fftw (`build-fftw.sh` and module load `cray-fftw`)
- libvdwxc (`build-libvdwxc.sh`)
- elpa (`build-elpa.sh`)
- ase
- gpaw (ase/gpaw built together in `build-ase-gpaw.sh`)

Goal: when all parts are working, the script `build-all.sh` can be used to
generate the entire gpaw build, conda environment, and all dependencies.

## Notes

fftw must be built with mpi support

libvdwc depends on fftw with mpi support

The ase package has a nonstandard configuration and requires manual additions
to PATH and PYTHONPATH

The gpaw package requires a `siteconfig.py` (formerly a `customize.py`) to list
and point to all of the required libraries

To check status of build, request a compute node and `./test.sh`






