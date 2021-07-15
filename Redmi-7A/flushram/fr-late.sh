#!/system/bin/sh
#=========================================================
MODDIR=${0%/*}

# Remove Flush RAM Logs after Booted
sleep 90

if [ -f /data/adb/modules/flushram/module.prop ]; then
  rm -rf "/data/media/0/weareravens.log"
  rm -rf "/data/media/0/.weareravens/weareravens.log"
fi

#=========================================================
# End of fr-late.sh
# Modified by @preparetodietm
#=========================================================