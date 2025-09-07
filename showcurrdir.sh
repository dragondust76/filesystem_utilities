#!/bin/bash

echo "Select a file to cause it to blink different colors"
sleep 5
echo "5"
sleep 1
echo "4"
sleep 1
echo "3"
sleep 1
echo "2" 
sleep 1
echo "1"
sleep 2 
echo ".."
sleep 1


# Check if zenity is installed
if ! command -v zenity &> /dev/null
then
    echo "zenity could not be found. Please install it to run this script."
    exit 1
fi

# Get the current directory's files
files=$(ls -1)

# Use zenity to display a file selection dialog
selected_file=$(zenity --file-selection --title="Select a file" --filename=$(pwd)/)

# Check if a file was selected
if [ -n "$selected_file" ]; then
    echo "You selected: $selected_file"

    # Extract just the filename for display
    filename=$(basename "$selected_file")

    # Blinking effect for the selected filename in the terminal
    for i in {1..5}; do
        # ANSI escape codes for blinking and colors
        # \e[5m: Blinking
        # \e[31m: Red foreground
        # \e[32m: Green foreground
        # \e[0m: Reset attributes
        if (( i % 2 == 0 )); then
            echo -e "\e[5m\e[31mSelected file: $filename\e[0m"
        else
            echo -e "\e[5m\e[32mSelected file: $filename\e[0m"
        fi
        sleep 0.5
    done
else
    echo "No file was selected."
fi
