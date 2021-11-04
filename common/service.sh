#!/system/bin/sh
# This script will be executed in late_start service mode
#=========================================================
MODDIR=${0%/*}

# Disable GPU Throttling
if [ -e /sys/class/kgsl/kgsl-3d0/throttling ]; then
  echo "0" > /sys/class/kgsl/kgsl-3d0/throttling
fi

# Disable UBWC for Graphics
setprop debug.gralloc.gfx_ubwc_disable 1

# Enable fast charging
if [ -e /sys/kernel/fast_charge/force_fast_charge ]; then
  echo "1" > /sys/kernel/fast_charge/force_fast_charge
fi
# by AkiraNoSushi

# Set default brightness
if [ -e /sys/class/leds/lcd-backlight/max_brightness ]; then
  echo "4087" > /sys/class/leds/lcd-backlight/max_brightness
fi

# Switch to Portable Interpreter
echo dalvik.vm.execution-mode = int:portable >> /data/local.prop
#1
#WifiFixes
#WF_one
#WF_two
#WF_three
#WF_four

#=========================================================
# End of service.sh
# Modified by @preparetodietm
#=========================================================
