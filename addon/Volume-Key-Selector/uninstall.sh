# External Tools

chmod -R 0755 $TMPDIR/addon/Volume-Key-Selector/tools
export PATH=$TMPDIR/addon/Volume-Key-Selector/tools/$ARCH32:$PATH

keytest() {
  ui_print " "
  ui_print "***************************************"
  ui_print "    🔉 𝙋𝙧𝙚𝙨𝙨 𝙖 𝙑𝙤𝙡𝙪𝙢𝙚 𝙆𝙚𝙮 𝘁𝗼 𝗖𝗼𝗻𝘁𝗶𝗻𝘂𝗲 "
  ui_print "***************************************"
  if (timeout 60 /system/bin/getevent -lc 1 2>&1 | /system/bin/grep VOLUME | /system/bin/grep " DOWN" > $TMPDIR/events); then
    return 0
  else
    ui_print "***************************************"
    ui_print "            ⁉️ 𝙏𝙧𝙮 𝘼𝙜𝙖𝙞𝙣: "
    ui_print "***************************************"
    timeout 60 keycheck
    local SEL=$?
    ui_print "***************************************"
    [ $SEL -eq 143 ] && abort "      ⚠️ 𝙑𝙤𝙡𝙪𝙢𝙚 𝙆𝙚𝙮 𝙉𝙤𝙩 𝘿𝙚𝙩𝙚𝙘𝙩𝙚𝙙! " || return 1
    ui_print "***************************************"
  fi
}

chooseport() {
  # Original idea by chainfire @xda-developers, improved on by ianmacd @xda-developers
  #note from chainfire @xda-developers: getevent behaves weird when piped, and busybox grep likes that even less than toolbox/toybox grep
  while true; do
    /system/bin/getevent -lc 1 2>&1 | /system/bin/grep VOLUME | /system/bin/grep " DOWN" > $TMPDIR/events
    if (`cat $TMPDIR/events 2>/dev/null | /system/bin/grep VOLUME >/dev/null`); then
      break
    fi
  done
  if (`cat $TMPDIR/events 2>/dev/null | /system/bin/grep VOLUMEUP >/dev/null`); then
    return 0
  else
    return 1
  fi
}

chooseportold() {
  # Keycheck binary by someone755 @Github, idea for code below by Zappo @xda-developers
  # Calling it first time detects previous input. Calling it second time will do what we want
  while true; do
    keycheck
    keycheck
    local SEL=$?
    if [ "$1" == "UP" ]; then
      UP=$SEL
      break
    elif [ "$1" == "DOWN" ]; then
      DOWN=$SEL
      break
    elif [ $SEL -eq $UP ]; then
      return 0
    elif [ $SEL -eq $DOWN ]; then
      return 1
    fi
  done
}

# Have user option to skip vol keys
OIFS=$IFS; IFS=\|; MID=false; NEW=false
case $(echo $(basename $ZIPFILE) | tr '[:upper:]' '[:lower:]') in
  *novk*) ui_print "- Skipping Vol Keys -";;
  *) if keytest; then
       VKSEL=chooseport
     else
       VKSEL=chooseportold
       ui_print "  ! Legacy device detected! Using old keycheck method"
       ui_print " "
       ui_print "- Vol Key Programming -"
       ui_print "  Press Vol Up Again:"
       $VKSEL "UP"
       ui_print "  Press Vol Down"
       $VKSEL "DOWN"
     fi;;
esac
IFS=$OIFS
