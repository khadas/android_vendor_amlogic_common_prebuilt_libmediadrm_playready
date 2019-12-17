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
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR)/lib/teetz
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .ta
LOCAL_MODULE_TAGS := optional
LOCAL_32_BIT_ONLY := true
LOCAL_PROPRIETARY_MODULE := true
LOCAL_STRIP_MODULE := false

PLAYREADY_UNSIGNED_TA := $(LOCAL_PATH)/mediadrm/TVP/9a04f079-9840-4286-ab92e65be0885f95.ta

ifeq ($(TARGET_ENABLE_TA_SIGN), true)
include $(BUILD_SYSTEM)/base_rules.mk
$(LOCAL_BUILT_MODULE): $(PLAYREADY_UNSIGNED_TA)
	@mkdir -p $(dir $@)
	$(BOARD_AML_VENDOR_PATH)/tdk/ta_export/scripts/sign_ta_auto.py \
		--in=$(PLAYREADY_UNSIGNED_TA) \
		--out=$@ \
		--keydir=$(BOARD_AML_TDK_KEY_PATH)
else
LOCAL_PREBUILT_MODULE_FILE := $(PLAYREADY_UNSIGNED_TA)
include $(BUILD_PREBUILT)
endif

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

