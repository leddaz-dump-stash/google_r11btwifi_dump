#!/vendor/bin/sh

# Hold a wakelock for preventing CPU to enter suspend while clocks are boosted. This should not
# have any major power impact CPU doesn't immediately enter suspend after a boot normally.
echo postboot_wl > /sys/power/wake_lock

# Sleep for 120 seconds.
sleep 120

# Notify init to reset the boosting for CPU, GPU and MIF
setprop vendor.post_boot_steady 1

# Release the wakelock
echo postboot_wl > /sys/power/wake_unlock
