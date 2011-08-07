#!/bin/sh -e
export A=$(uname -m)
export R=$(pwd)/out/
export S=$(pwd)/out/$A-unknown-linux-musl/
export CFLAGS="-Os"
export LDFLAGS="-s"
export CC=gcc
export PATH=$(pwd)/out/bin${PATH:+:}$PATH

rm -rf $R
mkdir -p $R
ln -s . $R/usr

./musl-headers.build.sh
./binutils.build.sh
./gcc.build.sh
export CC=$A-unknown-linux-musl-gcc
./musl.build.sh
