#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# CONFIGURE: Use full pack to kernel root
kernel="$HOME/Kernel/android_kernel_oneplus_sm8150"

zimage="$kernel/out/arch/arm64/boot/Image.gz"
dts="$kernel/out/arch/arm64/boot/dts"
anykernel="$DIR/AnyKernel3"
version=`cat $kernel/out/.version`
timestamp=`date +%m%d`
githash=`git --git-dir $kernel/.git rev-parse --short HEAD`
zipname="draco_sm8150-$version-$timestamp-$githash.zip"

echo Verifying zImage exists...

if [ ! -e "$zimage" ]
then
	echo Image.gz not found. Abort.
	exit
fi

echo Removing old builds...
rm $DIR/*.zip

echo Copying zImage to AnyKernel directory...
cp $zimage $anykernel

find $dts -name '*.dtb' -exec cat {} + > $anykernel/dtb

dtb_size=`du --bytes $anykernel/dtb`
if [ $dtb_size -ge 5000000 ]; then
	echo ****************************************************************
	echo Your DTB is larger than 5 MB. That is NOT normal. Do make clean.
	echo ****************************************************************
	exit
fi

echo Zipping contents of AnyKernel directory...
echo

olddir=`pwd`
cd $anykernel
zip -r $zipname * -x "README.md" -x "LICENSE"
mv $zipname ..
cd $oldir

echo
echo Done!
echo Created zip: $zipname
echo
echo --- SPECS ---
echo -e "VERSION\t\t$version"
echo -e "TIMESTAMP\t$timestamp"
echo -e "HEAD HASH\t$githash"

echo -n "Upload to transfer.sh? (y/N)?"
read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then
echo
echo Transferring to transfer.sh...
echo
echo
echo
transfer() { if [ $# -eq 0 ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi 
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }
transfer $DIR/$zipname
echo
echo
echo
fi
