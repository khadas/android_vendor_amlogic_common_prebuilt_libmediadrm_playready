ifeq ($(BUILD_WITH_PLAYREADY_DRM), true)

LOCAL_PATH:= $(call my-dir)

# -----------------------------------------------------------------------------
# Builds android.hardware.drm@1.3-service.playready
#
ifneq (0, $(shell expr $(PLATFORM_SDK_VERSION) \>= 30))
include $(CLEAR_VARS)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR)/bin/hw
LOCAL_MODULE := android.hardware.drm@1.3-service.playready
LOCAL_SRC_FILES := $(LOCAL_MODULE)
LOCAL_INIT_RC := android.hardware.drm@1.3-service.playready.rc
LOCAL_VINTF_FRAGMENTS := manifest_android.hardware.drm@1.3-service.playready.xml
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)
endif

ifeq ($(BOARD_PLAYREADY_TVP),true)
#####################################################################
# libplayreadydrmplugin.so
include $(CLEAR_VARS)
LOCAL_MODULE := libplayreadymediadrmplugin

LOCAL_PROPRIETARY_MODULE := true
ifneq (0, $(shell expr $(PLATFORM_SDK_VERSION) \>= 30))
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR)/lib/
else
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR)/lib/mediadrm
endif

LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_SRC_FILES := mediadrm/TVP/libplayreadymediadrmplugin.so
LOCAL_PROPRIETARY_MODULE := true
LOCAL_STRIP_MODULE := false
LOCAL_SHARED_LIBRARIES := libcutils liblog libplayready libssl libstagefright_foundation libutils
LOCAL_CHECK_ELF_FILES := false
LOCAL_32_BIT_ONLY := true
LOCAL_MODULE_TAGS := optional
include $(BUILD_PREBUILT)

#####################################################################

#####################################################################
# libplayready.so
include $(CLEAR_VARS)
LOCAL_MODULE := libplayready


LOCAL_PROPRIETARY_MODULE := true
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR)/lib

LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_SRC_FILES := mediadrm/TVP/libplayready.so
LOCAL_PROPRIETARY_MODULE := true
LOCAL_STRIP_MODULE := false
LOCAL_SHARED_LIBRARIES := libamavutils libcutils liblog libteec libutils

LOCAL_32_BIT_ONLY := true
LOCAL_MODULE_TAGS := optional
include $(BUILD_PREBUILT)

#####################################################################

#####################################################################
include $(CLEAR_VARS)
TA_UUID := 9a04f079-9840-4286-ab92-e65be0885f95
TA_SUFFIX := .ta

ifeq ($(PLATFORM_TDK_VERSION), 38)
PLATFORM_TDK_PATH := $(BOARD_AML_VENDOR_PATH)/tdk_v3
LOCAL_TA :=  mediadrm/TVP/ta/v3/$(TA_UUID)$(TA_SUFFIX)
else
PLATFORM_TDK_PATH := $(BOARD_AML_VENDOR_PATH)/tdk
LOCAL_TA :=  mediadrm/TVP/ta/v2/$(TA_UUID)$(TA_SUFFIX)
endif

ifeq ($(TARGET_ENABLE_TA_ENCRYPT), true)
ENCRYPT := 1
else
ENCRYPT := 0
endif

LOCAL_SRC_FILES := $(LOCAL_TA)
LOCAL_MODULE := $(TA_UUID)
LOCAL_MODULE_SUFFIX := $(TA_SUFFIX)
LOCAL_STRIP_MODULE := false
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR)/lib/teetz
ifeq ($(TARGET_ENABLE_TA_SIGN), true)
LOCAL_POST_INSTALL_CMD = $(PLATFORM_TDK_PATH)/ta_export/scripts/sign_ta_auto.py \
		--in=$(shell pwd)/$(LOCAL_MODULE_PATH)/$(TA_UUID)$(LOCAL_MODULE_SUFFIX) \
		--keydir=$(shell pwd)/$(BOARD_AML_TDK_KEY_PATH) \
		--encrypt=$(ENCRYPT)
endif
include $(BUILD_PREBUILT)

#####################################################################
else

#####################################################################
# libplayreadydrmplugin.so
include $(CLEAR_VARS)
LOCAL_MODULE := libplayreadymediadrmplugin


LOCAL_PROPRIETARY_MODULE := true
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR)/lib/mediadrm


LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_SRC_FILES := mediadrm/NOTVP/libplayreadymediadrmplugin.so
LOCAL_PROPRIETARY_MODULE := true
LOCAL_STRIP_MODULE := false
LOCAL_SHARED_LIBRARIES := libcutils liblog libplayready libssl libstagefright_foundation libutils
LOCAL_32_BIT_ONLY := true
LOCAL_MODULE_TAGS := optional
include $(BUILD_PREBUILT)

#####################################################################

#####################################################################
# libplayready.so
include $(CLEAR_VARS)
LOCAL_MODULE := libplayready

LOCAL_PROPRIETARY_MODULE := true
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR)/lib


LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_SRC_FILES := mediadrm/NOTVP/libplayready.so
LOCAL_PROPRIETARY_MODULE := true
LOCAL_STRIP_MODULE := false
LOCAL_SHARED_LIBRARIES := libamavutils libcutils liblog libteec libutils

LOCAL_32_BIT_ONLY := true
LOCAL_MODULE_TAGS := optional
include $(BUILD_PREBUILT)

#####################################################################
endif

endif

