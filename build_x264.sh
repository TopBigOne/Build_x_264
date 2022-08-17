#!/bin/bash

ARCH=$1
#目标平台版本,我们将兼容到android-21
API=21


source config.sh $ARCH
LIBS_DIR=$(cd `dirname $0`; pwd)/build_result_libx264
echo "LIBS_DIR="$LIBS_DIR

#echo "ANDROID_NDK_ROOT="$ANDROID_NDK_ROOT

cd x264

PREFIX=$LIBS_DIR/$AOSP_ABI
TOOLCHAIN=$ANDROID_NDK_ROOT/toolchains/llvm/prebuilt/darwin-x86_64
SYSROOT=${TOOLCHAIN}/sysroot
CROSS_PREFIX=$TOOLCHAIN/bin/$TOOLNAME_BASE-


#根据不同架构配置环境变量
case "$THE_ARCH" in
  armv7a|armeabi-v7a)
    export CC=${TOOLCHAIN}/bin/armv7a-linux-androideabi$API-clang
    export CXX=$TOOLCHAIN/bin/armv7a-linux-androideabi$API-clang++
    ;;
  armv8|armv8a|aarch64|arm64|arm64-v8a)
    export CC=${TOOLCHAIN}/bin/aarch64-linux-android$API-clang
    export CXX=$TOOLCHAIN/bin/aarch64-linux-android$API-clang++
    ;;
  x86)
    export CC=${TOOLCHAIN}/bin/i686-linux-android$API-clang
    export CXX=$TOOLCHAIN/bin/i686-linux-android$API-clang++
    ;;
  x86_64|x64)
    export CC=${TOOLCHAIN}/bin/x86_64-linux-android$API-clang
    export CXX=$TOOLCHAIN/bin/x86_64-linux-android$API-clang++
    ;;
  *)
    echo "ERROR: Unknown architecture $1"
    [ "$0" = "$BASH_SOURCE" ] && exit 1 || return 1
    ;;
esac

# echo "TOOLCHAIN="$TOOLCHAIN


# echo "CC="$CC
# echo "CXX="$CXX

./configure --prefix=$PREFIX \
--enable-shared \
--enable-pic \
--disable-cli \
--host=$HOST \
--cross-prefix=${TOOLCHAIN}/bin/arm-linux-androideabi- \
--sysroot=$SYSROOT \
--extra-cflags="-Os -fpic" \
--extra-ldflags=""

make clean
make -j4
make install

cd ..
