#!/bin/bash

echo "Hi lancelot user just wait and watch "

mkdir out
export ARCH=arm64
export SUBARCH=arm64
export DTC_EXT=dtc
make O=out ARCH=arm64 lancelot_defconfig
export PATH="${PWD}/root/mt6768-redmi-9-lancelot-kernel/proton-clang/:${PATH}"
make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      LD=${PWD}/proton-clang/bin/ld.lld \
		       OBJCOPY=${PWD}/proton-clang/bin/llvm-objcopy \
		       AS=${PWD}/proton-clang/bin/llvm-as \
		       NM=${PWD}/proton-clang/bin/llvm-nm \
		       STRIP=${PWD}/proton-clang/bin/llvm-strip \
		       OBJDUMP=${PWD}/proton-clang/bin/llvm-objdump \
		       READELF=${PWD}/proton-clang/bin/llvm-readelf \
                      CC=${PWD}/proton-clang/bin/clang \
                      CROSS_COMPILE=${PWD}/proton-clang/bin/aarch64-linux-gnu- \
                      CROSS_COMPILE_ARM32=${PWD}/proton-clang/bin/arm-linux-gnueabi- 
bp=${PWD}/out
DATE=$(date "+%Y%m%d-%H%M")
ZIPNAME="Shas-Dream-Lancelot-R-vendor"
cd ${PWD}/AnyKernel3
rm *.zip *-dtb 
cp $bp/arch/arm64/boot/Image.gz-dtb .
zip -r9 "$ZIPNAME"-"${DATE}".zip *
cd - || exit