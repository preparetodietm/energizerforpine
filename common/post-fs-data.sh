#!/system/bin/sh
# This script will be executed in post-fs-data mode
# More info in the main Magisk thread
#=========================================================
MODDIR=${0%/*}

# Set ZRAM Configurations
setprop ro.vendor.qti.config.zram true

#=========================================================
# End of post-fs-data.sh
# Modified by @preparetodietm
#=========================================================