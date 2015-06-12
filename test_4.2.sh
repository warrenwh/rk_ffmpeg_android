#!/bin/sh

######################################################

# FFmpeg builds script for Android+ARM

######################################################
NDK=../../../android-ndk-r5

PLATFORM=$NDK/platforms/android-9/arch-arm

PREBUILT=$PWD/../../prebuilt/linux-x86/toolchain/arm-eabi-4.4.3

CPU=armv7-a

OPTIMIZE_CFLAGS="-mfloat-abi=softfp -mfpu=neon -marm -march=$CPU -mtune=cortex-a9"

PREFIX=./android/$CPU

EXTERN_SSL=$PWD/../../external/openssl/include


EXTREN_SSL_LIB=$PWD/../../out/target/product/rk30sdk/obj/lib

./configure --target-os=linux  \
						--prefix=$PREFIX \
						--enable-cross-compile \
						--extra-libs="-lgcc" \
						--arch=arm \
						--cc=$PREBUILT/bin/arm-eabi-gcc \
						--cross-prefix=$PREBUILT/bin/arm-eabi- \
						--nm=$PREBUILT/bin/arm-eabi-nm \
						--sysroot=$PLATFORM \
						--extra-cflags="-I$PREFIX/include -I$EXTERN_SSL -O3 -fpic -DANDROID -DHAVE_SYS_UIO_H=1 -Dipv6mr_interface=ipv6mr_ifindex -fasm -Wno-psabi -fno-short-enums  -fno-strict-aliasing -finline-limit=300 $OPTIMIZE_CFLAGS " \
						--disable-shared \
						--disable-debug \
						--enable-static \
						--extra-ldflags="-Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -L$PREFIX/lib -L$EXTREN_SSL_LIB -nostdlib -lc -lm -ldl -llog -lssl -lcrypto" \
						--enable-gpl \
						--enable-nonfree \
						--enable-parsers \
						--disable-encoders \
						--enable-decoders \
						--disable-muxers \
						--enable-demuxers \
						--disable-swscale  \
						--disable-swscale-alpha \
						--disable-ffmpeg \
						--disable-ffplay \
						--disable-ffprobe \
						--disable-ffserver \
						--enable-network  \
						--disable-indevs \
						--disable-bsfs \
						--disable-filters \
						--disable-avfilter \
						--enable-openssl \
						--enable-protocols \
						--enable-asm \
						--enable-neon \
						--disable-decoder=truehd 						
#make clean

make  -j64 install

#Binutils supports 2 linkers, ld.gold and ld.bfd.  One of them is
#configured as the default linker, ld, which is used by GCC.  Sometimes,
#we want to use the alternate linker with GCC at run-time.  This patch
#adds -fuse-ld=bfd and -fuse-ld=gold options to GCC driver.  It changes
#collect2.c to pick either ld.bfd or ld.gold.

$PREBUILT/bin/arm-eabi-ar d libavcodec/libavcodec.a inverse.o

$PREBUILT/bin/arm-eabi-ld -rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib  -soname libffmpeg.so -shared -nostdlib  -z,noexecstack -Bsymbolic --whole-archive --no-undefined -o $PREFIX/libffmpeg.so libavcodec/libavcodec.a libavformat/libavformat.a libavutil/libavutil.a libswresample/libswresample.a libavdevice/libavdevice.a $EXTREN_SSL_LIB/libssl.so $EXTREN_SSL_LIB/libcrypto.so -lc -lm -lz -ldl -llog --warn-once  --dynamic-linker=/system/bin/linker $PREBUILT/lib/gcc/arm-eabi/4.4.3/libgcc.a


