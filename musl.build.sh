#!/bin/sh -e
VER=0.7.12
test -e musl-$VER.tar.gz || wget http://www.etalabs.net/musl/releases/musl-$VER.tar.gz
rm -rf musl-$VER;tar -xf musl-$VER.tar.gz
cd musl-$VER
cat >config.mak <<EOF
ARCH = $A
prefix = $S
exec_prefix = $R
syslibdir = $S/lib/
CROSS_COMPILE=$A-unknown-linux-musl-
EOF
make
make install
cd ..
rm -rf musl-$VER