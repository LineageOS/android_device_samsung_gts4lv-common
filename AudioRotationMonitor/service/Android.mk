LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := set-audio-rotation
LOCAL_MODULE_TAGS := optional
LOCAL_INIT_RC := set-audio-rotation.rc
LOCAL_SRC_FILES := \
    set-audio-rotation.cpp
LOCAL_SHARED_LIBRARIES := \
    libbase \
    libtinyalsa

include $(BUILD_EXECUTABLE)
