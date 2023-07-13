#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from r11btwifi device
$(call inherit-product, device/google/r11btwifi/device.mk)

PRODUCT_DEVICE := r11btwifi
PRODUCT_NAME := lineage_r11btwifi
PRODUCT_BRAND := google
PRODUCT_MODEL := Google Pixel Watch
PRODUCT_MANUFACTURER := google

PRODUCT_GMS_CLIENTID_BASE := android-google

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="r11btwifi-user 11 RWDC.230705.001 10170193 release-keys"

BUILD_FINGERPRINT := google/r11btwifi/r11btwifi:11/RWDC.230705.001/10170193:user/release-keys
