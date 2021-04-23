#!/bin/bash

## Pixel Experience
## https://github.com/PixelExperience/manifest -b eleven
export ROMNAME=aosp
export ROMGIT="https://github.com/PixelExperience/manifest -b eleven"
export SOURCEFILE=Android.bp
#export BUILDCOMMAND="brunch ${ROMNAME}_ginna-eng"
#export BUILDCOMMAND="lunch ${ROMNAME}_ginna-eng && make ${ROMNAME} -j$(nproc --all)"
export BUILDCOMMAND="lunch ${ROMNAME}_ginna-eng && make bacon -j${nproc --all}"
#export ROMNAME
#export ROMGIT
clear
echo ""
echo ""
echo ""
echo ""
echo ""
make clean

#echo "Sync sources?  1 for yes or 0 for no."
#read sync
if [[ ! -f "$SOURCEFILE" ]]
then 
repo init -u $ROMGIT
repo sync -j$(nproc --all)
#cp local_manifests.xml .repo/local_manifests/
#repo sync -j$(nproc --all)
. ginna-clone_sources.sh
echo "SYNC OF ROM AND DEVICE SOURCES COMPLETED!"
#
#echo "Press enter to continue with device tree corrections"
#read
sed -i "s|vendor/lineage/config|vendor/$ROMNAME/config|" device/motorola/ginna/lineage_ginna.mk
sed -i 's/BUILD_GMS/#BUILD_GMS/' device/motorola/ginna/lineage_ginna.mk
sed -i 's|$(call inherit-product, vendor/partner_gms/products/gms_go_2gb.mk)|#$(call inherit-product, vendor/partner_gms/products/gms_go_2gb.mk)|' device/motorola/ginna/lineage_ginna.mk
sed -i "s|lineage_ginna|$ROMNAME\_ginna|" device/motorola/ginna/lineage_ginna.mk
sed -i "s|lineage_|$ROMNAME\_|" device/motorola/ginna/AndroidProducts.mk
cp device/motorola/ginna/lineage.dependencies device/motorola/ginna/$ROMNAME.dependencies
cp device/motorola/ginna/lineage_ginna.mk device/motorola/ginna/$ROMNAME\_ginna.mk
#echo "Development pause.  Enter to continue"
#read
sleep 2
echo ""
echo ""
echo ""
echo "Beginning build proccess..."
sleep 1
echo ""
echo "..."
sleep 1
#else

export USE_CCACHE=1
export LC_ALL=C
export WITHOUT_CHECK_API=true
TARGET_BOOT_ANIMATION_RES=1080
export TARGET_BOOT_ANIMATION_RES
. build/envsetup.sh
eval $($BUILDCOMMAND | tee /dev/tty)
#lunch $ROMNAME_ginna-eng
#make bacon -j$(nproc --all)
echo
echo " Rom Should Be Built"
echo ""
echo " ENTER TO CONTINUE"
echo ""
#mv $OUT/Xtended-XR-v4.0-ginna-XPLOITED*.zip ~/Android/Uploads/Roms/Android-11
#mv $OUT/Xtended-XR-v4.0-ginna-XPLOITED*.md5sum ~/Android/Uploads/Roms/Android-11
#cd ~/Android/Roms/AICP/11.0
#make clean

#sleep 5
else
export USE_CCACHE=1
export LC_ALL=C
export WITHOUT_CHECK_API=true
TARGET_BOOT_ANIMATION_RES=1080
export TARGET_BOOT_ANIMATION_RES
source build/envsetup.sh
eval $($BUILDCOMMAND | tee /dev/tty)
#brunch $ROMNAME\_ginna-eng
#lunch $ROMNAME_ginna-eng
#make bacon -j$(nproc --all)
echo
echo " Rom Should Be Built"
echo ""
echo " ENTER TO CONTINUE"
echo ""
#mv $OUT/Xtended-XR-v4.0-ginna-XPLOITED*.zip ~/Android/Uploads/Roms/And>#mv $OUT/Xtended-XR-v4.0-ginna-XPLOITED*.md5sum ~/Android/Uploads/Roms/>#cd ~/Android/Roms/AICP/11.0
#make clean
fi
