#######################################################################################
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
  sleep 0.5
  ui_print "                    𝗘𝗻𝗲𝗿𝗴𝗶𝘇𝗲𝗿 𝗳𝗼𝗿 𝗥𝗲𝗱𝗺𝗶 𝟳𝗔⚡                  "
  sleep 0.5
  ui_print "                       by @𝐩𝐫𝐞𝐩𝐚𝐫𝐞𝐭𝐨𝐝𝐢𝐞𝐭𝐦                      "
  sleep 0.5
  ui_print " "
  sleep 0.5
  ui_print "  ###    ####    ###    ###    ###   #  ####    ###    ###  "
  sleep 0.5
  ui_print " #      #    #  #      #   #  #      #     #   #      #   # "
  sleep 0.5
  ui_print " ###    #    #  ###    ###    # ##   #    #    ###    ###   "
  sleep 0.5
  ui_print " #      #    #  #      #  #   #   #  #   #     #      #  #  "
  sleep 0.5
  ui_print "  ###   #    #   ###   #   #   ###   #   ####   ###   #   # "
  sleep 0.5
  ui_print "                      𝐯𝐞𝐫𝐬𝐢𝐨𝐧 𝟐.𝟎 - 𝐬𝐭𝐚𝐛𝐥𝐞                      "
  sleep 0.5
  ui_print " "
  sleep 0.5
  ui_print "                 Powered by 𝐌𝐚𝐠𝐢𝐬𝐤 (@𝐭𝐨𝐩𝐣𝐨𝐡𝐧𝐰𝐮)               "
  sleep 0.5
  ui_print "************************************************************"
  sleep 0.5
  ui_print " Phone Model: $(getprop ro.product.vendor.model)"
  sleep 0.25
  ui_print " System Version: Android "$(getprop ro.system.build.version.release)""
  sleep 0.25
  ui_print " System Structure: "$ARCH" "
  sleep 0.25
  ui_print " Build Type: Stable "
  ui_print " "
  sleep 0.5
}

