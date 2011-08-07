#!/bin/sh -e
VER=2.21.1
test -e binutils-$VER.tar.bz2 || wget http://ftp.gnu.org/gnu/binutils/binutils-$VER.tar.bz2
rm -rf binutils-$VER;tar -xf binutils-$VER.tar.bz2
cd binutils-$VER

sed -i 's/linux-gnu\* |/linux-gnu* | linux-musl* |/' config.sub
# echo "#define __pid_t int" >include/features.h

./configure --target=$A-unknown-linux-musl --disable-shared --disable-nls --prefix=$R --with-sysroot=$S
make all-binutils all-ld all-gas
make install-binutils install-ld install-gas

cd ..
rm -rf binutils-$VER
