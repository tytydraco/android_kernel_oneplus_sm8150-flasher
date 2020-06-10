#!/bin/sh
# Draco Kernel Companion Module

# Kill brain service on OOS
resetprop ctl.stop oneplus_brain_service

# Memory tweaks
sysctl -w vm.dirty_ratio=50
sysctl -w vm.dirty_background_ratio=10
sysctl -w vm.vfs_cache_pressure=50

# Disable heap randomization
sysctl -w kernel.randomize_va_space=0
