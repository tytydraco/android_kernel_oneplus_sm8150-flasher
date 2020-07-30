#!/bin/sh
# Draco Kernel Companion Module

# Process child forks before the parent
sysctl -w kernel.sched_child_runs_first=1

# Adjust schedtune configuration
echo 1 > /dev/stune/top-app/schedtune.crucial
