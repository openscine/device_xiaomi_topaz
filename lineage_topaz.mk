#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from topaz device
$(call inherit-product, device/xiaomi/topaz/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_NAME := lineage_topaz
PRODUCT_DEVICE := topaz
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := Redmi Note 12 4G

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

# Device configs
TARGET_BOOT_ANIMATION_RES := 1080
TARGET_GAPPS_ARCH := arm64
WITH_GMS := false

# Matrixx
MATRIXX_BUILD_TYPE := Official
MATRIXX_MAINTAINER := artemscine
MATRIXX_CHIPSET := SM6225
MATRIXX_BATTERY := 5000mAh
MATRIXX_DISPLAY := 1080X2400
TARGET_EXCLUDES_AUDIOFX := true
TARGET_EXCLUDES_AUXIO := true
TARGET_EXCLUDES_VIA := true
