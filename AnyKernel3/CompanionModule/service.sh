#!/bin/sh
# Draco Kernel Companion Module

# Kill brain service on OOS
resetprop ctl.stop oneplus_brain_service

# Disable heap randomization
sysctl -w kernel.randomize_va_space=0

# Process child forks before the parent
sysctl -w kernel.sched_child_runs_first=1
