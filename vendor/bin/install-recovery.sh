#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/platform/13500000.dwmmc0/by-name/boot_b$(getprop ro.boot.slot_suffix):33554432:aded2b1d7729ae7c8900db9fb5437755a7248c64; then
  applypatch  \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/platform/13500000.dwmmc0/by-name/boot_a$(getprop ro.boot.slot_suffix):33554432:5dfa8a5cc70743db0fe085d5ca3ac58dff839355 \
          --target EMMC:/dev/block/platform/13500000.dwmmc0/by-name/boot_b$(getprop ro.boot.slot_suffix):33554432:aded2b1d7729ae7c8900db9fb5437755a7248c64 && \
      log -t recovery "Installing new recovery image: succeeded" || \
      log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
