# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Draco Kernel [tytydraco]
do.devicecheck=0
do.modules=0
do.systemless=0
do.cleanup=1
do.cleanuponabort=0
device.name1=
device.name2=
device.name3=
device.name4=
device.name5=
supported.versions=
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/by-name/boot;
is_slot_device=1;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

ui_print "______________________________________ ";
ui_print "___  __ \\__  __ \\__    |_  ____/_  __ \\";
ui_print "__  / / /_  /_/ /_  /| |  /    _  / / /";
ui_print "_  /_/ /_  _, _/_  ___ / /___  / /_/ / ";
ui_print "/_____/ /_/ |_| /_/  |_\\____/  \\____/  ";
ui_print "                                       ";

## AnyKernel install
dump_boot;

write_boot;
## end install

ui_print "Adding companion module...";
rm -rf /data/adb/modules/companion_module;
mkdir -p /data/adb/modules/companion_module;
cp -rf companion_module/ /data/adb/modules/;

ui_print "Adding VTS check bypass module...";
rm -rf /data/adb/modules/vintf_bypass;
mkdir -p /data/adb/modules/vintf_bypass;
cp -rf vintf_bypass/ /data/adb/modules/;

ui_print "Removing deprecated modules..."
rm -rf /data/adb/modules/CompanionModule
rm -rf /data/adb/modules/vintf-bypass

ui_print "Disabling conflicting modules..."
[[ -d "/data/adb/modules/xXx" ]] && echo "" > /data/adb/modules/xXx/disable
[[ -d "/data/adb/modules/nfsinjector" ]] && echo "" > /data/adb/modules/nfsinjector/disable

ui_print "Done.";
ui_print "";
ui_print "Note: Magisk is required to use the modules.";
ui_print "If you do not have Magisk, flash it and reflash this kernel.";
ui_print "";
