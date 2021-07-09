#!/system/bin/sh
#=========================================================
MODDIR=${0%/*}

# Wifi Fixes
if [ -e /sys/module/wlan/parameters/fwpath ]; then
  echo "sta" > /sys/module/wlan/parameters/fwpath
fi
# by SdkPt

#=========================================================
# End of cs-late.sh
# Modified by @preparetodietm
#=========================================================