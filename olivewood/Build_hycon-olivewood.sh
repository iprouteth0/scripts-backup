#! /bin/bash

## Hycon OS
ROMGIT="https://github.com/HyconOS/manifest"
SOURCEFILE=Android.bp


if [[ ! -f $SOURCEFILE ]] 
then 
repo init -u $ROMGIT 
repo sync -j$(nproc --ignore=8)
. olivewood-clone_sources.sh 
. build/envsetup.sh
export USE_CCACHE=1
export LC_ALL=C
export WITHOUT_CHECK_API=true
time brunch olivewood
#lunch lineage_olivewood-eng 
#make bacon -j$(nproc -ignore=8)
else
. build/envsetup.sh
export USE_CCACHE=1
export LC_ALL=C
export WITH_CHECK_API=true
time brunch olivewood
fi
