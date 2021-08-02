##########################################################################################
#
# Magisk Module Installer Script
#
##########################################################################################
##########################################################################################
# Config Flags
##########################################################################################
# Set to true if you do *NOT* want Magisk to mount
# any files for you. Most modules would NOT want
# to set this flag to true
SKIPMOUNT=false

# Set to true if you need to load system.prop
PROPFILE=true

# Set to true if you need post-fs-data script
POSTFSDATA=true

# Set to true if you need late_start service script
LATESTARTSERVICE=true
##########################################################################################
# Replace list
##########################################################################################

# List all directories you want to directly replace in the system

# Construct your list in the following format
# This is an example
REPLACE_EXAMPLE="
/system/app/Youtube
/system/priv-app/SystemUI
/system/priv-app/Settings
/system/framework
"

# Construct your own list here
REPLACE="
"
##########################################################################################
#
# Function Callbacks
#
# The following functions will be called by the installation framework.
# You do not have the ability to modify update-binary, the only way you can customize
# installation is through implementing these functions.
#
# When running your callbacks, the installation framework will make sure the Magisk
# internal busybox path is *PREPENDED* to PATH, so all common commands shall exist.
# Also, it will make sure /data, /system, and /vendor is properly mounted.
#
##########################################################################################
##########################################################################################
#
# The installation framework will export some variables and functions.
# You should use these variables and functions for installation.
#
# ! DO NOT use any Magisk internal paths as those are NOT public API.
# ! DO NOT use other functions in util_functions.sh as they are NOT public API.
# ! Non public APIs are not guranteed to maintain compatibility between releases.
#
# Available variables:
#
# MAGISK_VER (string): the version string of current installed Magisk
# MAGISK_VER_CODE (int): the version code of current installed Magisk
# BOOTMODE (bool): true if the module is currently installing in Magisk Manager
# MODPATH (path): the path where your module files should be installed
# TMPDIR (path): a place where you can temporarily store files
# ZIPFILE (path): your module's installation zip
# ARCH (string): the architecture of the device. Value is either arm, arm64, x86, or x64
# IS64BIT (bool): true if $ARCH is either arm64 or x64
# API (int): the API level (Android version) of the device
#
# Availible functions:
#
# ui_print <msg>
#     print <msg> to console
#     Avoid using 'echo' as it will not display in custom recovery's console
#
# abort <msg>
#     print error message <msg> to console and terminate installation
#     Avoid using 'exit' as it will skip the termination cleanup steps
#
# set_perm <target> <owner> <group> <permission> [context]
#     if [context] is empty, it will default to "u:object_r:system_file:s0"
#     this function is a shorthand for the following commands
#       chown owner.group target
#       chmod permission target
#       chcon context target
#
# set_perm_recursive <directory> <owner> <group> <dirpermission> <filepermission> [context]
#     if [context] is empty, it will default to "u:object_r:system_file:s0"
#     for all files in <directory>, it will call:
#       set_perm file owner group filepermission context
#     for all directories in <directory> (including itself), it will call:
#       set_perm dir owner group dirpermission context
#
##########################################################################################
##########################################################################################
# If you need boot scripts, DO NOT use general boot scripts (post-fs-data.d/service.d)
# ONLY use module scripts as it respects the module status (remove/disable) and is
# guaranteed to maintain the same behavior in future Magisk releases.
# Enable boot scripts by setting the flags in the config section above.
##########################################################################################
print_modname() {
  ui_print "************************************************************"
  ui_print "                    𝗘𝗻𝗲𝗿𝗴𝗶𝘇𝗲𝗿 𝗳𝗼𝗿 𝗥𝗲𝗱𝗺𝗶 𝟳𝗔⚡                  " 
  ui_print "                      by @𝐩𝐫𝐞𝐩𝐚𝐫𝐞𝐭𝐨𝐝𝐢𝐞𝐭𝐦                       "
  ui_print " "
  ui_print "  ###    ####    ###    ###    ###   #  ####    ###    ###  "
  ui_print " #      #    #  #      #   #  #      #     #   #      #   # "
  ui_print " ###    #    #  ###    ###    # ##   #    #    ###    ###   "
  ui_print " #      #    #  #      #  #   #   #  #   #     #      #  #  "
  ui_print "  ###   #    #   ###   #   #   ###   #   ####   ###   #   # "
  ui_print "                      𝐯𝐞𝐫𝐬𝐢𝐨𝐧 𝟏.𝟑 - 𝐬𝐭𝐚𝐛𝐥𝐞                      "
  ui_print " "
  ui_print "                 Powered by 𝐌𝐚𝐠𝐢𝐬𝐤 (@𝐭𝐨𝐩𝐣𝐨𝐡𝐧𝐰𝐮)               "
  ui_print "************************************************************"
sleep 1
  ui_print " Phone Model: $(getprop ro.product.model) "
sleep 0.5 
  ui_print " System Version: Android $(getprop ro.system.build.version.release) "
sleep 0.5 
  ui_print " System Structure: $ARCH "
sleep 0.5 
  ui_print " Build Type: Stable "
  ui_print " "
sleep 0.5
  ui_print "- 𝐈𝐧𝐬𝐭𝐚𝐥𝐥𝐢𝐧𝐠 𝐄𝐧𝐞𝐫𝐠𝐢𝐳𝐞𝐫 𝐅𝐞𝐚𝐭𝐮𝐫𝐞𝐬... "
sleep 2.5 
  ui_print "𝐃𝐨𝐧𝐞: 𝑬𝒏𝒆𝒓𝒈𝒊𝒛𝒆𝒓 𝑭𝒆𝒂𝒕𝒖𝒓𝒆𝒔 𝑰𝒏𝒔𝒕𝒂𝒍𝒍𝒆𝒅!"
  ui_print " "
sleep 0.5    
}

