#! /bin/bash

ROMGIT="https://github.com/Komodo-OS-Rom/manifest"
SOURCEFILE=Android.bp
export ROMNAME=komodo

echo "Choose Komodo OS gapps type:" 
echo "0 for no gapps" 
echo "1 for gapps" 
echo "2 for microg" 
read komodo_gapps 
if [[ $komodo_gapps == 0 ]]
then export KOMODO_GAPPS_TYPE=nogapps
elif [[ $komodo_gapps == 1 ]] 
then export KOMODO_GAPPS_TYPE=gapps 
elif [[ $komodo_gapps == 2 ]] 
then export KOMODO_GAPPS_TYPE=microg
fi


if [[ ! -f $SOURCEFILE ]]
then
repo init -u $ROMGIT
repo sync -j$(nproc --ignore=10)
. olivewood-clone_sources.sh
sed -i "s|lineage|$ROMNAME|" device/xiaomi/olivewood/AndroidProducts.mk
cp device/xiaomi/olivewood/lineage_olivewood.mk device/xiaomi/olivewood/$ROMNAME\_olivewood.mk
sed -i "s|lineage|$ROMNAME|" device/xiaomi/olivewood/$ROMNAME\_olivewood.mk
sed -i "s|lineage|$ROMNAME|" device/xiaomi/olivewood/AndroidProducts.mk
. build/envsetup.sh
make clean
export USE_CCACHE=1
export LC_ALL=C
export WITHOUT_CHECK_API=true
brunch olivewood

else
. build/envsetup.sh
make clean
export USE_CCACHE=1
export LC_ALL=C
export WITHOUT_CHECK_API=true
brunch olivewood
fi
