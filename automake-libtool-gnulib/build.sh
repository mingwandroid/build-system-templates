#!/usr/bin/env bash

./clean.sh
./bootstrap.sh > bootstrap.log 2>&1

INPATH=${PATH}
#SYSTEMS=('mingw32' 'mingw64' 'msys2')
#VARIANTS=('all-static' 'static' 'shared' 'both')
SYSTEMS=('mingw64')
VARIANTS=('all-static')
# So that comparisons have less differences
# I install to non-system-specific prefixes
INSTPREFIX=/install

for SYSTEM in "${SYSTEMS[@]}"; do

  if [ "${SYSTEM}" = "mingw32" ]; then
    SYSPREFIX=/mingw32
    export MSYSTEM=MINGW32
  elif [ "${SYSTEM}" = "mingw64" ]; then
    SYSPREFIX=/mingw64
    export MSYSTEM=MINGW64
  elif [ "${SYSTEM}" = "msys2" ]; then
    SYSPATH=/usr
    export MSYSTEM=MSYS
  fi
  export PATH=${SYSPREFIX}/bin:${INPATH}
  for VARIANT in "${VARIANTS[@]}"; do
    BUILDDIR=${SYSTEM}-${VARIANT}
    [ -d "${BUILDDIR}" ] && rm -rf "${BUILDDIR}"
    mkdir "${BUILDDIR}"
    pushd "${BUILDDIR}"
      CONFIG_ARGS=()
      MAKE_ARGS=()
      if [ "${VARIANT}" = "all-static" ]; then
        # It *seems* that --enable-static=EXECUTABLE causes static libgcc to be used?!
        # AM_LDFLAGS should be set to: -Wc,--static -Wc,-static-libgcc -Wc,-static-libstdc++
        # .. but not for configure since that doesn't use libtool (-Wc,.. is libtool specific)
        CONFIG_ARGS+=('--enable-static=helloworld,libhelloworld' '--disable-shared' 'LDFLAGS=-static -static-libgcc')
        MAKE_ARGS+=('LDFLAGS=-all-static -Wc,-static-libgcc -Wc,-static-libstdc++')
      elif [ "${VARIANT}" = "static" ]; then
        CONFIG_ARGS+=('--enable-static' '--disable-shared')
      elif [ "${VARIANT}" = "shared" ]; then
        CONFIG_ARGS+=('--disable-static' '--enable-shared')
      elif [ "${VARIANT}" = "both" ]; then
        CONFIG_ARGS+=('--enable-static' '--enable-shared')
      fi
      CONFIG_ARGS+=("--prefix=${INSTPREFIX}")
      ../configure "${CONFIG_ARGS[@]}" > configure.log 2>&1
      make "${MAKE_ARGS[@]}" > make.log 2>&1
      make install DESTDIR=${PWD} > make-install.log 2>&1
    popd
  done
done