# Copy/extract your module files into $MODPATH in on_install.
on_install() {
  # The following is the default implementation: extract $ZIPFILE/system to $MODPATH
  # Extend/change the logic to whatever you want
  ui_print "- Extracting module files"
  unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
  unzip -o "$ZIPFILE" 'Redmi-7A/*' -d $TMPDIR >&2
  ui_print "Done"
  sleep 0.5
  
  # Callbacks
  DE=/data/adb/modules_update/dexopt-everything/
  DWB=$MODPATH/system/vendor/etc/wifi/
  flushram=/data/adb/modules_update/flushram/
  FR=/data/adb/modules_update/flushram/system/bin/
  FR1=/data/adb/modules_update/flushram/system/priv-app/
  RAM=su -c cat /proc/meminfo | grep MemTotal
  TI=$MODPATH/system/usr/idc/
  TI1=$MODPATH/system/vendor/usr/idc/
  
  ram2gb() {
  sed -i 's/#RAM_2or3/dalvik.vm.heapgrowthlimit=128m/g' $TMPDIR/system.prop
  sed -i 's/#RAM_one/dalvik.vm.heapmaxfree=8m/g' $TMPDIR/system.prop
  sed -i 's/#RAM_two/dalvik.vm.heapminfree=2m/g' $TMPDIR/system.prop
  sed -i 's/#RAM_three/dalvik.vm.heapsize=256m/g' $TMPDIR/system.prop
  sed -i 's/#RAM_four/dalvik.vm.heapstartsize=8m/g' $TMPDIR/system.prop
  sed -i 's/#RAM_five/dalvik.vm.heaptargetutilization=0.75/g' $TMPDIR/system.prop
  }
  
  ram3gb() { 	
  sed -i 's/#RAM_2or3/dalvik.vm.heapgrowthlimit=256m/g' $TMPDIR/system.prop
  sed -i 's/#RAM_one/dalvik.vm.heapmaxfree=8m/g' $TMPDIR/system.prop
  sed -i 's/#RAM_two/dalvik.vm.heapminfree=512k/g' $TMPDIR/system.prop
  sed -i 's/#RAM_three/dalvik.vm.heapsize=512m/g' $TMPDIR/system.prop
  sed -i 's/#RAM_four/dalvik.vm.heapstartsize=8m/g' $TMPDIR/system.prop
  sed -i 's/#RAM_five/dalvik.vm.heaptargetutilization=0.75/g' $TMPDIR/system.prop
  }

  run_detection() {
  ui_print " "	
  ui_print "- Detecting if other tweaks are installed..."
  sleep 5 
}

  run_de() {
  ui_print " "	
  ui_print "*******************************************************"
  ui_print " 𝐖𝐡𝐚𝐭 𝐢𝐬 𝐃𝐞𝐱𝐨𝐩𝐭 𝐄𝐯𝐞𝐫𝐲𝐭𝐡𝐢𝐧𝐠? "
  ui_print " "
  ui_print " 𝑫𝒆𝒙𝒐𝒑𝒕 𝒊𝒔 𝒂 𝒔𝒚𝒔𝒕𝒆𝒎-𝒊𝒏𝒕𝒆𝒓𝒏𝒂𝒍 𝒕𝒐𝒐𝒍 𝒕𝒉𝒂𝒕 𝒊𝒔 𝒖𝒔𝒆𝒅 𝒕𝒐 𝒑𝒓𝒐𝒅𝒖𝒄𝒆 𝒐𝒑𝒕𝒊𝒎𝒊𝒛𝒆𝒅 𝒅𝒆𝒙 "
  ui_print " 𝒇𝒊𝒍𝒆𝒔 𝒃𝒚 𝒖𝒔𝒊𝒏𝒈 𝒔𝒖 -𝒄 𝒄𝒎𝒅 𝒑𝒂𝒄𝒌𝒂𝒈𝒆 𝒃𝒈-𝒅𝒆𝒙𝒐𝒑𝒕-𝒋𝒐𝒃 𝒄𝒐𝒅𝒆. "
  ui_print "*******************************************************"
  ui_print " "
  ui_print "================================================"
  ui_print " Do you want to install Dexopt Everything? "
  ui_print " "
  ui_print " 1. Yes, please 🤗 "
  ui_print " 2. No, skip it 😡 "
  ui_print " "
  ui_print " Choose 1 or 2 "
  

DE1=1
while true; do
  ui_print " $DE1 "
if $VKSEL; then
  DE1=$((DE1 + 1))
else    
break    
fi
if [ $DE1 -gt 2 ]; then
  DE1=1
fi
done  
  ui_print " Selected: $DE1 "
  ui_print " "
  sleep 0.5
  
case $DE1 in
  1 ) DE2="✅ Dexopt Everything Installed!"; mkdir -p $DE ; cp -f $TMPDIR/Redmi-7A/dexopt-everything/* $DE ;;
  2 ) DE2="❌ Dexopt Everything Skipped!"; continue ;;
esac
  ui_print " $DE2 "
  ui_print "================================================"
  sleep 1
}

  run_cs() {
  ui_print " "	
  ui_print "********************************************************"
  ui_print " 𝐖𝐡𝐚𝐭 𝐢𝐬 𝐂𝐮𝐬𝐭 𝐒𝐰𝐚𝐩? "
  ui_print " "
  ui_print " 𝑻𝒖𝒓𝒏𝒔 𝒚𝒐𝒖𝒓 𝒖𝒔𝒆𝒍𝒆𝒔𝒔 𝒑𝒂𝒓𝒕𝒊𝒕𝒊𝒐𝒏 𝒊𝒏𝒕𝒐 𝒔𝒘𝒂𝒑 𝒑𝒂𝒓𝒕𝒊𝒕𝒊𝒐𝒏 𝒂𝒏𝒅 𝒈𝒆𝒕 𝒆𝒙𝒕𝒓𝒂 512𝒎𝒃. "
  ui_print "********************************************************"
  ui_print " "
  ui_print "================================================"
  ui_print " Do you want to install Cust Swap? "
  ui_print " "
  ui_print " 1. Yes, please 🤗 "
  ui_print " 2. No, I don't need it 😡 "
  ui_print " "
  ui_print " Choose 1 or 2 "

CS=1
while true; do
  ui_print " $CS "
if $VKSEL; then
  CS=$((CS + 1))
else    
break    
fi
if [ $CS -gt 2 ]; then
  CS=1
fi
done  
  ui_print " Selected: $CS "
  ui_print " "
  sleep 0.5
  
case $CS in
  1 ) CS1="✅ Cust Swap Installed!"; cp -f $TMPDIR/Redmi-7A/cust-swap/cust_swap $MODPATH ; sed -i 's/#2//g' $TMPDIR/service.sh ; sed -i 's/#CustSwap/# Cust Swap/g' $TMPDIR/service.sh ; sed -i 's/#CS_one/# Wait for boot to finish completely/g' $TMPDIR/service.sh ; sed -i 's+#CS_two+while [[ `getprop sys.boot_completed` -ne 1 ]]+g' $TMPDIR/service.sh ; sed -i 's/#CS_three/do/g' $TMPDIR/service.sh ; sed -i 's/#CS_four/sleep 1/g' $TMPDIR/service.sh ; sed -i 's+#CS_five+  mkswap /dev/block/by-name/cust > /dev/null+g' $TMPDIR/service.sh ; sed -i 's+#CS_six+  swapon /dev/block/by-name/cust > /dev/null+g' $TMPDIR/service.sh ; sed -i 's/#CS_seven/done/g' $TMPDIR/service.sh ; sed -i 's/#CS_eight//g' $TMPDIR/service.sh ; sed -i 's/#CS_nine/# Sleep an additional 90s to ensure init is finished/g' $TMPDIR/service.sh ; sed -i 's/#CS_ten/sleep 90/g' $TMPDIR/service.sh ; sed -i 's/#1//g' $TMPDIR/post-fs-data.sh ; sed -i 's/#CustSwap/# Cust Swap/g' $TMPDIR/post-fs-data.sh ; sed -i 's+#CS_one+mkswap /dev/block/by-name/cust > /dev/null+g' $TMPDIR/post-fs-data.sh ; sed -i 's+#CS_two+swapon /dev/block/by-name/cust > /dev/null+g' $TMPDIR/post-fs-data.sh ; sed -i 's/#CS_three/# by Flopster101/g' $TMPDIR/post-fs-data.sh ;;
  2 ) CS1="❌ Cust Swap Not Installed!"; sed -i '/#2/d' $TMPDIR/service.sh ; sed -i '/#CustSwap/d' $TMPDIR/service.sh ; sed -i '/#CS_one/d' $TMPDIR/service.sh ; sed -i '/#CS_two/d' $TMPDIR/service.sh ; sed -i '/#CS_three/d' $TMPDIR/service.sh ; sed -i '/#CS_four/d' $TMPDIR/service.sh ; sed -i '/#CS_five 2>&1/d' $TMPDIR/service.sh ; sed -i '/#CS_six 2>&1/d' $TMPDIR/service.sh ; sed -i '/#CS_seven/d' $TMPDIR/service.sh ; sed -i '/#CS_eight/d' $TMPDIR/service.sh ; sed -i '/#CS_nine/d' $TMPDIR/service.sh ; sed -i '/#CS_ten/d' $TMPDIR/service.sh ; sed -i '/#1/d' $TMPDIR/post-fs-data.sh ; sed -i '/#CustSwap/d' $TMPDIR/post-fs-data.sh ; sed -i '/#CS_one 2>&1/d' $TMPDIR/post-fs-data.sh ; sed -i '/#CS_two 2>&1/d' $TMPDIR/post-fs-data.sh ; sed -i '/#CS_three/d' $TMPDIR/post-fs-data.sh ; continue ;;
esac 
  ui_print " $CS1 "
  ui_print "================================================"
  sleep 1
}

  run_dwb() {
  ui_print " "	
  ui_print "**************************************************"
  ui_print " 𝐖𝐡𝐚𝐭 𝐢𝐬 𝐃𝐨𝐮𝐛𝐥𝐞 𝐖𝐢𝐟𝐢 𝐁𝐚𝐧𝐝𝐰𝐢𝐭𝐡? "
  ui_print " "
  ui_print " 𝑫𝒐𝒖𝒃𝒍𝒆𝒔 𝒚𝒐𝒖𝒓 𝒘𝒊𝒇𝒊 𝒃𝒂𝒏𝒅𝒘𝒊𝒅𝒕𝒉 𝒃𝒚 𝒎𝒐𝒅𝒊𝒇𝒚𝒊𝒏𝒈 𝑾𝑪𝑵𝑺𝑺_𝒒𝒄𝒐𝒎_𝒄𝒇𝒈.𝒊𝒏𝒊 "
  ui_print "**************************************************"
  ui_print " "
  ui_print "================================================"
  ui_print " Do you want to install Double Wifi Bandwidth? "
  ui_print " "
  ui_print " 1. Yes, please 🤗 "
  ui_print " 2. No, I don't need it 😡 "
  ui_print " "
  ui_print " Choose 1 or 2 "

DWB1=1
while true; do
  ui_print " $DWB1 "
if $VKSEL; then
  DWB1=$((DWB1 + 1))
else    
break    
fi
if [ $DWB1 -gt 2 ]; then
  DWB1=1
fi
done  
  ui_print " Selected: $DWB1 "
  ui_print " "
  sleep 0.5
  
case $DWB1 in
  1 ) DWB2="✅ Double Wifi Bandwidth Installed!"; mkdir -p $DWB ; cp -f $TMPDIR/Redmi-7A/double-wifi-bandwidth/* $DWB ;;
  2 ) DWB2="❌ Double Wifi Bandwidth Not Installed!"; continue ;;
esac 
  ui_print " $DWB2 "
  ui_print "================================================"
  sleep 1
}

  run_fr() {
  ui_print " "	
  ui_print "********************************************************"
  ui_print " 𝐖𝐡𝐚𝐭 𝐢𝐬 𝐅𝐥𝐮𝐬𝐡 𝐑𝐀𝐌? "
  ui_print " "
  ui_print " 𝑪𝒍𝒆𝒂𝒓 𝑹𝑨𝑴 𝒄𝒂𝒄𝒉𝒆 𝒂𝒏𝒅 𝒇𝒐𝒓𝒄𝒆 𝒔𝒕𝒐𝒑 𝒂𝒍𝒍 𝒂𝒑𝒑𝒔 𝒕𝒐 𝒈𝒆𝒕 𝒎𝒐𝒓𝒆 𝒇𝒓𝒆𝒆 𝑹𝑨𝑴 𝒃𝒆𝒇𝒐𝒓𝒆 "
  ui_print " 𝒑𝒍𝒂𝒚𝒊𝒏𝒈 𝒈𝒂𝒎𝒆𝒔. 𝑼𝒔𝒆 𝒄𝒐𝒎𝒎𝒂𝒏𝒅𝒔 𝒇𝒓𝒐𝒎 𝑻𝒆𝒓𝒎𝒊𝒏𝒂𝒍 𝑬𝒎𝒖𝒍𝒂𝒕𝒐𝒓/𝑻𝒆𝒓𝒎𝒖𝒙 "
  ui_print " 𝙨𝙪 -𝙘 𝙛𝙡𝙪𝙨𝙝 (𝒔𝒂𝒇𝒆) , 𝙨𝙪 -𝙘 𝙛𝙡𝙪𝙨𝙝𝟮 (𝑨𝒈𝒈𝒓𝒆𝒔𝒔𝒊𝒗𝒆) , "
  ui_print " 𝙨𝙪 -𝙘 𝙛𝙡𝙪𝙨𝙝𝟯 (𝑬𝒙𝒕𝒓𝒆𝒎𝒆) , or 𝙨𝙪 -𝙘 𝙛𝙡𝙪𝙨𝙝4 (Most Extreme). "
  ui_print "********************************************************"
  ui_print " "
  ui_print "================================================"
  ui_print " Do you want to install Flush RAM? "
  ui_print " "
  ui_print " 1. Yes, please 🤗 "
  ui_print " 2. No, I don't need it 😡 "
  ui_print " "
  ui_print " Choose 1 or 2 "

FR2=1
while true; do
  ui_print " $FR2 "
if $VKSEL; then
  FR2=$((FR2 + 1))
else    
break    
fi
if [ $FR2 -gt 2 ]; then
  FR2=1
fi
done  
  ui_print " Selected: $FR2 "
  ui_print " "
  sleep 0.5
  
case $FR2 in
  1 ) FR3=" "; mkdir -p $flushram ; cp -f $TMPDIR/Redmi-7A/flushram/* $flushram ; mkdir -p $FR ; cp -f $TMPDIR/Redmi-7A/flushram/bin/* $FR ; mkdir -p $FR1 ; cp -f $TMPDIR/Redmi-7A/flushram/priv-app/* $FR1 ; sed -i 's/#3//g' $TMPDIR/service.sh ; sed -i 's/#FlushRAM/# Remove Flush RAM Logs after Booted/g' $TMPDIR/service.sh ; sed -i 's/#FR_two//g' $TMPDIR/service.sh ; sed -i 's+#FR_three+if [ -f /data/adb/modules/flushram/module.prop ]; then+g' $TMPDIR/service.sh ; sed -i 's+#FR_four+  rm -rf "/data/media/0/weareravens.log"+g' $TMPDIR/service.sh ; sed -i 's/#FR_five/fi/g' $TMPDIR/service.sh ; ui_print "✅ Flush RAM Installed! Logs are located in the" ; ui_print "/sdcard/weareravens.log everytime you used it." ; ui_print "================================================" ;;
  2 ) FR3=" "; ui_print "❌ Flush RAM Not Installed!" ; sed -i '/#3/d' $TMPDIR/service.sh ; sed -i '/#FlushRAM/d' $TMPDIR/service.sh ; sed -i '/#FR_one/d' $TMPDIR/service.sh ; sed -i '/#FR_two/d' $TMPDIR/service.sh ; sed -i '/#FR_three/d' $TMPDIR/service.sh ; sed -i '/#FR_four/d' $TMPDIR/service.sh ; sed -i '/#FR_five/d' $TMPDIR/service.sh ; sed -i '/#FR_six/d' $TMPDIR/service.sh ; ui_print "================================================" ; continue ;;
esac 
  ui_print " $FR3 "
  sleep 1
}

  run_ti() {
  ui_print " "	
  ui_print "*******************************************"	
  ui_print " 𝐖𝐡𝐚𝐭 𝐢𝐬 𝐓𝐨𝐮𝐜𝐡𝐬𝐫𝐞𝐞𝐧 𝐈𝐦𝐩𝐫𝐨𝐯𝐞𝐦𝐞𝐧𝐭? "
  ui_print " "
  ui_print " 𝑨 𝒕𝒘𝒆𝒂𝒌𝒔 𝒇𝒐𝒓 𝒕𝒐𝒖𝒄𝒉𝒔𝒓𝒆𝒆𝒏 "𝒇𝒕𝒔_𝒕𝒔" 𝒇𝒐𝒓 𝑹𝒆𝒅𝒎𝒊 7𝑨 𝒅𝒆𝒗𝒊𝒄𝒆𝒔. "
  ui_print "*******************************************"
  ui_print " "
  ui_print "================================================"
  ui_print " Do you want to install Touchscreen Improvement? "
  ui_print " "
  ui_print " 1. Yes, please 🤗 "
  ui_print " 2. No, I don't need it 😡 "
  ui_print " "
  ui_print " Choose 1 or 2 "

TI2=1
while true; do
  ui_print " $TI2 "
if $VKSEL; then
  TI2=$((TI2 + 1))
else    
break    
fi
if [ TI2 -gt 2 ]; then
  TI2=1
fi
done  
  ui_print " Selected: $TI2 "
  ui_print " "
  sleep 0.5
  
case $TI2 in
  1 ) TI3="✅ Touchscreen Improvement Installed!"; mkdir -p $TI ; cp -f $TMPDIR/Redmi-7A/touchscreen-improvement/idc/* $TI ; mkdir -p $TI1 ; cp -f $TMPDIR/Redmi-7A/touchscreen-improvement/idc/* $TI1 ;;
  2 ) TI3="❌ Touchscreen Improvement Not Installed!"; continue ;;
esac
  ui_print " $TI3 "
  ui_print "================================================"
  sleep 1
}

  run_wf() {	
  ui_print " "	
  ui_print "***************************************************"
  ui_print " 𝐖𝐡𝐚𝐭 𝐢𝐬 𝐖𝐢𝐟𝐢 𝐅𝐢𝐱𝐞𝐬? "
  ui_print " "
  ui_print " 𝑭𝒊𝒙 𝒘𝒊𝒇𝒊 𝒏𝒐𝒕 𝒘𝒐𝒓𝒌𝒊𝒏𝒈 𝒂𝒇𝒕𝒆𝒓 𝒇𝒍𝒂𝒔𝒉𝒊𝒏𝒈 𝒌𝒆𝒓𝒏𝒆𝒍 𝒂𝒏𝒅 𝒃𝒐𝒐𝒕𝒆𝒅 𝒕𝒐 𝒔𝒚𝒔𝒕𝒆𝒎. "
  ui_print " 𝑰𝒏𝒔𝒕𝒂𝒍𝒍 𝒐𝒏𝒍𝒚 𝒊𝒇 𝒚𝒐𝒖 𝒏𝒆𝒆𝒅 𝒊𝒕! "
  ui_print "***************************************************"
  ui_print " "
  ui_print "================================================"
  ui_print " Do you want to install Wifi Fixes? "
  ui_print " "
  ui_print " 1. Yes, please 🤗 "
  ui_print " 2. No, I don't need it 😡 "
  ui_print " "
  ui_print " Choose 1 or 2 "

WF=1
while true; do
  ui_print " $WF "
if $VKSEL; then
  WF=$((WF + 1))
else    
break    
fi
if [ $WF -gt 2 ]; then
  WF=1
fi
done  
  ui_print " Selected: $WF "
  ui_print " "
  sleep 0.5
  
case $WF in
  1 ) WF1="✅ Wifi Fixes Installed!"; cp -f $TMPDIR/Redmi-7A/wifi-fixes/wifi_fixes $MODPATH ; sed -i 's/#1//g' $TMPDIR/service.sh ; sed -i 's/#WifiFixes/# Wifi Fixes/g' $TMPDIR/service.sh ; sed -i 's+#WF_one+if [ -e /sys/module/wlan/parameters/fwpath ]; then+g' $TMPDIR/service.sh ; sed -i 's+#WF_two+  echo "sta" > /sys/module/wlan/parameters/fwpath+g' $TMPDIR/service.sh ; sed -i 's/#WF_three/fi/g' $TMPDIR/service.sh ; sed -i 's/#WF_four/# by SdkPt/g' $TMPDIR/service.sh ;;
  2 ) WF1="❌ Wifi Fixes Not Installed!"; sed -i '/#1/d' $TMPDIR/service.sh ; sed -i '/#WifiFixes/d' $TMPDIR/service.sh ; sed -i '/#WF_one/d' $TMPDIR/service.sh ; sed -i '/#WF_two/d' $TMPDIR/service.sh ; sed -i '/#WF_three/d' $TMPDIR/service.sh ; sed -i '/#WF_four/d' $TMPDIR/service.sh ; continue ;;
esac 
  ui_print " $WF1 "
  ui_print "================================================"
  sleep 1
}

if [ $RAM="MemTotal:        1876284 kB" ]; then
    ram2gb
else
    ram3gb
fi

  # Choose what features you want to be included on this module.
  . $TMPDIR/addon/Volume-Key-Selector/preinstall.sh
  ui_print " "
  ui_print "         𝐍𝐨𝐭𝐞: 𝑽𝒐𝒍𝒖𝒎𝒆 𝑼𝒑 = 𝑪𝒉𝒐𝒐𝒔𝒆 "
  ui_print "              𝑽𝒐𝒍𝒖𝒎𝒆 𝑫𝒐𝒘𝒏= 𝑺𝒆𝒍𝒆𝒄𝒕 "
  ui_print " "
  ui_print "================================================"
  ui_print "   𝗖𝗵𝗼𝗼𝘀𝗲 𝘄𝗵𝗮𝘁 𝘆𝗼𝘂 𝘄𝗮𝗻𝘁 𝘁𝗼 𝗶𝗻𝘀𝘁𝗮𝗹𝗹 𝗼𝗻 𝘆𝗼𝘂𝗿 𝗣𝗵𝗼𝗻𝗲!   "
  ui_print "================================================"
  sleep 2
if [ -f /data/adb/modules/energizerforpine/module.prop ]; then
    run_detection
else
    continue
fi    

# Detect Dexopt Everything and excluded to module updates
if [ -f /data/adb/modules/dexopt-everything/module.prop ]; then
  ui_print " "
  ui_print "✅ Dexopt Everything Already Installed!"  
  ui_print "================================================"  
  ui_print " Do you want to Execute Dexopt Everything? "
  ui_print " "
  ui_print " 1. Yes, please 🤗 "
  ui_print " 2. No, skip it 😡 "
  ui_print " "
  ui_print " Choose 1 or 2 "
  

DE1=1
while true; do
  ui_print " $DE1 "
if $VKSEL; then
  DE1=$((DE1 + 1))
else    
break    
fi
if [ $DE1 -gt 2 ]; then
  DE1=1
fi
done  
  ui_print " Selected: $DE1 "
  ui_print " "
  sleep 0.5
  
case $DE1 in
  1 ) DE2="✅ Dexopt Everything Executed!"; if [ -f /data/adb/modules/dexopt-everything/module.prop ]; then ui_print "- Executing Dexopt Everything..." ; su -c cmd package bg-dexopt-job ; fi ;;
  2 ) DE2="❌ Dexopt Everything Skipped!"; continue ;;
esac
  ui_print " $DE2 "
  ui_print "================================================"
  sleep 1
else
    run_de
fi

# Detect all installed and included to module updates
if [ -e /data/adb/modules/energizerforpine/cust_swap ] || [ -f /data/adb/modules/cust_swap/module.prop ]; then
    ui_print " "
    ui_print "✅ Cust Swap Already Installed!"
    cp -f $TMPDIR/Redmi-7A/cust-swap/cust_swap $MODPATH
    sed -i 's/#CustSwap/# Cust Swap/g' $TMPDIR/service.sh
    sed -i 's/#CS_one/# Wait for boot to finish completely/g' $TMPDIR/service.sh 
    sed -i 's+#CS_two+while [[ `getprop sys.boot_completed` -ne 1 ]]+g' $TMPDIR/service.sh
    sed -i 's/#CS_three/do/g' $TMPDIR/service.sh
    sed -i 's/#CS_four/sleep 1/g' $TMPDIR/service.sh
    sed -i 's+#CS_five+  mkswap /dev/block/by-name/cust > /dev/null+g' $TMPDIR/service.sh
    sed -i 's+#CS_six+  swapon /dev/block/by-name/cust > /dev/null+g' $TMPDIR/service.sh
    sed -i 's/#CS_seven/done/g' $TMPDIR/service.sh
    sed -i 's/#CS_eight//g' $TMPDIR/service.sh
    sed -i 's/#CS_nine/# Sleep an additional 90s to ensure init is finished/g' $TMPDIR/service.sh
    sed -i 's/#CS_ten/sleep 90/g' $TMPDIR/service.sh
    sed -i 's/#CustSwap/# Cust Swap/g' $TMPDIR/post-fs-data.sh
    sed -i 's+#CS_one+mkswap /dev/block/by-name/cust > /dev/null+g' $TMPDIR/post-fs-data.sh
    sed -i 's+#CS_two+swapon /dev/block/by-name/cust > /dev/null+g' $TMPDIR/post-fs-data.sh
    sed -i 's/#CS_three/# by Flopster101/g' $TMPDIR/post-fs-data.sh
    sleep 0.5
    continue
else
    run_cs
fi

if [ -f /data/adb/modules/energizerforpine/system/vendor/etc/wifi/WCNSS_qcom_cfg.ini ]; then
    ui_print " "
    ui_print "✅ Double Wifi Bandwidth Already Installed!"
    mkdir -p $DWB
    cp -f $TMPDIR/Redmi-7A/double-wifi-bandwidth/* $DWB
    sleep 0.5
    continue
else
    run_dwb
fi

if [ -f /data/adb/modules/flushram/module.prop ]; then
    ui_print " "
    ui_print "✅ Flush RAM Already Installed!"
    mkdir -p $flushram
    cp -f $TMPDIR/Redmi-7A/flushram/* $flushram
    mkdir -p $FR
    cp -f $TMPDIR/Redmi-7A/flushram/bin/* $FR
    mkdir -p $FR1
    cp -f $TMPDIR/Redmi-7A/flushram/priv-app/* $FR1
    sed -i 's/#3//g' $TMPDIR/service.sh
    sed -i 's/#FlushRAM/# Remove Flush RAM Logs after Booted/g' $TMPDIR/service.sh
    sed -i 's/#FR_two//g' $TMPDIR/service.sh
    sed -i 's+#FR_three+if [ -f /data/adb/modules/flushram/module.prop ]; then+g' $TMPDIR/service.sh
    sed -i 's+#FR_four+  rm -rf "/data/media/0/weareravens.log"+g' $TMPDIR/service.sh
    sed -i 's/#FR_five/fi/g' $TMPDIR/service.sh
    sleep 0.5
    continue
else
    run_fr
fi

if [ -e /data/adb/modules_update/energizerforpine/cust_swap ]; then
    sed -i '/#FR_one/d' $TMPDIR/service.sh 
  else
    sed -i 's/#FR_one/sleep 90/g' $TMPDIR/service.sh 
fi

if [ -f /data/adb/modules/energizerforpine/system/usr/idc/fts_ts.idc ] || [ -f /data/adb/modules/energizerforpine/system/vendor/usr/idc/fts_ts.idc ]; then 
    ui_print " "
    ui_print "✅ Touchscreen Improvement Already Installed!"
    mkdir -p $TI
    cp -f $TMPDIR/Redmi-7A/touchscreen-improvement/idc/* $TI
    mkdir -p $TI1 ; cp -f $TMPDIR/Redmi-7A/touchscreen-improvement/idc/* $TI1
    sleep 0.5
    continue
else
    run_ti
fi

if [ -e /data/adb/modules/energizerforpine/wifi_fixes ]; then
    ui_print " "
    ui_print "✅ Wifi Fixes Already Installed!" 
    cp -f $TMPDIR/Redmi-7A/wifi-fixes/wifi_fixes $MODPATH
    sed -i 's/#WifiFixes/# Wifi Fixes/g' $TMPDIR/service.sh
    sed -i 's+#WF_one+if [ -e /sys/module/wlan/parameters/fwpath ]; then+g' $TMPDIR/service.sh
    sed -i 's+#WF_two+  echo "sta" > /sys/module/wlan/parameters/fwpath+g' $TMPDIR/service.sh
    sed -i 's/#WF_three/fi/g' $TMPDIR/service.sh
    sed -i 's/#WF_four/# by SdkPt/g' $TMPDIR/service.sh
    sleep 0.5
    continue
else
    run_wf
fi

ui_print " "
}

# Only some special files require specific permissions
# This function will be called after on_install is done
# The default permissions should be good enough for most cases

set_permissions() {
  # The following is the default rule, DO NOT remove
  set_perm_recursive $MODPATH 0 0 0755 0644   
 
  # Dexopt Everything
  set_perm_recursive $DE 0 0 0755 0644
  
  # Flush RAM
  set_perm_recursive $flushram 0 0 0755 0644
  set_perm_recursive $flushram/system/bin 0 2000 0755 0755
  
  # Here are some examples:
  # set_perm_recursive  $MODPATH/system/lib       0     0       0755      0644
  # set_perm  $MODPATH/system/bin/app_process32   0     2000    0755      u:object_r:zygote_exec:s0
  # set_perm  $MODPATH/system/bin/dex2oat         0     2000    0755      u:object_r:dex2oat_exec:s0
  # set_perm  $MODPATH/system/lib/libart.so       0     0       0644
}

# You can add more functions to assist your custom script code

#=========================================================================================
# End of install.sh
# Modified by @preparetodietm
#=========================================================================================
