#!/bin/bash
clear
export ARCH=arm64
export PLATFORM_VERSION=12
export ANDROID_MAJOR_VERSION=s
ln -s /usr/bin/python2.7 $HOME/python
export PATH=$HOME/:$PATH
mkdir out

ARGS='
CC=/home/hausemaster/Toolchains_for_Snapdragon/llvm-arm-toolchain-ship-10.0/bin/clang
CROSS_COMPILE=/home/hausemaster/Toolchains_for_Snapdragon/aarch64-linux-android-4.9/bin/aarch64-linux-android-
CLANG_TRIPLE=aarch64-linux-gnu-
ARCH=arm64
'
make -C $(pwd) O=$(pwd)/out ${ARGS} clean && make -C $(pwd) O=$(pwd)/out ${ARGS} mrproper #to clean the source
make -C $(pwd) O=$(pwd)/out ${ARGS} gta4l_eur_open_defconfig #making your current kernel config
make -C $(pwd) O=$(pwd)/out ${ARGS} menuconfig #editing the kernel config via gui
make -C $(pwd) O=$(pwd)/out ${ARGS} -j$(nproc) #to compile the kernel

#to copy all the kernel modules (.ko) to "modules" folder.
mkdir -p modules
find . -type f -name "*.ko" -exec cp -n {} modules \;
echo "Module files copied to the 'modules' folder."
