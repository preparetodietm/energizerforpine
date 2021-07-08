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

# WIFI Fixes for Lilac Kernel
if [ -e /sys/module/wlan/parameters/fwpath ]; then
  echo "sta" > /sys/module/wlan/parameters/fwpath
fi
# by SdkPpt

#=========================================================
# End of service.sh
# Modified by @preparetodietm
#=========================================================
