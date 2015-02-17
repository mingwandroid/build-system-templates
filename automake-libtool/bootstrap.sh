#!/usr/bin/env bash

set -e

libtoolize
aclocal
autoconf

touch AUTHORS NEWS README ChangeLog

automake --add-missing
