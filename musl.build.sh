#!/bin/sh -e
VER=0.7.12

if [ "$(printf "%s" "$A" | sed 's/i[3456]86//')" = "" ];then
    export ARCH=i386
else
    export ARCH="$A"
fi

test -e musl-$VER.tar.gz || wget http://www.etalabs.net/musl/releases/musl-$VER.tar.gz
rm -rf musl-$VER;tar -xf musl-$VER.tar.gz
cd musl-$VER
cat >config.mak <<EOF
prefix = $S
exec_prefix = $R
syslibdir = $S/lib/
CROSS_COMPILE=$A-unknown-linux-musl-
EOF
make
make install
cd ..
rm -rf musl-$VER