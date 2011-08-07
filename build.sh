#!/bin/sh -e
export A=${A:-$(uname -m)}
export R=${R:-$(pwd)/out/}
export S=${S:-$R/$A-unknown-linux-musl/}
export CFLAGS="-Os"
export LDFLAGS="-s"
export CC=${CC:-gcc}
export PATH=$R/bin${PATH:+:}$PATH

rm -rf $R
mkdir -p $R
ln -s . $R/usr

./musl-headers.build.sh
./binutils.build.sh
./gcc.build.sh
export CC=$A-unknown-linux-musl-gcc
./musl.build.sh
