#!/system/bin/sh
# This script will be executed in late_start service mode
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
#1
#WifiFixes
#WF_one
#WF_two
#WF_three
#WF_four
#2
#CustSwap
#CS_one
#CS_two
#CS_three
#CS_four
#CS_five 2>&1
#CS_six 2>&1
#CS_seven
#CS_eight
#CS_nine
#CS_ten
#3
#FlushRAM
#FR_one
#FR_two
#FR_three
#FR_four
#FR_five

#=========================================================
# End of service.sh
# Modified by @preparetodietm
#=========================================================
