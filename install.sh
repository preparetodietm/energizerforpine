##########################################################################################
#
# Magisk Module Installer Script
#
##########################################################################################
##########################################################################################
#
# Instructions:
#
# 1. Place your files into system folder (delete the placeholder file)
# 2. Fill in your module's info into module.prop
# 3. Configure and implement callbacks in this file
# 4. If you need boot scripts, add them into common/post-fs-data.sh or common/service.sh
# 5. Add your additional or modified system properties into common/system.prop
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
# Check the documentations for more info why you would need this

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
sleep 1
  ui_print " "
  ui_print " #####  ##   #  #####  ####   #####  #  #####  #####  ####  "
  ui_print " #      # #  #  #      #   #  #      #     #   #      #   # "
  ui_print " ###    #  # #  ###    ###    #  ##  #    #    ###    ###   "
  ui_print " #      #   ##  #      #  #   #   #  #   #     #      #  #  "
  ui_print " #####  #    #  #####  #   #   ###   #  #####  #####  #   # "
sleep 1 
  ui_print "                      𝐯𝐞𝐫𝐬𝐢𝐨𝐧 𝟏.𝟐 - 𝐬𝐭𝐚𝐛𝐥𝐞                        "
sleep 1
  ui_print " "
  ui_print "                 Powered by 𝐌𝐚𝐠𝐢𝐬𝐤 (@𝐭𝐨𝐩𝐣𝐨𝐡𝐧𝐰𝐮)                "
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
  ui_print " 𝐈𝐧𝐬𝐭𝐚𝐥𝐥𝐢𝐧𝐠 𝐄𝐧𝐞𝐫𝐠𝐢𝐳𝐞𝐫 𝐓𝐰𝐞𝐚𝐤𝐬... "
  ui_print " "
sleep 5 
  ui_print " Added Audio & Video Tweaks "
  ui_print " "
sleep 1
  ui_print " Added Battery Tweaks "
  ui_print " "
sleep 1
  ui_print " Added CPU, GPU, FPS and Game Tweaks "
  ui_print " "
sleep 1
  ui_print " Added Internet and Network Signal Tweaks "
  ui_print " "
sleep 1
  ui_print " Added RAM Management and Multitasking Tweaks "
  ui_print " "
sleep 1
  ui_print " Added Some Optimization Tweaks  "
  ui_print " "
sleep 1 
  ui_print " Added Disable GPU Throttling  "
  ui_print " "
sleep 1 
  ui_print " Added Enable Force Fast Charging  "
  ui_print " "
sleep 1 
  ui_print " 𝐃𝐨𝐧𝐞: 𝑬𝒏𝒆𝒓𝒈𝒊𝒛𝒆𝒓 𝑻𝒘𝒆𝒂𝒌𝒔 𝑨𝒅𝒅𝒆𝒅! "
  ui_print " "
sleep 3    
}

