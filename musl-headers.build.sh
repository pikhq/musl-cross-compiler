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
exec_prefix = $S
syslibdir = $S/lib/
EOF
ln -sf ../arch/$ARCH/bits include/bits
sh include/bits/alltypes.h.sh >include/bits/alltypes.h
for i in include/*.h include/*/*.h;do
    make $S/$i
done
cd ..
rm -rf musl-$VER