#! /bin/bash

git clone https://github.com/motoe7/android_device_motorola_ginna.git -b lineage-18.1 device/motorola/ginna &&
git clone https://github.com/motoe7/android_vendor_motorola_ginna.git -b lineage-18.1 vendor/motorola/ginna &&
git clone https://github.com/motoe7/android_kernel_motorola_sdm632.git -b lineage-18.1 kernel/motorola/sdm632
LIBQSAP_SDK="system/qcom/softap"
if [[ ! -d $LIBQSAP_SDK ]]
then 
git clone https://github.com/LineageOS/android_system_qcom.git -b lineage-18.1 system/qcom
else
echo "libqsap_sdk already present"
fi
