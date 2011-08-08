#!/bin/sh -e
VER=3.0

if [ "$(printf "%s" "$A" | sed 's/i[3456]86//')" = "" ];then
    export ARCH=i386
else
    export ARCH="$A"
fi

test -e linux-$VER.tar.bz2 || wget -c http://www.kernel.org/pub/linux/kernel/v3.0/linux-$VER.tar.bz2
rm -rf linux-$VER;tar -xf linux-$VER.tar.bz2
cd linux-$VER

patch -p1 <../linux-noperl-headers.patch

make allnoconfig HOSTCFLAGS="-D_GNU_SOURCE" ARCH=$ARCH

make HOSTCFLAGS=-D_GNU_SOURCE INSTALL_HDR_PATH=dest headers_install ARCH=$ARCH
find dest/include \( -name .install -o -name ..install.cmd \) -delete
mkdir -p $S/include/
cp -rv dest/include/* $S/include/

cd ..
rm -rf linux-$VER
