LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := libpower_feature.gts4lv
LOCAL_MODULE_TAGS := optional

LOCAL_VENDOR_MODULE := true

LOCAL_SRC_FILES := power-feature.c

LOCAL_HEADER_LIBRARIES := libhardware_headers qti_powerhal_headers

include $(BUILD_STATIC_LIBRARY)
