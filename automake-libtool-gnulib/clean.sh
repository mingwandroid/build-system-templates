#!/usr/bin/env bash

set -e

SOURCE_FILES=('./bootstrap.sh'
              './configure.ac'
              './Makefile.am'
              './build.sh'
              './clean.sh'
              './COPYING'
              './src/Makefile.am'
              './snippet/arg-nonnull.h'
              './snippet/c++defs.h'
              './snippet/warn-on-use.h'
              './lib/errno.in.h'
              './lib/fd-hook.c'
              './lib/fd-hook.h'
              './lib/gethostname.c'
              './lib/Makefile.am'
              './lib/msvc-inval.c'
              './lib/msvc-inval.h'
              './lib/msvc-nothrow.c'
              './lib/msvc-nothrow.h'
              './lib/sockets.c'
              './lib/sockets.h'
              './lib/stdalign.in.h'
              './lib/stddef.in.h'
              './lib/sys_socket.c'
              './lib/sys_socket.in.h'
              './lib/sys_types.in.h'
              './lib/sys_uio.in'
              './lib/unistd.c'
              './lib/unistd.in.h'
              './lib/w32sock.h'
              './m4/00gnulib.m4'
              './m4/absolute-header.m4'
              './m4/errno_h.m4'
              './m4/extern-inline.m4'
              './m4/gethostname.m4'
              './m4/gnulib-cache.m4'
              './m4/gnulib-common.m4'
              './m4/gnulib-comp.m4'
              './m4/gnulib-tool.m4'
              './m4/include_next.m4'
              './m4/msvc-inval.m4'
              './m4/msvc-nothrow.m4'
              './m4/off_t.m4'
              './m4/onceonly.m4'
              './m4/socketlib.m4'
              './m4/sockets.m4'
              './m4/socklen.m4'
              './m4/sockpfaf.m4'
              './m4/ssize_t.m4'
              './m4/stdalign.m4'
              './m4/stddef_h.m4'
              './m4/sys_socket_h.m4'
              './m4/sys_types_h.m4'
              './m4/sys_uio_h.m4'
              './m4/unistd_h.m4'
              './m4/warn-on-use.m4'
              './m4/wchar_t.m4')

SOURCE_DIRS=('.'
             './src'
             './m4'
             './lib'
             './snippet')

FILES=$(find . -type f)


for FILE in ${FILES[@]}; do
  if [[ "${SOURCE_FILES[@]}" =~ "${FILE} " || "${SOURCE_FILES[${#SOURCE_FILES[@]}-1]}" == "${FILE}" ]]; then
    echo "Found file ${FILE}"
  else
    echo "Removing file ${FILE}"
    rm -f ${FILE} || true
  fi
done

DIRS=$(find . -type d)

for DIR in ${DIRS[@]}; do
  if [[ "${SOURCE_DIRS[@]}" =~ "${DIR} " || "${SOURCE_DIRS[${#SOURCE_DIRS[@]}-1]}" == "${DIR}" ]]; then
    echo "Found dir ${DIR}"
  else
    echo "Removing dir ${DIR}"
    rm -rf ${DIR} || true
  fi
done

# Copy the shared sources, unfortunate, but the alternatives are either
# unshared sources for each build system or putting automake stuff into
# the shared sources folder. Neither of which I want to do.
cp -rf ../src/* src
