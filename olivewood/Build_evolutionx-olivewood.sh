#! /bin/bash

## Evolution X
ROMGIT="https://github.com/Evolution-X/manifest" 
SOURCEFILE=Android.bp
export ROMNAME=evolution

if [[ ! -f $SOURCEFILE ]] 
then 
repo init -u $ROMGIT 
repo sync -j$(nproc --ignore=8)
. olivewood-clone_sources.sh 
## make changes to match device tree to rom
sed -i "s|lineage|$ROMNAME|" device/xiaomi/olivewood/AndroidProducts.mk
cp device/xiaomi/olivewood/lineage_olivewood.mk device/xiaomi/olivewood/$ROMNAME\_olivewood.mk
sed -i "s|lineage|$ROMNAME|" device/xiaomi/olivewood/$ROMNAME\_olivewood.mk
sed -i "s|lineage|$ROMNAME|" device/xiaomi/olivewood/AndroidProducts.mk
## start build process
. build/envsetup.sh
export USE_CCACHE=1
export LC_ALL=C
export WITHOUT_CHECK_API=true
time brunch olivewood
#lunch lineage_olivewood-eng 
#make bacon -j$(nproc -ignore=8)
## build continuance section if sources already synced
else
. build/envsetup.sh
export USE_CCACHE=1
export LC_ALL=C
export WITH_CHECK_API=true
time brunch olivewood
fi
