#!/usr/bin/env bash

./clean.sh
./bootstrap.sh > bootstrap.log 2>&1

INPATH=${PATH}
SYSTEMS=('mingw32' 'mingw64' 'msys2')
VARIANTS=('static' 'shared' 'both')
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
      if [ "${VARIANT}" = "static" ]; then
        CONFIG_ARGS+=('-DBUILD_SHARED_LIBS=OFF' '-DBUILD_STATIC_LIBS=ON')
      elif [ "${VARIANT}" = "shared" ]; then
        CONFIG_ARGS+=('-DBUILD_SHARED_LIBS=ON' '-DBUILD_STATIC_LIBS=OFF')
      elif [ "${VARIANT}" = "both" ]; then
        CONFIG_ARGS+=('-DBUILD_SHARED_LIBS=ON' '-DBUILD_STATIC_LIBS=ON')
      fi
      CONFIG_ARGS+=("-DCMAKE_INSTALL_PREFIX=${INSTPREFIX}")
      cmake -G'MSYS Makefiles' "${CONFIG_ARGS[@]}" ../ > configure.log 2>&1
      make > make.log 2>&1
      make install DESTDIR=${PWD} > make-install.log 2>&1
    popd
  done
done
