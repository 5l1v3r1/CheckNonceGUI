#!/bin/bash

clear

cd "$(dirname "$0")"

./igetnonce | grep 'n53ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPhone6,2"
   echo $device
fi

./igetnonce | grep 'n51ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPhone6,1"
   echo $device
fi

./igetnonce | grep 'j71ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPad4,1"
   echo $device
fi

./igetnonce | grep 'j72ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPad4,2"
   echo $device
fi

./igetnonce | grep 'j85ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPad4,4"
   echo $device
fi

./igetnonce | grep 'j86ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPad4,5"
   echo $device
fi
./igetnonce | grep 'd11ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPhone9,2"
   echo $device
fi
./igetnonce | grep 'd10ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPhone9,1"
   echo $device
fi
./igetnonce | grep 'd101ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPhone9,3"
   echo $device
fi
./igetnonce | grep 'd111ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPhone9,4"
   echo $device
fi
./igetnonce | grep 'd22ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPhone10,3"
   echo $device
fi
./igetnonce | grep 'd221ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPhone10,6"
   echo $device
fi

./igetnonce | grep 'n112ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPod9,1"
   echo $device
fi

./igetnonce | grep 'j171ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPad7,11"
   echo $device
fi

./igetnonce | grep 'j17ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPad7,12"
   echo $device
fi

./igetnonce | grep 'j71bap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPad7,5"
   echo $device
fi

./igetnonce | grep 'j72bap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPad7,6"
   echo $device
fi

./igetnonce | grep 'j73ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPad4,3"
   echo $device
fi

./igetnonce | grep 'j87ap' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPad4,6"
   echo $device
fi

./igetnonce | grep 'j85map' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPad4,7"
   echo $device
fi

./igetnonce | grep 'j86map' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPad4,8"
   echo $device
fi

./igetnonce | grep 'j87map' &> /dev/null
if [ $? == 0 ]; then
   echo "Supported Device"
   device="iPad4,9"
   echo $device
fi

if [ -z "$device" ]
then
    echo "Either unsupported device or no device found."
    echo "Exiting.."
    exit 1
else
    echo "Supported device found."
fi

if [ $device == iPhone10,3 ] || [ $device == iPhone10,6 ]; then
    
    cd ipwndfu
else
    
    cd ipwndfu_public
fi
echo "Starting ipwndfu"

string=$(./ipwndfu -p | grep -c "checkm8")
until [ $string = 2 ];
do
    echo "Attempting to get into pwndfu mode"
    echo "Please just enter DFU mode again on each reboot"
    echo "The script will run ipwndfu again and again until the device is in PWNDFU mode"
    string=$(./ipwndfu -p | grep -c "checkm8")
done

sleep 3

if [ $device == iPhone10,3 ] || [ $device == iPhone10,6 ]; then
    echo "Device is an iPhone X or iPhone 8/8 Plus, using akayn's signature check remover"
    ./ipwndfu --patch
    sleep 1
else
    echo "Device is NOT an iPhone X, using Linus's signature check remover"
    python rmsigchks.py
    sleep 1
fi
cd ..

echo "Device is now in PWNDFU mode with signature checks removed (Thanks to Linus Henze & akayn)"
exit
