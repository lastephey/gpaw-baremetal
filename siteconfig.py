compiler = 'cc'
mpicompiler = 'cc'
mpilinker = 'cc'
extra_compile_args += ['-O2']

# these are in the cray wrapper
if 'blas' in libraries:
    libraries.remove('blas')
if 'lapack' in libraries:
    libraries.remove('lapack')

scalapack = True
if scalapack:
    define_macros += [('GPAW_NO_UNDERSCORE_CBLACS', '1')]
    define_macros += [('GPAW_NO_UNDERSCORE_CSCALAPACK', '1')]

#use cori fftw
fftw = True
if fftw:
    path = '/opt/cray/pe/fftw/3.3.8.4/haswell'
    extra_link_args += ['-Wl,-rpath=%s/lib' % path]
    library_dirs += ['%s/lib' % path]
    include_dirs += ['%s/include' % path]
    libraries += ['fftw']

####use our own fftw
####make sure that libvdwxc is using the right fftw
###fftw = True
###if fftw:
###    path = '/global/homes/s/stephey/opt/fftw/3.3.9/gnu'
###    extra_link_args += ['-Wl,-rpath=%s/lib' % path]
###    library_dirs += ['%s/lib' % path]
###    include_dirs += ['%s/include' % path]
###    libraries += ['fftw']

# Use Elpa (requires ScaLAPACK and Elpa API 20171201):
elpa = True
if elpa:
    elpadir = '/global/homes/s/stephey/opt/elpa/2020.11.01/gnu'
    libraries += ['elpa']
    library_dirs += ['{}/lib'.format(elpadir)]
    extra_link_args += ['-Wl,-rpath={}/lib'.format(elpadir)]
    include_dirs += ['{}/include/elpa-2020.11.001'.format(elpadir)]

# libxc
libxc = True
if libxc:
    path = '/global/homes/s/stephey/opt/libxc/4.3.4/gnu'
    extra_link_args += ['-Wl,-rpath=%s/lib' % path]
    library_dirs += ['%s/lib' % path]
    include_dirs += ['%s/include' % path]
    libraries += ['xc']

# libvdwxc:
libvdwxc = True
if libvdwxc:
    path = '/global/homes/s/stephey/opt/libvdwxc/0.4.0/gnu'
    extra_link_args += ['-Wl,-rpath=%s/lib' % path]
    library_dirs += ['%s/lib' % path]
    include_dirs += ['%s/include' % path]
    libraries += ['vdwxc']    

    
