#!/bin/bash

## MsmExtended
make clean
export USE_CCACHE=1
export LC_ALL=C
export WITHOUT_CHECK_API=true
. build/envsetup.sh
brunch xtended_ginna-userdebug && m bacon
echo
echo " Rom Should Be Built"
echo ""
echo " ENTER TO CONTINUE"
echo ""
#mv $OUT/Xtended-XR-v4.0-ginna-XPLOITED*.zip ~/Android/Uploads/Roms/Android-11
#mv $OUT/Xtended-XR-v4.0-ginna-XPLOITED*.md5sum ~/Android/Uploads/Roms/Android-11
#cd ~/Android/Roms/AICP/11.0
#make clean
read
