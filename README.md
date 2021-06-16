# Energizer for Redmi 7A

## preparetodietm @ [energizerforpine](https://t.me/energizerforpine)

## What is Energizer?

- **Energizer** is a collection of tweaks that can boost your ROM/GSI and picked the best magisk module for your Redmi 7A phone. 

## The Best Partner Kernel of Energizer for Redmi 7A ()
- [Lilac Kernel](https://github.com/dlwlrma123/kernel_lilac_sdm439) - [Soon]()

## Requirements:

- Android 9-11
- Magisk 20.4+

## Notes:

**FOR XIAOMI REDMI 7A (pine) DEVICES ONLY!**

1. This module needs [Busybox for Android NDK](https://github.com/Magisk-Modules-Repo/busybox-ndk) in Magisk Manager or [Brutal Busybox](https://github.com/feravolt/Brutal_busybox) to worked on your Redmi 7A Phone.
2. If you put some _tweaks_ on your **system/build.prop** similar to the features of Energizer, remove them and restart your device then install this module.
3. Do not install any _Magisk Module_ related to the **features of Energizer**.

## Installation:

1. Flash
2. Select the desired options on the volume key selector
3. Reboot
4. Enjoy!

**If you want to _uninstall_ the module, just flash it again.**

## Features:

**Audio & Video Tweaks:**

- Better Call Voice Quality
- Improves Video Recording Quality
- Media Enhancer [codecs]
- Stream Videos Faster
- Video Acceleration Enabled

**Battery Tweaks:**
- Save More Battery Power
- Smart Charging

**CPU, GPU, FPS and Game Tweaks:**
- Control Gaming FPS
- CPU & GPU Tweaks
- Disable Dynamic Refresh Rate
- Disable VSYNC for CPU Rendered Apps
- Enable Game Colocation Feature
- FPS 
- FPS Stabilizer
- FPS Tuner
- Game Mode for CPU
- Improve Gaming Experience
- Surface Flinger
- System FPS

**Internet and Network Signal Tweaks:**
- 4G and 3G Tweaks
- Better Internet Speed
- Better Network Signals
- Boost Signal
- Disable IPv6
- Signal Performance

**RAM Management and Multitasking Tweaks:**
- Better RAM Management
- Disable memplus prefetcher which ram-boost relying on, use traditional swapping
- Free More RAM
- LMKD Props
- Remain Launcher

**Some Optimization Tweaks:**
- 10bit Color Mode
- Camera2API
- Disable Quality Control
- Graphics Tweaks
- Kernel Tweaks
- Optimization Tweaks
- Performance Tweaks
- Phone Call Ring Faster
- Picture Quality Enhancer
- Qualcomm Tweaks
- Sdcard Speed Tweaks
- Smoothens UI
- SOD Mode
- System Tweaks
- ZRAM Tweaks

**Dexopt Everything**

**Disable GPU Throttling**

**Double Wifi Bandwidth**

**Enable Force Fast Charging**

**Flush RAM**

**Touchscreen Improvement**

## How to use?

**Dexopt Everything**
- Dexopt is a system-internal tool that is used to produce optimized dex files by using `su -c cmd package bg-dexopt-job` code.

**Disable GPU Throttling**
- Disable GPU Throttling to fix some fps drop while playing games.

**Double Wifi Bandwidth**
- Doubles your wifi bandwith by modifying WNCSS_qcom_cfg.ini

**Enable Force Fast Charging**
- It's enable force fast charging on your Redmi 7A devices.

**Flush RAM**
- Clear RAM apps caches, kill all apps, and force stop all apps to get more free RAM before playing games.
  
Terminal Emulator/Termux command:
- `su -c flush` (Safe Mode) - kill all running apps in backround.
- `su -c flush2` (Aggressive Mode) - force stop all background & foreground 3rd party apps.        
- `su -c flush3` (Extreme Mode) - force stop all backgrounds, foreground 3rd party, and system apps.
- `su -c flush4` (Most Extreme Mode) - force stop all backgrounds and foreground apps from [config list](https://raw.githubusercontent.com/preparetodietm/energizerforpine/main/Redmi-7A/flushram1/log/weareravens_flush.conf).

**Touchscreen Improvement**
- A tweaks for touchsreen "fts_ts" for Redmi 7A devices.

## Credits:

- [AkiraNoSushi](https://github.com/AkiraNoSushi) for his Enable Force Fast Charging Module
- [dlwlrma1](https://github.com/dlwlrma123) for Giving Dexopt Everything to me
- [WeAreRavens](https://t.me/WeAreRavenS) for Flush RAM and Touchscreen Improvement
