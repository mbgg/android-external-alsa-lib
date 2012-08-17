# external/alsa-lib/Android.mk
#
# Copyright 2008 Wind River Systems
#

ifeq ($(strip $(BOARD_USES_ALSA_AUDIO)),true)

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

##
## Copy ALSA configuration files to rootfs
##
TARGET_ALSA_CONF_DIR := $(TARGET_OUT)/usr/share/alsa/
LOCAL_ALSA_CONF_DIR  := $(LOCAL_PATH)/src/conf/

#copy_from := \

PRODUCT_COPY_FILE := \
	$(LOCAL_ALSA_CONF_DIR)alsa.conf:$(TARGET_ALSA_CONF_DIR)alsa.conf \
	$(LOCAL_ALSA_CONF_DIR)pcm/dsnoop.conf:$(TARGET_ALSA_CONF_DIR)pcm/dsnoop.conf \
	$(LOCAL_ALSA_CONF_DIR)pcm/modem.conf:$(TARGET_ALSA_CONF_DIR)pcm/modem.conf \
	$(LOCAL_ALSA_CONF_DIR)pcm/dpl.conf:$(TARGET_ALSA_CONF_DIR)pcm/dpl.conf \
	$(LOCAL_ALSA_CONF_DIR)pcm/default.conf:$(TARGET_ALSA_CONF_DIR)pcm/default.conf \
	$(LOCAL_ALSA_CONF_DIR)pcm/surround51.conf:$(TARGET_ALSA_CONF_DIR)pcm/surround51.conf \
	$(LOCAL_ALSA_CONF_DIR)pcm/surround41.conf:$(TARGET_ALSA_CONF_DIR)pcm/surround41.conf \
	$(LOCAL_ALSA_CONF_DIR)pcm/surround50.conf:$(TARGET_ALSA_CONF_DIR)pcm/surround50.conf \
	$(LOCAL_ALSA_CONF_DIR)pcm/dmix.conf:$(TARGET_ALSA_CONF_DIR)pcm/dmix.conf \
	$(LOCAL_ALSA_CONF_DIR)pcm/center_lfe.conf:$(TARGET_ALSA_CONF_DIR)pcm/center_lfe.conf \
	$(LOCAL_ALSA_CONF_DIR)pcm/surround40.conf:$(TARGET_ALSA_CONF_DIR)pcm/surround40.conf \
	$(LOCAL_ALSA_CONF_DIR)pcm/side.conf:$(TARGET_ALSA_CONF_DIR)pcm/side.conf \
	$(LOCAL_ALSA_CONF_DIR)pcm/iec958.conf:$(TARGET_ALSA_CONF_DIR)pcm/iec958.conf \
	$(LOCAL_ALSA_CONF_DIR)pcm/rear.conf:$(TARGET_ALSA_CONF_DIR)pcm/rear.conf \
	$(LOCAL_ALSA_CONF_DIR)pcm/surround71.conf:$(TARGET_ALSA_CONF_DIR)pcm/surround71.conf \
	$(LOCAL_ALSA_CONF_DIR)pcm/front.conf:$(TARGET_ALSA_CONF_DIR)pcm/front.conf \
	$(LOCAL_ALSA_CONF_DIR)cards/aliases.conf:$(TARGET_ALSA_CONF_DIR)cards/aliases.conf

#copy_to   := $(addprefix $(TARGET_ALSA_CONF_DIR)/,$(copy_from))
#copy_from := $(addprefix $(LOCAL_ALSA_CONF_DIR)/,$(copy_from))

#$(copy_to) : $(TARGET_ALSA_CONF_DIR)/% : $(LOCAL_ALSA_CONF_DIR)/% | $(ACP)
#	$(transform-prebuilt-to-target)

#ALL_PREBUILT += $(copy_to)

include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libasound

LOCAL_PRELINK_MODULE := false
LOCAL_ARM_MODE := arm

LOCAL_C_INCLUDES += $(LOCAL_PATH)/include

# libasound must be compiled with -fno-short-enums, as it makes extensive
# use of enums which are often type casted to unsigned ints.
LOCAL_CFLAGS := \
	-fPIC -DPIC -D_POSIX_SOURCE \
	-DALSA_CONFIG_DIR=\"/system/usr/share/alsa\" \
	-DALSA_PLUGIN_DIR=\"/system/usr/lib/alsa-lib\" \
	-DALSA_DEVICE_DIRECTORY=\"/dev/snd/\"

LOCAL_SRC_FILES := $(sort $(call all-c-files-under, src))

# It is easier to exclude the ones we don't want...
#
LOCAL_SRC_FILES := $(filter-out src/alisp/alisp_snd.c, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out src/compat/hsearch_r.c, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out src/control/control_shm.c, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out src/pcm/pcm_d%.c, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out src/pcm/pcm_ladspa.c, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out src/pcm/pcm_shm.c, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out src/pcm/scopes/level.c, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out src/shmarea.c, $(LOCAL_SRC_FILES))

LOCAL_SHARED_LIBRARIES := \
    libdl

include $(BUILD_SHARED_LIBRARY)

# libasound.a

include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libasound

LOCAL_PRELINK_MODULE := false
LOCAL_ARM_MODE := arm

LOCAL_C_INCLUDES += $(LOCAL_PATH)/include

# libasound must be compiled with -fno-short-enums, as it makes extensive
# use of enums which are often type casted to unsigned ints.
LOCAL_CFLAGS := \
	-fPIC -DPIC -D_POSIX_SOURCE \
	-DALSA_CONFIG_DIR=\"/system/usr/share/alsa\" \
	-DALSA_PLUGIN_DIR=\"/system/usr/lib/alsa-lib\" \
	-DALSA_DEVICE_DIRECTORY=\"/dev/snd/\"

LOCAL_SRC_FILES := $(sort $(call all-c-files-under, src))

# It is easier to exclude the ones we don't want...
#
LOCAL_SRC_FILES := $(filter-out src/alisp/alisp_snd.c, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out src/compat/hsearch_r.c, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out src/control/control_shm.c, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out src/pcm/pcm_d%.c, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out src/pcm/pcm_ladspa.c, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out src/pcm/pcm_shm.c, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out src/pcm/scopes/level.c, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out src/shmarea.c, $(LOCAL_SRC_FILES))

LOCAL_SHARED_LIBRARIES := \
    libdl

include $(BUILD_STATIC_LIBRARY)



endif
