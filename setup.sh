#!/bin/bash
cd "$GITHUB_WORKSPACE" || exit $?

echo "::group::Get GNU coreutils repository"

echo "Clone GNU coreutils."
git clone git://git.sv.gnu.org/coreutils gnu-coreutils

repo="$GITHUB_WORKSPACE/gnu-coreutils"

cd "$repo" || exit $?
echo "Initialize submodule."
git submodule init
git submodule update

echo "::endgroup::"

echo "::group::Setup GNU coreutils (bootstrap)"

echo "Get and check other files needed to build."
./bootstrap --skip-po --no-git --gnulib-srcdir="$repo/gnulib" || exit $?

echo "::endgroup::"

prefix=$HOME/gnu-coreutils

echo "::group::Setup GNU coreutils (configure)"

echo "Configure the package."
./configure CFLAGS="-m64 -Wno-type-limits" LDFLAGs="-m64" \
--prefix="$prefix" \
--enable-silent-rules \
--disable-dependency-tracking \
--enable-single-binary \
--disable-nls \
--quiet

echo "::endgroup::"

echo "::group::Setup GNU coreutils (compile)"

echo "Compile coreutils"
make -j"$(nproc)"

echo "::endgroup::"

echo "::group::Setup GNU coreutils (install)"

echo "Install coreutils into $prefix"
make -j"$(nproc)" install

echo "$prefix/bin" >>$GITHUB_PATH

echo "::endgroup::"
