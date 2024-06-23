#
# Copyright (C) 2018-2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifneq ($(filter gts4lv gts4lvwifi,$(TARGET_DEVICE)),)

include $(call all-makefiles-under,$(LOCAL_PATH))

DSP_SYMLINK := $(TARGET_OUT_VENDOR)/lib/dsp
$(DSP_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating DSP folder symlink: $@"
	@rm -rf $@
	@mkdir -p $(TARGET_OUT_VENDOR)/lib/dsp

ALL_DEFAULT_INSTALLED_MODULES += $(DSP_SYMLINK)

FIRMWARE_MODEM_MOUNT_POINT := $(TARGET_OUT_VENDOR)/firmware-modem
FIRMWARE_MOUNT_POINT := $(TARGET_OUT_VENDOR)/firmware_mnt
DSP_MOUNT_POINT := $(TARGET_OUT_VENDOR)/dsp

$(FIRMWARE_MODEM_MOUNT_POINT):
	@echo "Creating $(FIRMWARE_MODEM_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/firmware-modem

$(FIRMWARE_MOUNT_POINT):
	@echo "Creating $(FIRMWARE_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/firmware_mnt

$(DSP_MOUNT_POINT):
	@echo "Creating $(DSP_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/dsp

ALL_DEFAULT_INSTALLED_MODULES += \
    $(FIRMWARE_MODEM_MOUNT_POINT) \
    $(FIRMWARE_MOUNT_POINT) \
    $(DSP_MOUNT_POINT)

endif
