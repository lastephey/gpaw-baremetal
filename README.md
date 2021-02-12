# GPAW on NERSC Cori

Progress towards a bare-metal GPAW build on NERSC's Cori XC40 system.

## Procedure

GPAW depends on many libraries. We attempt to build/use them in the following order:

- libxc (`build-libxc.sh`)
- fftw (`module load cray-fftw`)
- libvdwxc (`build-libvdwxc.sh`)
- elpa (`build-elpa.sh`)
- ase
- gpaw (ase/gpaw built together in `build-ase-gpaw.sh`)

The script `build-all.sh` can be used to generate the entire gpaw build, conda
environment, and all dependencies. Note that you will need to modify
`siteconfig.py` for your own system.

To check the status of the build, you'll need to be on an mpi-enabled (compute)
node. To test:

```
salloc -N 1 -t 30 -C knl -q interactive
./test.sh
```

This should result in a gpaw build:

```
stephey@nid00211:/global/cscratch1/sd/stephey/gpaw-build> ./test.sh
 ----------------------------------------------------------------------------------------------------------------------------------
| python-3.8.5           /global/homes/s/stephey/.conda/envs/gpaw/bin/python                                                       |
| gpaw-21.1.0            /global/homes/s/stephey/.conda/envs/gpaw/lib/python3.8/site-packages/gpaw/                                |
| ase-3.21.1-96f5a40cd8  /global/cscratch1/sd/stephey/ase/ase/                                                                     |
| numpy-1.19.2           /global/homes/s/stephey/.conda/envs/gpaw/lib/python3.8/site-packages/numpy/                               |
| scipy-1.6.0            /global/homes/s/stephey/.conda/envs/gpaw/lib/python3.8/site-packages/scipy/                               |
| libxc-4.3.4            yes                                                                                                       |
| _gpaw-c5b9c0c91b       /global/homes/s/stephey/.conda/envs/gpaw/lib/python3.8/site-packages/_gpaw.cpython-38-x86_64-linux-gnu.so |
| MPI enabled            yes                                                                                                       |
| OpenMP enabled         no                                                                                                        |
| scalapack              yes                                                                                                       |
| Elpa                   yes; version: 20200417                                                                                    |
| FFTW                   yes                                                                                                       |
| libvdwxc               yes                                                                                                       |
| PAW-datasets (1)       /usr/local/share/gpaw-setups                                                                              |
| PAW-datasets (2)       /usr/share/gpaw-setups                                                                                    |
 ----------------------------------------------------------------------------------------------------------------------------------
```

## Notes

All of the paths in `siteconfig.py` are configured for my own build location.
You'll need to change these to match wherever you install the libxc, libvdwxc,
and elpa libraries. 

fftw must be built with mpi support- Cori's `cray-fftw` module provides this

libvdwxc depends on fftw with mpi support (using Cori's `cray-fftw` module)

The ase package has a nonstandard configuration and requires manual additions
to `PATH` and `PYTHONPATH`

The gpaw package requires a `siteconfig.py` (formerly a `customize.py`) to list
and point to all of the required libraries

## Known issues

Building elpa with avx512 enabled has been tough, so I disabled it. Users
will need to do some additional troubleshooting to enable this option.

We have built with the `cray-fftw` module which itself has been built for
Haswell. Users who wish to have an fftw optimized for KNL may choose to build
this library themselves.




