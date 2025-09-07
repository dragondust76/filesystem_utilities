#!/bin/bash

# Colorize the title
echo -e "\e[1m\e[34mFilesystem Information:\e[0m"
echo "--------------------------"

# Get list of block devices (disks and partitions)
lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT -P | while read -r line; do
    NAME=$(echo "$line" | awk -F'NAME="' '{print $2}' | awk -F'"' '{print $1}')
    FSTYPE=$(echo "$line" | awk -F'FSTYPE="' '{print $2}' | awk -F'"' '{print $1}')
    SIZE=$(echo "$line" | awk -F'SIZE="' '{print $2}' | awk -F'"' '{print $1}')
    MOUNTPOINT=$(echo "$line" | awk -F'MOUNTPOINT="' '{print $2}' | awk -F'"' '{print $1}')

    if [[ "$FSTYPE" == "" ]]; then
        # This is a disk, print in different color
        echo -e "\e[1m\e[33mDisk: $NAME (Size: $SIZE)\e[0m"
    else
        # This is a partition, print filesystem type and mount point
        echo -e "  \e[32mPartition: $NAME\e[0m (Type: \e[36m$FSTYPE\e[0m, Size: \e[35m$SIZE\e[0m, Mount: \e[31m$MOUNTPOINT\e[0m)"
    fi
done

echo ""
echo -e "\e[1m\e[34mThank You For Using My Disk Information Utility:\e[0m"
echo "--------------------------"

