#! /bin/bash
## Build script variables to set
## Freaky OS
ROMGIT="https://github.com/FreakyOS/manifest"
SOURCEFILE=Android.bp
ROMNAME=freaky
ROMBUILD=bacon
VENDOR_CONFIG=$ROMNAME

## Check if sources are present and download if not present
if [[ ! -f $SOURCEFILE ]] 
then 
repo init -u $ROMGIT 
repo sync -j$(nproc --ignore=8)
. olivewood-clone_sources.sh 

## match device tree files to rom tree
cp device/xiaomi/olivewood/lineage_olivewood.mk device/xiaomi/olivewood/$ROMNAME\_olivewood.mk
sed -i "s|vendor/lineage/config|vendor/$VENDOR_CONFIG/config|" device/xiaomi/olivewood/$ROMNAME\_olivewood.mk
sed -i "s|lineage|$ROMNAME|" device/xiaomi/olivewood/$ROMNAME\_olivewood.mk
sed -i "s|lineage|$ROMNAME|" device/xiaomi/olivewood/AndroidProducts.mk
cat ~/scripts-backup/device_mk_changes-msm8937.txt >> device/xiaomi/olivewood/device.mk
#echo "WITH_GAPPS := true" >> device/xiaomi/olivewood/$ROMNAME\_olivewood.mk

## Build section sequence A
. build/envsetup.sh
make clobber
export USE_CCACHE=1
export LC_ALL=C
export WITHOUT_CHECK_API=true
#time brunch olivewood
lunch $ROMNAME\_olivewood-eng 
make $ROMBUILD -j$(nproc --ignore=8)

## Build section sequence B
else
. build/envsetup.sh
make clobber
export USE_CCACHE=1
export LC_ALL=C
export WITH_CHECK_API=true
#time brunch olivewood
lunch $ROMNAME\_olivewood-eng
make $ROMBUILD -j$(nproc --ignore=8)
fi
