#!/bin/bash
#
# Copyright (C) 2016 BeansTown106 for PureNexus Project
# Copyright (C) 2021 A-Team Digital Solutions
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
clear

# Variables
## Device 1
SOURCE1=~/Android/BuildScripts/ginna
## Device 2
SOURCE2=~/Android/BuildScripts/idol4
## Device 3
SOURCE3=~/Android/BuildScripts/matissewifi
## Device 4
SOURCE4=~/Android/BuildScripts/tank
## Device 5
SOURCE5=~/Android/BuildScripts/douglas
## Upload Menu
SOURCE6=~/Android/BuildScripts
## Uploads
UPLOAD=~/Android/Uploads

# Colors
black=`tput setaf 0`
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`
reset=`tput sgr0`


#functions
device1() {
  # Run Master Builder Script
  cd ${SOURCE1}
  . DeviceMenu.sh  
}

device2() {
  # Run Master Builder Script
  cd ${SOURCE2}
  . DeviceMenu.sh  
  read
}

device3() {
  # Run Master Builder Script
  cd ${SOURCE3}
  . Builder-matissewifi.sh  
  read
}

device4() {
  # Run Master Builder Script
  cd ${SOURCE4}
  . Builder-tank.sh  
  read
}

device5() {
  # Run Master Builder Script
  cd ${SOURCE5}
  . Builder-douglas.sh  
  read
}

upload() {
  # Run Master Builder Script
  cd ${SOURCE6}
  . UploadMenu.sh  
}

# ----------------------------------------------------------
menu=
until [ "$menu" = "0" ]; do
echo ""
echo "${cyan}=========================================================${reset}"
echo "${cyan}==${reset}${yellow}           A-Team Multi Device Master Menu           ${reset}${cyan}==${reset}"
echo "${cyan}==${reset}${yellow}       Lets get Ready To Build For The Masses!       ${reset}${cyan}==${reset}"
echo "${cyan}=========================================================${reset}"
echo "${cyan}==${reset}${white}   1 - Moto E 2020 Menu                              ${reset}${cyan}==${reset}"
echo "${cyan}==${reset}${white}   2 - Idol 4 Menu                                   ${reset}${cyan}==${reset}"
echo "${cyan}==${reset}${white}   3 - Galaxy Tab 4 10.1 Menu                        ${reset}${cyan}==${reset}"
echo "${cyan}==${reset}${white}   4 - Firestick 4k Menu                             ${reset}${cyan}==${reset}"
echo "${cyan}==${reset}${white}   5 - Fire HD8 Menu                                 ${reset}${cyan}==${reset}"
echo "${cyan}==${reset}${white}   6 - Upload Menu                                   ${reset}${cyan}==${reset}"
echo "${cyan}==${reset}${red}   0 - Exit                                          ${reset}${cyan}==${reset}"
echo "${cyan}=========================================================${reset}"
echo ""
echo -n "Enter selection: "
read menu
echo ""
case ${menu} in
1 )
  # Moto E 2020 Menu
  clear
  BEGIN=$(date +%s)
  device1
  END=$(date +%s)
  clear
;;
#############################################################

2 )
  # Idol 4 Menu
  clear
  BEGIN=$(date +%s)
  device2
  END=$(date +%s)
  clear
;;
#############################################################

3 )
  # Galaxy Tab 4 10.1 Menu
  clear
  BEGIN=$(date +%s)
  device3
  END=$(date +%s)
  clear
;;
#############################################################

4 )
  # Firestick 4k Menu
  clear
  BEGIN=$(date +%s)
  device4
  END=$(date +%s)
  clear
;;
#############################################################

5 )
  # Fire HD8 Menu
  clear
  BEGIN=$(date +%s)
  device5
  END=$(date +%s)
  clear
;;
#############################################################

6 )
  # Upload Menu
  clear
  BEGIN=$(date +%s)
  upload
  END=$(date +%s)
  clear
;;
#############################################################

7 )
  # Delete Files in Uploads Folder
  rm -rf ~/Android/Uploads/Recoveries/*
  rm -rf ~/Android/Uploads/Roms/*
  rm -rf ~/Android/Uploads/ToolKits/*
  #rm -rf ~/Android/Uploads/Roms/*
  echo "${green}Wiped Android File Host Files!!${reset}"
;;
#############################################################

0 ) clear ;;
0 ) kill -INT $$ ;;
* ) clear
    echo "Wrong Choice AssFace, 1-7 or 0 to exit"
    sleep 1
    echo ""
    echo "4"
    sleep 1
    echo "3"
    sleep 1
    echo "2"
    sleep 1
    echo "1"
    sleep 1
    clear
    esac
done
#############################################################
