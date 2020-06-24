#!/bin/sh
# Draco Kernel Companion Module

# Disable heap randomization
sysctl -w kernel.randomize_va_space=0

# Process child forks before the parent
sysctl -w kernel.sched_child_runs_first=1
