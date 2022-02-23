<h1 align="center"> Energizer for Redmi 7A ⚡<br/>
<img src="https://img.shields.io/badge/Version-2.1-blue.svg">
</h1>
<p align="center"><img src="https://github.com/preparetodietm/energizerforpine/blob/energizerforpine_v2.1/.github/energizer.gif">A simple optimizer powered by lightning thunder ⚡ with a combination of fixes, tweaks, and have an additional features by using this command: 𝙨𝙪 -𝙘 𝙚𝙣𝙚𝙧𝙜𝙞𝙯𝙚𝙧 in Termux/Terminal Emulator designed for all Xiaomi Redmi 7A devices.
</p>

## Requirements:
- <img src="https://img.shields.io/badge/Android-9-brightgreen.svg"> <img src="https://img.shields.io/badge/Android-10-brightgreen.svg"> <img src="https://img.shields.io/badge/Android-11-brightgreen.svg"> <img src="https://img.shields.io/badge/Android-12-brightgreen.svg">
- <img src="https://img.shields.io/badge/Magisk-20.4%2B-00B39B.svg">

## Note:

**FOR XIAOMI REDMI 7A (pine) DEVICES ONLY!**

## Installation:

1. Flash
2. Select the desired options on the volume key selector
3. Reboot
4. Enjoy!

**If you want to _uninstall_ the module, just flash it again.**

## Features:

**Hardware and Game Tweaks**<br/>

**Internet and Network Signal Tweaks**<br/>

**Media Player & Sounds Tweaks**<br/>

**RAM Management and Multitasking Tweaks**<br/>

**Energizer Additional Tweaks**<br/>

**Disable Skip Validate**<br/>

**Disable UBWC for Graphics**<br/>

**Fix blue overlay when minimizing videos above 720p in YouTube**<br/>

**Fix UI Glitches**<br/>

**Fix UI Laggy**<br/>

**Remove LMKD Props**<br/>

**Enable Fast Charging**<br/>

**Switch to Portable Interpreter**<br/>

## Features in Volume-Key-Selector:

**Dexopt Speed Profile**
- Dexopt is a system-internal tool that is used to produce optimized dex files by using `su -c cmd package bg-dexopt-job` code. 

**Double Wifi Bandwidth**
- Doubles your wifi bandwith by modifying WNCSS_qcom_cfg.ini

**Touchscreen Improvement**
- A tweaks for touchsreen "fts_ts" for Redmi 7A devices.

**Wifi Fixes**
- Fix wifi not working after flashing kernel and booted to system.

## Changelog:

### [Energizer_v2.1](https://github.com/preparetodietm/energizerforpine/commits/energizerforpine_v2.1)
- Update Energizer script (v2.0 to v2.1)
  - Added HWUI Renderer Changer (Misc)
    - HWUI Renderer Changer (New)
  - Remove Vulkan & SkiaGL (Gaming Mode)
  - Some changes on UI Interface
- Added Disable Skip Validate
- Added Fix blue overlay when minimizing videos above 720p in YouTube
- Added Fix UI Laggy
- Added New Energizer Description
- Added smart detection for Energizer script
- Fixed post-fs-data.sh and service.sh permissions
- Fixed resetprop error in Magisk Manager logs
- Fixed startup blackscreen after splash image
- Fixed Switch to Portable Interpreter looping prop in service
- Moved Dexopt Speed - Profile, Disable UBWC for Graphics, Energizer Additional Tweaks, Fix UI Glitches, Remove LMKD Props, in post-fs-data
- Removed directly writing in system and vendor build.prop
- Some changes in overall scripts

### [Energizer_v2.0](https://github.com/preparetodietm/energizerforpine/commits/energizerforpine_v2.0)
- Added Energizer command `su -c energizer`
  - Added Boost Apps
  - Added Gaming Mode
  - Added Misc
    - Dexopt Speed Profile
    - Boot Patcher
    - DPI Changer
    - SR Changer (Screen Resolution Changer)
- Added VoWifi, Volte, Smooth Streaming and other useful props
- Cust Swap Removed
- Dexopt Everything to Dexopt Speed Profile
- Disable UBWC for Graphics
- Fix UI Glitches and fully compatible to all android version
- Flush Ram Removed
- Improved Double Wifi Bandwidth script
- Improved RAM Management Tweaks
- Moved Dexopt Speed Profile in Energizer command
- Optimized overall module scripts
- Removed placebo props
- Remove LMKD + Added Energizer Additional Tweaks from vendor build.prop
- Switch to Portable Interpreter

### [Energizer_v1.3](https://github.com/preparetodietm/energizerforpine/commits/energizerforpine_v1.3)
- Added back flushram notification toas
- Added RAM Management tweaks + optimized the script
- Remove flush ram 1, 2, and 4
- Remove unnecessary tweaks that caused ping hikes, lags, in games and improve ram management + default gpu is set to skia vulkan
- Support New Android 12 rom/gsi

### [Energizer_v1.2](https://github.com/preparetodietm/energizerforpine/commits/energizerforpine_v1.2)
- Optimize and fixed installation script
- Removed notification toast of Flush RAM to free more ram
- Some changes on system.prop

### [Energizer_v1.1](https://github.com/preparetodietm/energizerforpine/commits/energizerforpine_v1.1)
- Added Cust Swap and move wifi fixes to v-k-s features
- Added default lcd brightness
- Added deleter for flush ram logs
- Fix installation scripts
- Fix Touchscreen Improvement scripts
- Some changes on system.prop

### [Energizer_v1.0](https://github.com/preparetodietm/energizerforpine/tags)
- Added Disable GPU Throttling to fix fps drop while playing games
- Added Enable Force Fast Charging
- Added WIFI Fixes for Lilac Kernel which is not working on some GSI/ROM

## Credits:

- [AkiraNoSushi](https://github.com/AkiraNoSushi) for his Enable Fast Charging Module
- [dlwlrma123](https://github.com/dlwlrma123) for Giving Dexopt Everything(Changed now to Dexopt Speed Profile by me)
- [Flopster101](https://t.me/Flopster101) for his Fix blue overlay when minimizing videos above 720p in YouTube
- [KylieKyler](https://t.me/Kyliekyler) for helping me in some stuffs
- [Mitsuki Shinboro 🇵🇭 #pine](https://t.me/leesungkyung32) and [hsxzerotwo](https://t.me/hsx02) for the Fix UI Laggy
- [SdkPt](https://t.me/SdkptNewYear) for his idea to fixed wifi
- [WeAreRavens](https://t.me/WeAreRavenS) for Touchscreen Improvement
- [YuuhYemin](https://t.me/pfffffffft) for Testing and my solid pakner
- To all Redmi 7A Testers and Community<br/>
<br/>
<p align="center">
<a href="https://t.me/preparetodietm"><img src="https://img.shields.io/badge/Telegram-My Account-blue?logo=telegram&style=social"></a><br/>
<a href="https://t.me/energizerforpine"><img src="https://img.shields.io/badge/Telegram-Group-blue?logo=telegram&style=social"></a><br/>
<a href="https://youtube.com/channel/UCbDEvgpYWmxK9uXhQ3-LtQw"><img src="https://img.shields.io/badge/YouTube-Channel-blue?logo=youtube&style=social"></a><br/>
<br/>
𝗘𝗻𝗲𝗿𝗴𝗶𝘇𝗲𝗿 𝗳𝗼𝗿 𝗥𝗲𝗱𝗺𝗶 𝟳𝗔 ⚡<br/>
All Rights Reserved © 2021 - 2022
</p>