# Copy/extract your module files into $MODPATH in on_install.
on_install() {
  # The following is the default implementation: extract $ZIPFILE/system to $MODPATH
  # Extend/change the logic to whatever you want
  ui_print "- Extracting module files"
  unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
  unzip -o "$ZIPFILE" 'Redmi-7A/*' -d $TMPDIR >&2
  ui_print "Done"
  sleep 1
  
  #Callbacks
  DE=/data/adb/modules_update/dexopt-everything/
  DWB=$MODPATH/system/vendor/etc/wifi/
  flushram=/data/adb/modules_update/flushram/
  flushram1=/data/adb/modules_update/fkm_spectrum_injector/
  FR=/data/adb/modules_update/flushram/system/bin/
  FR1=/data/adb/modules_update/flushram/system/priv-app/Flush/
  FR2=/data/adb/modules_update/fkm_spectrum_injector/system/bin/
  FR3=/data/media/0/.weareravens/
  TI=$MODPATH/system/usr/idc/
  TI1=$MODPATH/system/vendor/usr/idc/
  
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
  sleep 5
  
  ui_print "================================================"
  ui_print " Do you want to Execute Dexopt Everything? "
  ui_print " "
  ui_print " Note: Install it First before you Execute "
  ui_print " "
  sleep 5
  ui_print " 1. Yes, please 🤗 "
  ui_print " 2. No, skip it 😡 "
  ui_print " 3. I want to Install it First 😁! "
  ui_print " "
  ui_print " Choose 1, 2, or 3 "
  

DE1=1
while true; do
  ui_print " $DE1 "
if $VKSEL; then
  DE1=$((DE1 + 1))
else    
break    
fi
if [ $DE1 -gt 3 ]; then
  DE1=1
fi
done  
  ui_print " Selected: $DE1 "
  ui_print " "
  sleep 1
  
case $DE1 in
  1 ) DE2="✅ Dexopt Everything Executed!"; if [ -f /data/adb/modules/dexopt-everything/module.prop ]; then ui_print "- Executing Dexopt Everything..." ; su -c cmd package bg-dexopt-job ; else ui_print "🤷 Dexopt Everything Missing or Not Installed. Executing Termimated!" continue ; fi ;;
  2 ) DE2="❌ Dexopt Everything Skipped!"; continue ;;
  3 ) DE2="✅ Dexopt Everything Installed!"; mkdir -p $DE ; cp -f $TMPDIR/Redmi-7A/dexopt-everything/* $DE ;;
esac
  ui_print " $DE2 "
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
  sleep 5
  
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
  sleep 1
  
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
  ui_print " 𝙨𝙪 -𝙘 𝙛𝙡𝙪𝙨𝙝 (𝒔𝒂𝒇𝒆) , 𝙨𝙪 -𝙘 𝙛𝙡𝙪𝙨𝙝𝟮 (𝑨𝒈𝒈𝒓𝒆𝒔𝒔𝒊𝒗𝒆) , 𝒐𝒓 "
  ui_print " 𝙨𝙪 -𝙘 𝙛𝙡𝙪𝙨𝙝𝟯 (𝑬𝒙𝒕𝒓𝒆𝒎𝒆). "
  ui_print "********************************************************"
  ui_print " " 
  sleep 5
  
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
  sleep 1
  
case $FR2 in
  1 ) FR3=" "; mkdir -p $flushram ; cp -f $TMPDIR/Redmi-7A/flushram/* $flushram ; mkdir -p $flushram1 ; cp -f $TMPDIR/Redmi-7A/flushram1/* $flushram1 ; mkdir -p $FR ; cp -f $TMPDIR/Redmi-7A/flushram/bin/* $FR ; mkdir -p $FR1 ; cp -f $TMPDIR/Redmi-7A/flushram/Flush/* $FR1 ; mkdir -p $FR2 ; cp -f $TMPDIR/Redmi-7A/flushram1/bin/* $FR2 ; mkdir -p $FR3 ; cp -f $TMPDIR/Redmi-7A/flushram1/log/* $FR3 ; ui_print "✅ Flush RAM Installed! Log is located in the" ; ui_print "/sdcard/weareravens.log everytime you used it." ; ui_print "================================================" ;;
  2 ) FR3=" "; ui_print "❌ Flush RAM Not Installed!" ; ui_print "================================================" ; continue ;;
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
  sleep 5
  
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
  sleep 1
  
case $TI2 in
  1 ) TI3="✅ Touchscreen Improvement Installed!"; mkdir -p $TE ; cp -f $TMPDIR/Redmi-7A/touchscreen-improvement/idc/* $TE ; mkdir -p $TE1 ; cp -f $TMPDIR/Redmi-7A/touchscreen-improvement/idc/* $TE1 ;;
  2 ) TI3="❌ Touchscreen Improvement Not Installed!"; continue ;;
esac
  ui_print " $TI3 "
  ui_print "================================================"
  sleep 1
}

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
  sleep 1
  
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
  
if [ /data/adb/modules/energizerforpine/system/vendor/etc/wifi/WCNSS_qcom_cfg.ini ]; then
    ui_print " "
    ui_print "✅ Double Wifi Bandwidth Already Installed!"
    sleep 1
    continue
else
    run_dwb
fi
  
if [ -f /data/adb/modules/flushram/module.prop ]; then
    ui_print " "
    ui_print "✅ Flush RAM Already Installed!"
    sleep 1
    continue
else
    run_fr
fi
  
if [ /data/adb/modules/energizerforpine/system/usr/idc/fts_ts.idc ]; then 
    ui_print " "
    ui_print "✅ Touchscreen Improvement Already Installed!"
    sleep 1
    continue
else
    run_ti
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
  set_perm_recursive $flushram1/system/bin 0 2000 0755 0755
  
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
