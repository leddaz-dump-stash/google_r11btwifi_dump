#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/platform/13500000.dwmmc0/by-name/boot_b$(getprop ro.boot.slot_suffix):33554432:380b61b2d91164b8791c58f123a86b2bcc56a505; then
  applypatch  \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/platform/13500000.dwmmc0/by-name/boot_a$(getprop ro.boot.slot_suffix):33554432:e52285e5f4f160218f024e046925a726ff3a879f \
          --target EMMC:/dev/block/platform/13500000.dwmmc0/by-name/boot_b$(getprop ro.boot.slot_suffix):33554432:380b61b2d91164b8791c58f123a86b2bcc56a505 && \
      log -t recovery "Installing new recovery image: succeeded" || \
      log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
