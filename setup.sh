#!/bin/bash

cd "$GITHUB_WORKSPACE/gnu-coreutils" || exit $?

git submodule init
git submodule update

echo "Get and check other files needed to build."
./bootstrap

prefix=$HOME/gnu-coreutils

echo "Configure the package."
./configure CFLAGS="-m64 -Wno-type-limits" LDFLAGs="-m64" \
--prefix="$prefix" \
--enable-single-binary \
--quiet

echo "Compile coreutils then self-test."
make -j8
make -j8 check

echo "Install coreutils into $prefix, then self-test using the binaries."
make -j8 install
make -j8 installcheck

echo "$prefix/bin" >>$GITHUB_PATH

