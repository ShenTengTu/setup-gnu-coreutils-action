#!/bin/bash

cd "$GITHUB_WORKSPACE/gnu-coreutils" || exit $?

git submodule init
git submodule update

echo "Get and check other files needed to build."
./bootstrap --skip-po || exit $?

prefix=$HOME/gnu-coreutils

echo "Configure the package."
./configure CFLAGS="-m64 -Wno-type-limits" LDFLAGs="-m64" \
--prefix="$prefix" \
--enable-single-binary \
--quiet

echo "Compile coreutils"
make -j"$(nproc)"

echo "Install coreutils into $prefix"
make -j"$(nproc)" install

echo "$prefix/bin" >>$GITHUB_PATH