# Copy/extract your module files into $MODPATH in on_install.
on_install() {
  # The following is the default implementation: extract $ZIPFILE/system to $MODPATH
  # Extend/change the logic to whatever you want
  ui_print "- Extracting module files"
  sleep 1
  unzip -o "$ZIPFILE" 'system/*' -d "$MODPATH" >&2
  unzip -o "$ZIPFILE" 'Redmi-7A/*' -d "$TMPDIR" >&2
  ui_print "Done"
  sleep 0.5

  # Callbacks
  DWB="$MODPATH"/system/vendor/etc/wifi/
  E=/data/media/0/Energizer/
  EB="$E"/boot
  EL="$E"/energizer.logs
  EP="$E"/energizer.profile
  GM="$E"/gaming-mode
  RAM="$(free | awk '/Mem:/{ byte =$2 /1024000 ; print int(byte+0.5) " GB" }')"
  TI="$MODPATH"/system/usr/idc/
  TI1="$MODPATH"/system/vendor/usr/idc/

  # $MODPATH Callbacks
  MP=/data/adb/modules/energizerforpine
  DSP2="$MP"/dexopt_speed_profile
  DWB1="$MP"/system/vendor/etc/wifi/WCNSS_qcom_cfg.ini
  TI4="$MP"/system/usr/idc/fts_ts.idc
  TI5="$MP"/system/vendor/usr/idc/fts_ts.idc
  WF2="$MP"/wifi_fixes

  # Create Energizer Sdcard Path
  mkdir -p "$E"
  mkdir -p "$EB"
  mkdir -p "$GM"

  # Functions
  getprop() {
    grep_prop "$1" "$EP"
  }

  print() {
	ui_print "$1"
  }

  sedlogs() {
    print "[Processing...] ••> $1 [$(date '+%d/%m/%Y %H:%M:%S')]" >> "$EL"
    print "[✓ Success]" >> "$EL"
  }

  # V-K-S Features
  run_dsp() {
    ui_print " "
    ui_print "************************************************************"
    ui_print "   𝐖𝐡𝐚𝐭 𝐢𝐬 𝐃𝐞𝐱𝐨𝐩𝐭 𝐒𝐩𝐞𝐞𝐝 𝐏𝐫𝐨𝐟𝐢𝐥𝐞? "
    ui_print " "
    ui_print "   𝑫𝒆𝒙𝒐𝒑𝒕 𝒊𝒔 𝒂 𝒔𝒚𝒔𝒕𝒆𝒎-𝒊𝒏𝒕𝒆𝒓𝒏𝒂𝒍 𝒕𝒐𝒐𝒍 𝒕𝒉𝒂𝒕 𝒊𝒔 𝒖𝒔𝒆𝒅 𝒕𝒐 𝒑𝒓𝒐𝒅𝒖𝒄𝒆 𝒐𝒑𝒕𝒊𝒎𝒊𝒛𝒆𝒅 𝒅𝒆𝒙 "
    ui_print "   𝒇𝒊𝒍𝒆𝒔 𝒃𝒚 𝒖𝒔𝒊𝒏𝒈 𝒔𝒖 -𝒄 𝒄𝒎𝒅 𝒑𝒂𝒄𝒌𝒂𝒈𝒆 𝒃𝒈-𝒅𝒆𝒙𝒐𝒑𝒕-𝒋𝒐𝒃 𝒄𝒐𝒅𝒆. "
    ui_print "************************************************************"
    ui_print " "
    ui_print "============================================================"
    ui_print "   Do you want to install Dexopt Speed Profile? "
    ui_print " "
    ui_print "   1. Yes, please 🤗 "
    ui_print "   2. No, skip it 😡 "
    ui_print " "
    ui_print "   Choose 1 or 2 "
    DSP=1
    while true; do
      ui_print "   $DSP "
      if "$VKSEL"; then
        DSP="$((DSP + 1))"
      else
        break
      fi
      if [ "$DSP" -gt 2 ]; then
        DSP=1
      fi
    done
    ui_print "   Selected: $DSP "
    ui_print " "
    sleep 0.5  
    case "$DSP" in
      1) DSP1="✅ Dexopt Speed Profile Installed!"; sed -i 's/#Dexopt_Speed_Profile/pm.dexopt.ab-ota speed-profile/g' "$TMPDIR"/system.prop ; sed -i 's/#DSP_one/pm.dexopt.bg-dexopt speed-profile/g' "$TMPDIR"/system.prop ; sed -i 's/#DSP_two/pm.dexopt.boot verify/g' "$TMPDIR"/system.prop ; sed -i 's/#DSP_three/pm.dexopt.core-app speed/g' "$TMPDIR"/system.prop ; sed -i 's/#DSP_four/pm.dexopt.first-boot quicken/g' "$TMPDIR"/system.prop ; sed -i 's/#DSP_five/pm.dexopt.forced-dexopt speed/g' "$TMPDIR"/system.prop ; sed -i 's/#DSP_six/pm.dexopt.install speed-profile/g' "$TMPDIR"/system.prop ; sed -i 's/#DSP_seven/pm.dexopt.nsys-library speed/g' "$TMPDIR"/system.prop ; sed -i 's/#DSP_eight/pm.dexopt.shared-apk speed/g' "$TMPDIR"/system.prop ; echo dexopt_speed_profile > "$MODPATH"/dexopt_speed_profile ;;
      2) DSP1="❌ Dexopt Speed Profile Skipped!"; continue ;;
    esac
    ui_print "   $DSP1 "
    ui_print "============================================================"
    sleep 1
  }

  DWB4() {
    [ -x "$(which magisk)" ] && MIRRORPATH="$(magisk --path)/.magisk/mirror" || unset MIRRORPATH
    DWB5="$(find /system /vendor -type f -name WCNSS_qcom_cfg.ini)"
    for FINDDWB in "$DWB5"; do
      [[ -f "$FINDDWB" ]] && [[ ! -L "$FINDDWB" ]] && {
      DWBPATH="$FINDDWB"
      mkdir -p "$DWB"
      cp -af "$MIRRORPATH""$DWBPATH" "$MODPATH"/system/"$DWBPATH"
      sed -i '/gChannelBondingMode24GHz=/d;/gChannelBondingMode5GHz=/d;/gForce1x1Exception=/d;s/^END$/gChannelBondingMode24GHz=1\ngForce1x1Exception=0\nEND/g' "$MODPATH"/system/"$DWBPATH"
      }
    done
  }

  run_dwb() {
    ui_print " "
    ui_print "************************************************************"
    ui_print "   𝐖𝐡𝐚𝐭 𝐢𝐬 𝐃𝐨𝐮𝐛𝐥𝐞 𝐖𝐢𝐟𝐢 𝐁𝐚𝐧𝐝𝐰𝐢𝐭𝐡? "
    ui_print " "
    ui_print "   𝑫𝒐𝒖𝒃𝒍𝒆𝒔 𝒚𝒐𝒖𝒓 𝒘𝒊𝒇𝒊 𝒃𝒂𝒏𝒅𝒘𝒊𝒅𝒕𝒉 𝒃𝒚 𝒎𝒐𝒅𝒊𝒇𝒚𝒊𝒏𝒈 𝑾𝑪𝑵𝑺𝑺_𝒒𝒄𝒐𝒎_𝒄𝒇𝒈.𝒊𝒏𝒊 "
    ui_print "************************************************************"
    ui_print " "
    ui_print "============================================================"
    ui_print "   Do you want to install Double Wifi Bandwidth? "
    ui_print " "
    ui_print "   1. Yes, please 🤗 "
    ui_print "   2. No, I don't need it 😡 "
    ui_print " "
    ui_print "   Choose 1 or 2 "
    DWB2=1
    while true; do
      ui_print "   $DWB2 "
      if "$VKSEL"; then
        DWB2="$((DWB2 + 1))"
      else
        break
      fi
      if [ "$DWB2" -gt 2 ]; then
        DWB2=1
      fi
    done
    ui_print "   Selected: $DWB2 "
    ui_print " "
    sleep 0.5
    case "$DWB2" in
      1) DWB3="✅ Double Wifi Bandwidth Installed!"; DWB4 ;;
      2) DWB3="❌ Double Wifi Bandwidth Not Installed!"; continue ;;
    esac
    ui_print "   $DWB3 "
    ui_print "============================================================"
    sleep 1
  }

  run_ti() {
    ui_print " "
    ui_print "************************************************************"
    ui_print "   𝐖𝐡𝐚𝐭 𝐢𝐬 𝐓𝐨𝐮𝐜𝐡𝐬𝐫𝐞𝐞𝐧 𝐈𝐦𝐩𝐫𝐨𝐯𝐞𝐦𝐞𝐧𝐭? "
    ui_print " "
    ui_print "   𝑨 𝒕𝒘𝒆𝒂𝒌𝒔 𝒇𝒐𝒓 𝒕𝒐𝒖𝒄𝒉𝒔𝒓𝒆𝒆𝒏 "𝒇𝒕𝒔_𝒕𝒔" 𝒇𝒐𝒓 𝑹𝒆𝒅𝒎𝒊 7𝑨 𝒅𝒆𝒗𝒊𝒄𝒆𝒔. "
    ui_print "************************************************************"
    ui_print " "
    ui_print "============================================================"
    ui_print "   Do you want to install Touchscreen Improvement? "
    ui_print " "
    ui_print "   1. Yes, please 🤗 "
    ui_print "   2. No, I don't need it 😡 "
    ui_print " "
    ui_print "   Choose 1 or 2 "
    TI2=1
    while true; do
      ui_print "   $TI2 "
      if "$VKSEL"; then
        TI2="$((TI2 + 1))"
      else
        break
      fi
      if [ "$TI2" -gt 2 ]; then
        TI2=1
      fi
    done
    ui_print "   Selected: $TI2 "
    ui_print " "
    sleep 0.5
    case "$TI2" in
      1) TI3="✅ Touchscreen Improvement Installed!"; mkdir -p "$TI" ; cp -af "$TMPDIR"/Redmi-7A/touchscreen-improvement/idc/* "$TI" ; mkdir -p "$TI1" ; cp -af "$TMPDIR"/Redmi-7A/touchscreen-improvement/idc/* "$TI1" ;;
      2) TI3="❌ Touchscreen Improvement Not Installed!"; continue ;;
    esac
    ui_print "   $TI3 "
    ui_print "============================================================"
    sleep 1
  }

  run_wf() {
    ui_print " "
    ui_print "************************************************************"
    ui_print "   𝐖𝐡𝐚𝐭 𝐢𝐬 𝐖𝐢𝐟𝐢 𝐅𝐢𝐱𝐞𝐬? "
    ui_print " "
    ui_print "   𝑭𝒊𝒙 𝒘𝒊𝒇𝒊 𝒏𝒐𝒕 𝒘𝒐𝒓𝒌𝒊𝒏𝒈 𝒂𝒇𝒕𝒆𝒓 𝒇𝒍𝒂𝒔𝒉𝒊𝒏𝒈 𝒌𝒆𝒓𝒏𝒆𝒍 𝒂𝒏𝒅 𝒃𝒐𝒐𝒕𝒆𝒅 𝒕𝒐 𝒔𝒚𝒔𝒕𝒆𝒎. "
    ui_print "   𝑰𝒏𝒔𝒕𝒂𝒍𝒍 𝒐𝒏𝒍𝒚 𝒊𝒇 𝒚𝒐𝒖 𝒏𝒆𝒆𝒅 𝒊𝒕! "
    ui_print "************************************************************"
    ui_print " "
    ui_print "============================================================"
    ui_print "   Do you want to install Wifi Fixes? "
    ui_print " "
    ui_print "   1. Yes, please 🤗 "
    ui_print "   2. No, I don't need it 😡 "
    ui_print " "
    ui_print "   Choose 1 or 2 "
    WF=1
    while true; do
      ui_print "   $WF "
      if "$VKSEL"; then
        WF="$((WF + 1))"
      else
        break
      fi
      if [ "$WF" -gt 2 ]; then
        WF=1
      fi
    done
    ui_print "   Selected: $WF "
    ui_print " "
    sleep 0.5
    case "$WF" in
      1) WF1="✅ Wifi Fixes Installed!"; sed -i 's/#WifiFixes/# Wifi Fixes/g' "$TMPDIR"/service.sh ; sed -i 's+#WF_one+if [ -e /sys/module/wlan/parameters/fwpath ]; then+g' "$TMPDIR"/service.sh ; sed -i 's+#WF_two+  echo "sta" > /sys/module/wlan/parameters/fwpath+g' "$TMPDIR"/service.sh ; sed -i 's/#WF_three/fi/g' "$TMPDIR"/service.sh ; sed -i 's/#WF_four/# by SdkPt/g' "$TMPDIR"/service.sh ; echo wifi_fixes > "$MODPATH"/wifi_fixes ;;
      2) WF1="❌ Wifi Fixes Not Installed!"; sed -i '/#1/d' "$TMPDIR"/service.sh ; sed -i '/#WifiFixes/d' "$TMPDIR"/service.sh ; sed -i '/#WF_one/d' "$TMPDIR"/service.sh ; sed -i '/#WF_two/d' "$TMPDIR"/service.sh ; sed -i '/#WF_three/d' "$TMPDIR"/service.sh ; sed -i '/#WF_four/d' "$TMPDIR"/service.sh ;;
    esac
    ui_print "   $WF1 "
    ui_print "============================================================"
    sleep 1
  }

  # Detect and Choose 2GB or 3GB RAM
  ram2gb() {
    sed -i 's/#RAM_2or3/dalvik.vm.execution-mode=int:fast/g' "$TMPDIR"/system.prop
    sed -i 's/#RAM_one/dalvik.vm.heapgrowthlimit=128m/g' "$TMPDIR"/system.prop
    sed -i 's/#RAM_two/dalvik.vm.heapmaxfree=8m/g' "$TMPDIR"/system.prop
    sed -i 's/#RAM_three/dalvik.vm.heapminfree=2m/g' "$TMPDIR"/system.prop
    sed -i 's/#RAM_four/dalvik.vm.heapsize=512m/g' "$TMPDIR"/system.prop
    sed -i 's/#RAM_five/dalvik.vm.heapstartsize=8m/g' "$TMPDIR"/system.prop
    sed -i 's/#RAM_six/dalvik.vm.heaptargetutilization=0.75/g' "$TMPDIR"/system.prop
  }

  ram3gb() {
    sed -i 's/#RAM_2or3/dalvik.vm.execution-mode=int:fast/g' "$TMPDIR"/system.prop
    sed -i 's/#RAM_one/dalvik.vm.heapgrowthlimit=192m/g' "$TMPDIR"/system.prop
    sed -i 's/#RAM_two/dalvik.vm.heapmaxfree=8m/g' "$TMPDIR"/system.prop
    sed -i 's/#RAM_three/dalvik.vm.heapminfree=6m/g' "$TMPDIR"/system.prop
    sed -i 's/#RAM_four/dalvik.vm.heapsize=512m/g' "$TMPDIR"/system.prop
    sed -i 's/#RAM_five/dalvik.vm.heapstartsize=14m/g' "$TMPDIR"/system.prop
    sed -i 's/#RAM_six/dalvik.vm.heaptargetutilization=0.75/g' "$TMPDIR"/system.prop
  }

  if [ "$RAM" == "2 GB" ]; then
    ram2gb
  else
    ram3gb
  fi

  # Fix UI Glitches
  # Remove props that causes UI Glitches in /system/build.prop
  SYSBP() {
    #!/system/bin/sh

    SBP=/system/build.prop
    mount -o remount,rw /
    mount -o remount,rw /system
    remount

    sed -i '/debug.egl.hw=1/d' "$SBP"
    sed -i '/debug.sf.hw=1/d' "$SBP"
    sed -i '/debug.sf.latch_unsignaled=1/d' "$SBP"
    sed -i '/debug.egl.hw=0/d' "$SBP"
    sed -i '/debug.sf.hw=0/d' "$SBP"
    sed -i '/debug.sf.latch_unsignaled=0/d' "$SBP"

    mount -o remount,ro /
    mount -o remount,ro /system
    sync
  }

  SYSBP

  # Remove props that causes UI Glitches and Remove LMKD Props Tweaks + Add Energizer Additional Props in /vendor/build.prop + Backup Original Vendor build.prop
  VENBP() {
    #!/system/bin/sh

    VBP=/vendor/build.prop
    mount -o remount,rw /
    mount -o remount,rw /vendor
    remount

    # Remove UI Glitches Props
    cp -af "$VBP" /vendor/build.prop.bak
    sed -i '/debug.egl.hw=1/d' "$VBP"
    sed -i '/debug.sf.hw=1/d' "$VBP"
    sed -i '/debug.sf.latch_unsignaled=1/d' "$VBP"
    sed -i '/debug.egl.hw=0/d' "$VBP"
    sed -i '/debug.sf.hw=0/d' "$VBP"
    sed -i '/debug.sf.latch_unsignaled=0/d' "$VBP"

    # Remove LMKD Props Tweaks in /vendor/build.prop
    sed -i '/ro.lmk.kill_heaviest_task=true/d' "$VBP"
    sed -i '/ro.lmk.kill_timeout_ms=100/d' "$VBP"
    sed -i '/ro.lmk.use_psi=true/d' "$VBP"
    sed -i '/ro.lmk.psi_partial_stall_ms=200/d' "$VBP"
    sed -i '/ro.lmk.thrashing_limit=30/d' "$VBP"
    sed -i '/ro.lmk.thrashing_limit_decay=50/d' "$VBP"
    sed -i '/ro.lmk.swap_util_max=100/d' "$VBP"
    sed -i '/ro.lmk.swap_free_low_percentage=10/d' "$VBP"

    # Add Energizer Additional Tweaks
    sed -i '/persist.vendor.radio.apm_sim_not_pwdn=1/d' "$VBP"
    sed -i -e '$apersist.vendor.radio.apm_sim_not_pwdn=1' "$VBP"
    sed -i 's/persist.vendor.radio.custom_ecc=1/d' "$VBP"
    sed -i -e '$apersist.vendor.radio.custom_ecc=1' "$VBP"
    sed -i 's/persist.vendor.radio.VT_HYBRID_ENABLE=1/d' "$VBP"
    sed -i -e '$apersist.vendor.radio.VT_HYBRID_ENABLE=1' "$VBP"
    sed -i 's/ro.hardware.keystore_desede=true/d' "$VBP"
    sed -i -e '$aro.hardware.keystore_desede=true' "$VBP"
    sed -i 's/vendor.display.comp_mask=0/d' "$VBP"
    sed -i -e '$avendor.display.comp_mask=0' "$VBP"
    sed -i 's/vendor.display.enable_default_color_mode=1/d' "$VBP"
    sed -i -e '$avendor.display.enable_default_color_mode=1' "$VBP"
    sed -i 's/vendor.display.enable_optimize_refresh=1/d' "$VBP"
    sed -i -e '$avendor.display.enable_optimize_refresh=1' "$VBP"

    mount -o remount,ro /
    mount -o remount,ro /vendor
    sync
  }

  VENBP

  # Copy Energizer files to sdcard path
  sedlogs "Copying gaming_mode_list to Energizer Sdcard Directory"
  cp -af "$TMPDIR"/Redmi-7A/energizer/gaming_mode_list "$GM"
  sedlogs "Copying gaming_mode.txt to Energizer Sdcard Directory"
  cp -af "$TMPDIR"/Redmi-7A/energizer/gaming_mode.txt "$GM"
  sedlogs "Adding dpi file to Energizer Sdcard Directory"
  echo 295 > "$E"/dpi
  sedlogs "Adding screen_resolution file to Energizer Sdcard Directory"
  echo 720x1440 > "$E"/screen_resolution

  # Choose what features you want to be included on this module.
  . "$TMPDIR"/addon/Volume-Key-Selector/preinstall.sh
  ui_print " "
  ui_print "         𝐍𝐨𝐭𝐞: 𝑽𝒐𝒍𝒖𝒎𝒆 𝑼𝒑 = 𝑪𝒉𝒐𝒐𝒔𝒆 "
  ui_print "              𝑽𝒐𝒍𝒖𝒎𝒆 𝑫𝒐𝒘𝒏= 𝑺𝒆𝒍𝒆𝒄𝒕 "
  ui_print " "
  ui_print "================================================"
  ui_print "   𝗖𝗵𝗼𝗼𝘀𝗲 𝘄𝗵𝗮𝘁 𝘆𝗼𝘂 𝘄𝗮𝗻𝘁 𝘁𝗼 𝗶𝗻𝘀𝘁𝗮𝗹𝗹 𝗼𝗻 𝘆𝗼𝘂𝗿 𝗣𝗵𝗼𝗻𝗲!   "
  ui_print "================================================"
  sleep 2

  run_detection() {
    ui_print " "
    ui_print "- Detecting if other tweaks are installed..."
    sleep 5
  }

  # Print Detection
  if [ -f "$MP"/module.prop ]; then
    run_detection
  else
    continue
  fi

  # Detect all installed features and will be added to module updates
  # Dexopt Speed Profile
  if [ -e "$DSP2" ]; then
    ui_print " "
    ui_print "✅ Dexopt Speed Profile Already Installed!"
    sed -i 's/#Dexopt_Speed_Profile/pm.dexopt.ab-ota speed-profile/g' "$TMPDIR"/system.prop
    sed -i 's/#DSP_one/pm.dexopt.bg-dexopt speed-profile/g' "$TMPDIR"/system.prop
    sed -i 's/#DSP_two/pm.dexopt.boot verify/g' "$TMPDIR"/system.prop
    sed -i 's/#DSP_three/pm.dexopt.core-app speed/g' "$TMPDIR"/system.prop
    sed -i 's/#DSP_four/pm.dexopt.first-boot quicken/g' "$TMPDIR"/system.prop
    sed -i 's/#DSP_five/pm.dexopt.forced-dexopt speed/g' "$TMPDIR"/system.prop
    sed -i 's/#DSP_six/pm.dexopt.install speed-profile/g' "$TMPDIR"/system.prop
    sed -i 's/#DSP_seven/pm.dexopt.nsys-library speed/g' "$TMPDIR"/system.prop
    sed -i 's/#DSP_eight/pm.dexopt.shared-apk speed/g' "$TMPDIR"/system.prop
    echo dexopt_speed_profile > "$MODPATH"/dexopt_speed_profile
    sleep 0.5
  else
    run_dsp
  fi

  # Double Wifi Bandwidth
  if [ -f "$DWB1" ]; then
    ui_print " "
    ui_print "✅ Double Wifi Bandwidth Already Installed!"
    mkdir -p "$DWB"
    cp -af "$DWB1" "$DWB"
    sleep 0.5
  else
    run_dwb
  fi

  # Touchscreen Improvement
  if [ -f "$TI4" ] || [ -f "$TI5" ]; then
    ui_print " "
    ui_print "✅ Touchscreen Improvement Already Installed!"
    mkdir -p "$TI"
    cp -f "$TMPDIR"/Redmi-7A/touchscreen-improvement/idc/* "$TI"
    mkdir -p "$TI1" ; cp -f $TMPDIR/Redmi-7A/touchscreen-improvement/idc/* "$TI1"
    sleep 0.5
  else
    run_ti
  fi

  # Wifi Fixes
  if [ -e "$WF2" ]; then
    ui_print " "
    ui_print "✅ Wifi Fixes Already Installed!"
    sed -i 's/#WifiFixes/# Wifi Fixes/g' "$TMPDIR"/service.sh
    sed -i 's+#WF_one+if [ -e /sys/module/wlan/parameters/fwpath ]; then+g' "$TMPDIR"/service.sh
    sed -i 's+#WF_two+  echo "sta" > /sys/module/wlan/parameters/fwpath+g' "$TMPDIR"/service.sh
    sed -i 's/#WF_three/fi/g' "$TMPDIR"/service.sh
    sed -i 's/#WF_four/# by SdkPt/g' "$TMPDIR"/service.sh
    echo wifi_fixes > "$MODPATH"/wifi_fixes
    sleep 0.5
  else
    run_wf
  fi
}

# Only some special files require specific permissions
# This function will be called after on_install is done
# The default permissions should be good enough for most cases
set_permissions() {
  # The following is the default rule, DO NOT remove
  set_perm_recursive "$MODPATH" 0 0 0755 0644

  # Energizer Permissions
  set_perm "$MODPATH"/system/bin/energizer 0 0 0755
  set_perm "$MODPATH"/system/xbin/boot_patch.sh 0 0 0755
  set_perm "$MODPATH"/system/xbin/magiskboot 0 0 0755
  set_perm "$MODPATH"/system/build.prop 0 0 0600
  set_perm "$MODPATH"/system/vendor/build.prop 0 0 0600

  # Here are some examples:
  # set_perm_recursive  $MODPATH/system/lib       0     0       0755      0644
  # set_perm  $MODPATH/system/bin/app_process32   0     2000    0755      u:object_r:zygote_exec:s0
  # set_perm  $MODPATH/system/bin/dex2oat         0     2000    0755      u:object_r:dex2oat_exec:s0
  # set_perm  $MODPATH/system/lib/libart.so       0     0       0644
}

# You can add more functions to assist your custom script code
finale() {
  ui_print " "
  ui_print " My Energizer Github  : https://github.com/preparetodietm/energizerforpine"
  sleep 0.25
  ui_print " My Telegram Account  : https://t.me/preparetodietm"
  sleep 0.25
  ui_print " My Telegram Group    : https://t.me/energizerforpine"
  sleep 0.25
  ui_print " My Youtube Channel   : https://youtube.com/channel/UCbDEvgpYWmxK9uXhQ3-LtQw"
  sleep 0.25
  ui_print " "
  ui_print "                    𝗘𝗻𝗲𝗿𝗴𝗶𝘇𝗲𝗿 𝗳𝗼𝗿 𝗥𝗲𝗱𝗺𝗶 𝟳𝗔 ⚡"
  sleep 0.25
  ui_print "                  All Rights Reserved © 2021"
  ui_print " "
  ui_print " "
  ui_print " "
  ui_print " "
  ui_print " "
}

#=========================================================================================
# End of install.sh
# Modified by @preparetodietm
#=========================================================================================
