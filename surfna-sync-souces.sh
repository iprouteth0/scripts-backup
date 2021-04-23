#! /bin/bash

git clone https://github.com/PizzaG/android_vendor_motorola_surfna.git vendor/motorola/surfna &&

git clone https://github.com/PizzaG/android_device_motorola_surfna.git device/motorola/surfna &&

git clone https://github.com/klabit87/android_kernel_motorola_surfna.git kernel/motorola/surfna &&

git clone https://github.com/MotorolaMobilityLLC/motorola-kernel-modules.git -b pie-9.0.0-release-surfna kernel/motorola/surfna/modules
