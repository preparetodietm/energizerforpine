#!/system/bin/sh
# This script will be executed in post-fs-data mode
#===================================================
MODDIR=${0%/*}
#1
#Dexopt_Speed_Profile
#DSP_one
#DSP_two
#DSP_three
#DSP_four
#DSP_five
#DSP_six
#DSP_seven
#DSP_eight
#DSP_nine

# Disable Skip Validate
setprop sdm.debug.disable_skip_validate 1

# Disable UBWC for Graphics
setprop debug.gralloc.gfx_ubwc_disable 1

# Energizer Additional Tweaks
resetprop ro.hardware.keystore_desede true
resetprop vendor.display.comp_mask 0
resetprop vendor.display.enable_default_color_mode 1
resetprop vendor.display.enable_optimize_refresh 1

# Fix blue overlay when minimizing videos above 720p in YouTube
resetprop --delete vendor.display.disable_rotator_downscale
# by @Flopster101

# Fix UI Glitches
resetprop --delete debug.sf.latch_unsignaled

# Fix UI Laggy
resetprop --delete debug.sf.enable_gl_backpressure
# by @leesungkyung32
resetprop --delete debug.sf.high_fps_late_app_phase_offset_ns
resetprop --delete debug.sf.high_fps_early_gl_phase_offset_ns
resetprop --delete debug.sf.high_fps_early_phase_offset_ns
# by @hsx02

# Remove LMKD Props
resetprop --delete ro.lmk.kill_heaviest_task
resetprop --delete ro.lmk.kill_timeout_ms
resetprop --delete ro.lmk.psi_partial_stall_ms
resetprop --delete ro.lmk.swap_util_max
resetprop --delete ro.lmk.swap_free_low_percentage
resetprop --delete ro.lmk.thrashing_limit
resetprop --delete ro.lmk.thrashing_limit_decay
resetprop --delete ro.lmk.use_psi

# Special Thanks to sir KylieKyler for helping me in some stuffs :)

#=============================
# End of post-fs-data.sh
# Modified by @preparetodietm
#=============================
