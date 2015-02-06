#!/usr/bin/env bash

set -e

aclocal
autoconf

touch AUTHORS NEWS README ChangeLog

automake --add-missing
