#!/bin/bash
cd "$GITHUB_WORKSPACE" || exit $?
echo "Clone GNU coreutils."
git clone git://git.sv.gnu.org/coreutils gnu-coreutils

repo="$GITHUB_WORKSPACE/gnu-coreutils"

cd "$repo" || exit $?
echo "Initialize submodule."
git submodule init
git submodule update

echo "Get and check other files needed to build."
./bootstrap --skip-po --no-git --gnulib-srcdir="$repo/gnulib" >/dev/null || exit $?

prefix=$HOME/gnu-coreutils

echo "Configure the package."
./configure CFLAGS="-m64 -Wno-type-limits" LDFLAGs="-m64" \
--prefix="$prefix" \
--enable-silent-rules \
--disable-dependency-tracking \
--enable-single-binary \
--disable-nls \
--quiet

echo "Compile coreutils"
make -j"$(nproc)"

echo "Install coreutils into $prefix"
make -j"$(nproc)" install

echo "$prefix/bin" >>$GITHUB_PATH

