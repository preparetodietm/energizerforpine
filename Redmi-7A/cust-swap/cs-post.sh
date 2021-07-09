#!/system/bin/sh
#=========================================================
MODDIR=${0%/*}

# Cust Swap
mkswap /dev/block/by-name/cust > /dev/null 2>&1
swapon /dev/block/by-name/cust > /dev/null 2>&1
# by Flopster101

#=========================================================
# End of cs-start.sh
# Modified by @preparetodietm
#=========================================================