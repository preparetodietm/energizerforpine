#
# Touchscreen sensor driver
#
# https://forum.xda-developers.com/essential-phone/themes/mata-tochfix-t3916652
#
# https://reiryuki.blogspot.com/2020/08/how-to-configure-your-android.html
#
# https://forum.xda-developers.com/t/possible-fix-for-touchscreen-issues-misses-updated-08-29.3172100/
#
# Do not remove credit if you're using a part of this mod to your module.
# @WeAreRavenS
#

# Without FOD
# @Titidebin

device.internal = 1
touch.deviceType = touchScreen
touch.orientationAware = 1
touch.filter.level=0

# Size
# Based on empirical measurements, we estimate the size of the contact
# using size = sqrt(area) * 54 + 0.2
touch.size.calibration = area
touch.size.scale = 54
touch.size.bias = 0.2
touch.toolSize.isSummed = 1

# Pressure
# Driver reports signal strength as pressure.
#
# A normal thumb touch typically registers about 100 signal strength
# units although we don't expect these values to be accurate.
touch.pressure.calibration = amplitude
touch.pressure.scale = 0.005

# Orientation
touch.orientation.calibration = none
touch.distance.calibration = none
touch.distance.scale = 0
