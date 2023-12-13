#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/platform/13500000.dwmmc0/by-name/boot_b$(getprop ro.boot.slot_suffix):33554432:dda8c1c180120924e87746412d20b8861674aa94; then
  applypatch  \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/platform/13500000.dwmmc0/by-name/boot_a$(getprop ro.boot.slot_suffix):33554432:f269d2337a3af5d10d7fce22c813d0f186691be6 \
          --target EMMC:/dev/block/platform/13500000.dwmmc0/by-name/boot_b$(getprop ro.boot.slot_suffix):33554432:dda8c1c180120924e87746412d20b8861674aa94 && \
      log -t recovery "Installing new recovery image: succeeded" || \
      log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
