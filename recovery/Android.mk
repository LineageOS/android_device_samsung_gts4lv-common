LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_C_INCLUDES := \
    bootable/deprecated-ota/edify/include \
    bootable/deprecated-ota/updater/include \
    bootable/recovery \
    bootable/recovery/otautil/include \
    system/libbase/include
LOCAL_SRC_FILES := recovery_updater.cpp
LOCAL_MODULE := librecovery_updater_samsung
include $(BUILD_STATIC_LIBRARY)
