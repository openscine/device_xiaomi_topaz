#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifneq ($(filter topaz,$(TARGET_DEVICE)),)
include $(call all-makefiles-under,$(LOCAL_PATH))

# A/B builds require us to create the mount points at compile time.
# Just creating it for all cases since it does not hurt.
FIRMWARE_MOUNT_POINT := $(TARGET_OUT_VENDOR)/firmware_mnt
$(FIRMWARE_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(FIRMWARE_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/firmware_mnt

BT_FIRMWARE_MOUNT_POINT := $(TARGET_OUT_VENDOR)/bt_firmware
$(BT_FIRMWARE_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(BT_FIRMWARE_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/bt_firmware

DSP_MOUNT_POINT := $(TARGET_OUT_VENDOR)/dsp
$(DSP_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(DSP_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/dsp

ALL_DEFAULT_INSTALLED_MODULES += \
    $(FIRMWARE_MOUNT_POINT) \
    $(BT_FIRMWARE_MOUNT_POINT) \
    $(DSP_MOUNT_POINT)

CNE_LIBS := libvndfwk_detect_jni.qti_vendor.so
CNE_SYMLINKS := $(addprefix $(TARGET_OUT_VENDOR_APPS)/CneApp/lib/arm64/,$(notdir $(CNE_LIBS)))
$(CNE_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "CNE lib link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /vendor/lib64/$(notdir $@) $@

EGL_LIB_SYMLINKS := $(TARGET_OUT_VENDOR)/lib
$(EGL_LIB_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "EGL lib symlinks: $@"
	@mkdir -p $@
	$(hide) ln -sf egl/libEGL_adreno.so $@/libEGL_adreno.so
	$(hide) ln -sf egl/libGLESv2_adreno.so $@/libGLESv2_adreno.so
	$(hide) ln -sf egl/libq3dtools_adreno.so $@/libq3dtools_adreno.so

EGL_LIB64_SYMLINKS := $(TARGET_OUT_VENDOR)/lib64
$(EGL_LIB64_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "EGL lib64 symlinks: $@"
	@mkdir -p $@
	$(hide) ln -sf egl/libEGL_adreno.so $@/libEGL_adreno.so
	$(hide) ln -sf egl/libGLESv2_adreno.so $@/libGLESv2_adreno.so
	$(hide) ln -sf egl/libq3dtools_adreno.so $@/libq3dtools_adreno.so

WIFI_FIRMWARE_SYMLINKS := $(TARGET_OUT_VENDOR)/firmware/
$(WIFI_FIRMWARE_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating wifi firmware symlinks: $@"
	@mkdir -p $@/wlan/qca_cld
	$(hide) ln -sf /data/vendor/firmware/wlanmdsp.mbn $@/wlanmdsp.otaupdate
	$(hide) ln -sf /mnt/vendor/persist/wlan_mac.bin $@/wlan/qca_cld/wlan_mac.bin
	$(hide) ln -sf /vendor/etc/wifi/WCNSS_qcom_cfg.ini $@/wlan/qca_cld/WCNSS_qcom_cfg.ini

ALL_DEFAULT_INSTALLED_MODULES += $(CNE_SYMLINKS) $(EGL_LIB_SYMLINKS) $(EGL_LIB64_SYMLINKS) $(WIFI_FIRMWARE_SYMLINKS)

endif
