#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2021-2024 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#
FDEVICE="sweet"

#set -o xtrace
fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
   if [ -n "$chkdev" ]; then 
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
        export FOX_USE_SPECIFIC_MAGISK_ZIP=~/Magisk/Magisk-v30.6.zip
   	export TW_DEFAULT_LANGUAGE="en"
	export LC_ALL="C"
 	export ALLOW_MISSING_DEPENDENCIES=true
	export FOX_USE_NANO_EDITOR=1
	export FOX_ENABLE_APP_MANAGER=1
	export FOX_USE_BASH_SHELL=1
	export FOX_ASH_IS_BASH=1
	export FOX_USE_TAR_BINARY=1
	export FOX_USE_SED_BINARY=1
	export FOX_USE_XZ_UTILS=1
        export FOX_DELETE_AROMAFM=1
        export TARGET_DEVICE_ALT="sweetin"
	export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
	export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
        export FOX_BUGGED_AOSP_ARB_WORKAROUND="1546300800"; # Tuesday, January 1, 2019 12:00:00 AM GMT+00:00

	# R12.1 Settings
	export FOX_MAINTAINER_PATCH_VERSION="1"
	export OF_MAINTAINER="MOSTAFAMEESR"

		# ==========================================
	# Modern Features (Android 12/13/14 Support)
	# ==========================================

	# 1. Screen Settings (To prevent GUI or touch glitches)
	export OF_SCREEN_H="2400"
	export OF_SCREEN_W="1080"

	# 2. Modern Decryption Support (FBEv2 / Metadata)
	# Crucial for reading internal storage correctly on modern ROMs
	export OF_FBE_METADATA_MOUNT_IGNORE="1"
	export OF_IGNORE_LOGICAL_MOUNT_ERRORS="1"
	# Save OrangeFox settings in a safe path away from encryption complexities
	export FOX_USE_DATA_RECOVERY_FOR_SETTINGS="1" 

	# 3. EROFS File System Support
	# Essential for flashing and mounting system on Android 13/14 ROMs
	export OF_ENABLE_FSCOMPRESSION="1"

	# 4. Boot & Magisk Patching Handling
	export OF_USE_MAGISKBOOT="1"
	export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES="1"
	export OF_DONT_PATCH_ENCRYPTED_DEVICE="1"

	# 5. Build Environment Fixes (For fox_12.1 branch)
	export FOX_REMOVE_AAPT="1"

	# ==========================================
	# MIUI & HyperOS Support (OTA & Compatibility)
	# ==========================================

	# Enable support for official MIUI/HyperOS OTA updates
	export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES="1"
	export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR="1"
	export OF_DISABLE_MIUI_OTA_BY_DEFAULT="0"

	# Patching settings to prevent bootloops on MIUI/HyperOS
	export OF_NO_MIUI_PATCH_WARNING="1"
	export OF_NO_TREBLE_COMPATIBILITY_CHECK="1"
	

else
	if [ -z "$FOX_BUILD_DEVICE" -a -z "$BASH_SOURCE" ]; then
		echo "I: This script requires bash. Not processing the $FDEVICE $(basename $0)"
	fi
fi
#
