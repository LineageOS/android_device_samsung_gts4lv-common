LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := android.hardware.power@1.2-service.samsung
LOCAL_INIT_RC := android.hardware.power@1.2-service.samsung.rc
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_MODULE_TAGS := optional

LOCAL_VENDOR_MODULE := true

LOCAL_SRC_FILES := \
    hint-data.c \
    list.c \
    metadata-parser.c \
    power-710.c \
    power-common.c \
    powerhintparser.c \
    Power.cpp \
    service.cpp \
    utils.c

LOCAL_C_INCLUDES := external/libxml2/include \
                    external/icu/icu4c/source/common

LOCAL_SHARED_LIBRARIES := \
    android.hardware.power@1.2 \
    libbase \
    libcutils \
    libdl \
    libhidlbase \
    libhidltransport \
    liblog \
    libutils \
    libxml2

LOCAL_HEADER_LIBRARIES += libutils_headers
LOCAL_HEADER_LIBRARIES += libhardware_headers

ifeq ($(TARGET_USES_INTERACTION_BOOST),true)
    LOCAL_CFLAGS += -DINTERACTION_BOOST
endif

LOCAL_CFLAGS += -Werror -Wall -Wno-unused-parameter

include $(BUILD_EXECUTABLE)
