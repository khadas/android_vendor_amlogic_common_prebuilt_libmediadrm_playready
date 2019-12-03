ifeq ($(BUILD_WITH_PLAYREADY_DRM), true)

LOCAL_PATH:= $(call my-dir)
ifeq ($(BOARD_PLAYREADY_TVP),true)
#####################################################################
# libplayreadydrmplugin.so
include $(CLEAR_VARS)
LOCAL_MODULE := libplayreadymediadrmplugin

LOCAL_PROPRIETARY_MODULE := true
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR)/lib/mediadrm

LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_SRC_FILES := mediadrm/TVP/libplayreadymediadrmplugin.so
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
LOCAL_MODULE := 9a04f079-9840-4286-ab92e65be0885f95
ifeq ($(TARGET_ENABLE_TA_SIGN), true)
$(info $(shell mkdir -p $(shell pwd)/$(PRODUCT_OUT)/signed/mediadrm/TVP))
$(info $(shell $(shell pwd)/$(BOARD_AML_VENDOR_PATH)/tdk/ta_export/scripts/sign_ta_auto.py \
		--in=$(shell pwd)/$(LOCAL_PATH)/mediadrm/TVP/9a04f079-9840-4286-ab92e65be0885f95.ta \
		--out=$(shell pwd)/$(PRODUCT_OUT)/signed/mediadrm/TVP/9a04f079-9840-4286-ab92e65be0885f95.ta \
		--keydir=$(shell pwd)/$(BOARD_AML_TDK_KEY_PATH)))
LOCAL_SRC_FILES := ../../../../../../$(PRODUCT_OUT)/signed/mediadrm/TVP/9a04f079-9840-4286-ab92e65be0885f95.ta
else
LOCAL_SRC_FILES := mediadrm/TVP/9a04f079-9840-4286-ab92e65be0885f95.ta
endif
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .ta
LOCAL_32_BIT_ONLY := true

LOCAL_PROPRIETARY_MODULE := true
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR)/lib/teetz

LOCAL_STRIP_MODULE := false
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
LOCAL_SRC_FILES := NOTVP/libplayreadymediadrmplugin.so
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
LOCAL_SRC_FILES := NOTVP/libplayready.so
LOCAL_PROPRIETARY_MODULE := true
LOCAL_STRIP_MODULE := false
LOCAL_SHARED_LIBRARIES := libamavutils libcutils liblog libteec libutils

LOCAL_32_BIT_ONLY := true
LOCAL_MODULE_TAGS := optional
include $(BUILD_PREBUILT)

#####################################################################
endif

endif

