#!/bin/sh
# Draco Kernel Companion Module

# Disable heap randomization
sysctl -w kernel.randomize_va_space=0

# Process child forks before the parent
sysctl -w kernel.sched_child_runs_first=1

# Use kernel default dirty page max expiration time
sysctl -w vm.dirty_expire_centisecs=3000

# Adjust schedtune configuration
echo 1 > /dev/stune/top-app/schedtune.crucial
echo 1 > /dev/stune/top-app/schedtune.prefer_idle

# --- DELAYED CHANGES ---
sleep 30

# Use lowest available frequency on policy0
echo 300000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq

