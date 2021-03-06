#MMI-PPB29.73-81 For Moto E(6) Play

#Kernel Modules:
#---------------
#Download prebuilts folder from Android distribution. Move it to $my_top_dir

#For example:

#! /bin/bash

my_tip_dir=$(pwd)

git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-eabi-4.8

mkdir -p  $my_top_dir/prebuilts/gcc/linux-x86/arm

mv arm-eabi-4.8 $my_top_dir/prebuilts/gcc/linux-x86/arm/.

git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9

mkdir -p  $my_top_dir/prebuilts/gcc/linux-x86/arm

mv arm-linux-androideabi-4.9 $my_top_dir/prebuilts/gcc/linux-x86/arm/.

mkdir -p $my_top_dir/out/target/product/generic/obj/kernel/msm-4.9

kernel_out_dir=$my_top_dir/out/target/product/generic/obj/kernel/msm-4.9

bcross=$my_top_dir/prebuilts/gcc/linux-x86/arm/arm-eabi-4.8/bin/arm-eabi-

dcross=$my_top_dir/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9/bin/arm-linux-androidkernel- 

( perl -le 'print \"# This file was automatically generated from:\n#\t\" . join(\"\n#\t\", @ARGV) . \"\n\"' kernel/msm-4.9/arch/arm/configs/msm8937-perf_defconfig kernel/msm-4.9/arch/arm/configs/ext_config/moto-msm8937.config kernel/msm-4.9/arch/arm/configs/ext_config/moto-msm8937_32.config kernel/msm-4.9/arch/arm/configs/ext_config/moto-msm8937-surfna.config && cat kernel/msm-4.9/arch/arm/configs/msm8937-perf_defconfig kernel/msm-4.9/arch/arm/configs/ext_config/moto-msm8937.config kernel/msm-4.9/arch/arm/configs/ext_config/moto-msm8937_32.config kernel/msm-4.9/arch/arm/configs/ext_config/moto-msm8937-surfna.config ) > $kernel_out_dir/mapphone_defconfig || ( rm -f $kernel_out_dir/mapphone_defconfig && false )

cp $kernel_out_dir/mapphone_defconfig $kernel_out_dir/.config 

make -j8 -C kernel/msm-4.9 O=$kernel_out_dir DTC_EXT=dtc CONFIG_BUILD_ARM64_DT_OVERLAY=y ARCH=arm CROSS_COMPILE=$dcross defoldconfig

make -j8 -C kernel/msm-4.9 O=$kernel_out_dir DTC_EXT=dtc CONFIG_BUILD_ARM64_DT_OVERLAY=y ARCH=arm CROSS_COMPILE=$dcross oldconfig

make -j8 -C kernel/msm-4.9 O=$kernel_out_dir DTC_EXT=dtc CONFIG_BUILD_ARM64_DT_OVERLAY=y ARCH=arm CROSS_COMPILE=$dcross headers_install

make -j8 -C kernel/msm-4.9 O=$kernel_out_dir DTC_EXT=dtc CONFIG_BUILD_ARM64_DT_OVERLAY=y ARCH=arm CROSS_COMPILE=$dcross KCFLAGS=-mno-android

make -j8 -C kernel/msm-4.9 O=$kernel_out_dir DTC_EXT=dtc CONFIG_BUILD_ARM64_DT_OVERLAY=y ARCH=arm CROSS_COMPILE=$dcross KCFLAGS=-mno-android modules

make -j8 -C kernel/msm-4.9 O=$kernel_out_dir INSTALL_MOD_PATH=$my_top_dir/out/target/product/generic INSTALL_MOD_STRIP=1 DTC_EXT=dtc CONFIG_BUILD_ARM64_DT_OVERLAY=y ARCH=arm CROSS_COMPILE=$dcross modules_install

make -C kernel/msm-4.9 O=$kernel_out_dir ARCH=arm CROSS_COMPILE=$bcross clean

make -C kernel/msm-4.9 O=$kernel_out_dir ARCH=arm CROSS_COMPILE=$bcross mrproper

make -C kernel/msm-4.9 O=$kernel_out_dir ARCH=arm CROSS_COMPILE=$bcross distclean

make -j8 -C kernel/msm-4.9 O=$kernel_out_dir DTC_EXT=dtc CONFIG_BUILD_ARM64_DT_OVERLAY=y ARCH=arm CROSS_COMPILE=$dcross tags

env KCONFIG_NOTIMESTAMP=true make -j8 -C kernel/msm-4.9 O=$kernel_out_dir DTC_EXT=dtc CONFIG_BUILD_ARM64_DT_OVERLAY=y ARCH=arm CROSS_COMPILE=$dcross menuconfig

env KCONFIG_NOTIMESTAMP=true make -j8 -C kernel/msm-4.9 O=$kernel_out_dir DTC_EXT=dtc CONFIG_BUILD_ARM64_DT_OVERLAY=y ARCH=arm CROSS_COMPILE=$dcross savedefconfig

#WLAN Driver:
#------------
 
cd $PWD/out/target/product/generic/obj
make -j8 -C kernel/msm-4.9 M=$my_top_dir/vendor/qcom/opensource/wlan/prima O=$kernel_out_dir ARCH=arm CROSS_COMPILE=$dcross KCFLAGS=-mno-android modules WLAN_PROPRIETARY=0 TARGET_SUPPORTS_WEARABLES= KERNEL_TO_BUILD_ROOT_OFFSET=$my_top_dir/ MODNAME=wlan BOARD_PLATFORM=msm8937 CONFIG_PRONTO_WLAN=m
