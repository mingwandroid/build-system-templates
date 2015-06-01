#!/usr/bin/env bash

set -e

SOURCE_FILES=('./bootstrap.sh'
              './build.sh'
              './clean.sh'
              './CMakeLists.txt'
              './COPYING'
              './src/main.cpp'
              './src/helloworld.cpp'
              './src/helloworld.h')

SOURCE_DIRS=('.'
             './src')

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
