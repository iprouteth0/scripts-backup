#!/bin/bash

## LegionOS
## https://github.com/Project-LegionOS/manifest.git -b 11
export ROMNAME=legion
export ROMGIT="https://github.com/Project-LegionOS/manifest.git -b 11"
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
cat ~/scripts-backup/device_mk_changes.txt >> device/motorola/ginna/device.mk
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
export WITHOUT_CHECK_API=true
TARGET_BOOT_ANIMATION_RES=1080
export TARGET_BOOT_ANIMATION_RES
. build/envsetup.sh
export ROMNAME=legion
#eval $($BUILDCOMMAND | tee /dev/tty)
lunch $ROMNAME\_ginna-eng
make $ROMNAME -j$(nproc --ignore=6)
echo ""
echo " Rom Should Be Built"
echo ""
echo " ENTER TO CONTINUE"
echo ""
## Build section that runs if source already downloaded
else
export USE_CCACHE=1
export LC_ALL=C
export WITHOUT_CHECK_API=true
TARGET_BOOT_ANIMATION_RES=1080
export TARGET_BOOT_ANIMATION_RES
source build/envsetup.sh
export ROMNAME=legion
#eval $($BUILDCOMMAND | tee /dev/tty)
lunch $ROMNAME\_ginna-eng
make $ROMNAME -j$(nproc --ignore=6)
echo ""
echo " Rom Should Be Built"
echo ""
echo " ENTER TO CONTINUE"
echo ""
fi
