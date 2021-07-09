#!/system/bin/sh
# This script will be executed in late_start service mode
# More info in the main Magisk thread
#=========================================================
MODDIR=${0%/*}

# Disable GPU Throttling
if [ -e /sys/class/kgsl/kgsl-3d0/throttling ]; then
  echo "0" > /sys/class/kgsl/kgsl-3d0/throttling
fi

# Enable fast charging
if [ -e /sys/kernel/fast_charge/force_fast_charge ]; then
  echo "1" > /sys/kernel/fast_charge/force_fast_charge
fi
# by AkiraNoSushi

# Set default brightness
if [ -e /sys/class/leds/lcd-backlight/max_brightness ]; then
  echo "4087" > /sys/class/leds/lcd-backlight/max_brightness
fi

# Remove Flush RAM Logs after Booted
sleep 90

if [ -f /data/adb/modules/flushram/module.prop ]; then
  rm -rf "/data/media/0/weareravens.log"
  rm -rf "/data/media/0/.weareravens/weareravens.log"
fi

#=========================================================
# End of service.sh
# Modified by @preparetodietm
#=========================================================
