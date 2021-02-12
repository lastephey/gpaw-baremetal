compiler = 'cc'
mpicompiler = 'cc'
mpilinker = 'cc'
extra_compile_args += ['-O2']

# these are in the cray wrapper
if 'blas' in libraries:
    libraries.remove('blas')
if 'lapack' in libraries:
    libraries.remove('lapack')

#scalapack comes from cray-libsci module
scalapack = True
if scalapack:
    define_macros += [('GPAW_NO_UNDERSCORE_CBLACS', '1')]
    define_macros += [('GPAW_NO_UNDERSCORE_CSCALAPACK', '1')]

# use our own libxc build
libxc = True
if libxc:
    path = '/global/homes/s/stephey/opt/libxc/4.3.4/gnu'
    extra_link_args += ['-Wl,-rpath=%s/lib' % path]
    library_dirs += ['%s/lib' % path]
    include_dirs += ['%s/include' % path]
    libraries += ['xc']

#use cori's cray-fftw module
fftw = True
if fftw:
    path = '/opt/cray/pe/fftw/3.3.8.4/haswell'
    extra_link_args += ['-Wl,-rpath=%s/lib' % path]
    library_dirs += ['%s/lib' % path]
    include_dirs += ['%s/include' % path]
    libraries += ['fftw3']

# use our own libvdwxc build
libvdwxc = True
if libvdwxc:
    path = '/global/homes/s/stephey/opt/libvdwxc/0.4.0/gnu'
    extra_link_args += ['-Wl,-rpath=%s/lib' % path]
    library_dirs += ['%s/lib' % path]
    include_dirs += ['%s/include' % path]
    libraries += ['vdwxc']

#use our own elpa build
elpa = True
if elpa:
    elpadir = '/global/homes/s/stephey/opt/elpa/2020.11.01/gnu'
    library_dirs += ['{}/lib'.format(elpadir)]
    extra_link_args += ['-Wl,-rpath={}/lib'.format(elpadir)]
    include_dirs += ['{}/include/elpa-2020.11.001'.format(elpadir)]
    libraries += ['elpa']
    
