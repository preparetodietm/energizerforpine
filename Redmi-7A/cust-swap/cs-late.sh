#!/system/bin/sh
#=========================================================
MODDIR=${0%/*}

# Cust Swap
# Wait for boot to finish completely

while [[ `getprop sys.boot_completed` -ne 1 ]]
do
sleep 1
  mkswap /dev/block/by-name/cust > /dev/null 2>&1
  swapon /dev/block/by-name/cust > /dev/null 2>&1
done

# Sleep an additional 90s to ensure init is finished
sleep 90

#=========================================================
# End of cs-late.sh
# Modified by @preparetodietm
#=========================================================