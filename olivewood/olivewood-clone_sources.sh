#! /bin/bash


## Device Tree
git clone https://github.com/iprouteth0/device_xiaomi_olivewood-1 device/xiaomi/olivewood
git clone https://github.com/Xiaomi-SDM439-Development/android_device_xiaomi_sdm439 device/xiaomi/sdm439-common

## Vendor Tree
git clone https://github.com/Evolution-X-Devices/vendor_xiaomi vendor/xiaomi
git clone https://github.com/iprouteth0/vendor_xiaomi_olivewood_64 vendor/xiaomi/olivewood

git clone https://github.com/Stargazer19/hardware_qcom_display-caf-msm8937 hardware/qcom-caf/msm8937/display
git clone https://github.com/Stargazer19/hardware_qcom_media-caf-msm8937 hardware/qcom-caf/msm8937/media
git clone https://github.com/Stargazer19/hardware_qcom_audio-caf-msm8937 hardware/qcom-caf/msm8937/audio
cp hardware/qcom-caf/msm8996/Android.* hardware/qcom-caf/msm8937/
cat ~/scripts-backup/device_mk_changes-msm8937.txt >> device/xiaomi/olivewood/device.mk


echo "TARGET_KERNEL_CLANG_COMPILE := true" >> device/xiaomi/olivewood/BoardConfig.mk
## Kernel Sources:  
##  For second kernel source link, add the following;
##
##  Add this to BoardConfig.mk or BoardConfigCommon.mk:
##
##  TARGET_KERNEL_CLANG_COMPILE := true
#git clone https://github.com/MiCode/Xiaomi_Kernel_OpenSource/tree/olivewood-p-oss -b olivewood-p-oss kernel/xiaomi/sdm439
git clone https://github.com/Xiaomi-SDM439-Development/android_kernel_xiaomi_sdm439 kernel/xiaomi/sdm439
