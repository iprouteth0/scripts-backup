#!/bin/bash

## GZOSP
## https://github.com/GZOSP/manifest.git -b 11.0
export ROMNAME=gzosp
export ROMGIT="https://github.com/GZOSP/manifest.git -b 11.0"
export SOURCEFILE=Android.bp
#export BUILDCOMMAND="brunch ${ROMNAME}_ginna-eng"
#export BUILDCOMMAND="lunch ${ROMNAME}_ginna-eng : make ${ROMNAME} -j$(nproc --all)"
#export BUILDCOMMAND="lunch ${ROMNAME}_ginna-eng && make bacon -j${nproc --all}"
clear
echo ""
echo ""
echo ""
echo ""
echo ""
make clean



if [[ ! -f "$SOURCEFILE" ]]
then 
repo init -u $ROMGIT
repo sync -j$(nproc --ignore=8)
. ginna-clone_sources.sh
echo "SYNC OF ROM AND DEVICE SOURCES COMPLETED!"
echo "Matching device source to ROM.  Beginning file alterations"
sed -i "s|vendor/lineage/config|vendor/$ROMNAME/config|" device/motorola/ginna/lineage_ginna.mk
#sed -i "s|common_full_phone.mk|common.mk|" device/motorola/ginna/lineage_ginna.mk
sed -i 's/BUILD_GMS/#BUILD_GMS/' device/motorola/ginna/lineage_ginna.mk
sed -i 's|$(call inherit-product, vendor/partner_gms/products/gms_go_2gb.mk)|#$(call inherit-product, vendor/partner_gms/products/gms_go_2gb.mk)|' device/motorola/ginna/lineage_ginna.mk
sed -i "s|lineage_ginna|$ROMNAME\_ginna|" device/motorola/ginna/lineage_ginna.mk
sed -i "s|lineage_|$ROMNAME\_|" device/motorola/ginna/AndroidProducts.mk
cp device/motorola/ginna/lineage.dependencies device/motorola/ginna/$ROMNAME.dependencies
cp device/motorola/ginna/lineage_ginna.mk device/motorola/ginna/$ROMNAME\_ginna.mk
rm -rf vendor/qcom/opensource/power
git clone https://github.com/ArrowOS/android_vendor_qcom_opensource_power vendor/qcom/opensource/power
rm -rf hardware/qcom-caf/wlan
git clone https://github.com/Project-Awaken/android_hardware_qcom_wlan -b 11 hardware/qcom-caf/wlan
cp device/qcom/sepolicy-legacy-um/sepolicy.mk device/qcom/sepolicy-legacy-um/SEPolicy.mk
cat ~/scripts-backup/device_mk_changes.txt >> device/motorola/ginna/device.mk
git clone https://github.com/LineageOS/android_packages_resources_devicesettings packages/resources/devicesettings
rm -rf device/qcom/sepolicy-legacy-um
git clone https://github.com/ArrowOS/android_device_qcom_sepolicy-legacy-um device/qcom/sepolicy-legacy-um
sleep 2
echo ""
echo ""
echo ""
echo "Beginning build proccess..."
sleep 1
echo ""
echo "..."
sleep 1
## Build Section after sources downloaded and fixed
export USE_CCACHE=1
export LC_ALL=C
#export BUILD_BROKEN_DUP_RULES=true
#export SKIP_ABI_CHECKS=true
#export SELINUX_IGNORE_NEVERALLOWS=true
export WITHOUT_CHECK_API=true
TARGET_BOOT_ANIMATION_RES=1080
export TARGET_BOOT_ANIMATION_RES
. build/envsetup.sh
export ROMNAME=gzosp
#eval $($BUILDCOMMAND | tee /dev/tty)
lunch $ROMNAME\_ginna-eng
time make gzosp -j$(nproc --ignore=4)
echo ""
echo " Rom Should Be Built"
echo ""
echo " ENTER TO CONTINUE"
echo ""
## Build section that runs if source already downloaded
else
export USE_CCACHE=1
export LC_ALL=C
#export BUILD_BROKEN_DUP_RULES=true
#export SKIP_ABI_CHECKS=true
#export SELINUX_IGNORE_NEVERALLOWS=true
export WITHOUT_CHECK_API=true
TARGET_BOOT_ANIMATION_RES=1080
export TARGET_BOOT_ANIMATION_RES
source build/envsetup.sh
export ROMNAME=gzosp
#eval $($BUILDCOMMAND | tee /dev/tty)
lunch $ROMNAME\_ginna-eng
time make gzosp -j$(nproc --ignore=6)
echo ""
echo " Rom Should Be Built"
echo ""
echo " ENTER TO CONTINUE"
echo ""
fi
