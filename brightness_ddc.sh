#!/bin/bash

# Get the current brightness value (removes extra spaces)
current_brightness=$(ddcutil getvcp 10 | awk -F 'current value =|,' '{print $2}' | tr -d ' ')

# If brightness retrieval fails, default to 50 (to avoid script breakage)
if [[ -z "$current_brightness" ]]; then
    current_brightness=50
fi

# Define max brightness and step size
max_brightness=100
min_brightness=0
step=5  # Change this if you want finer brightness control

# Adjust brightness
if [[ "$1" == "up" ]]; then
    new_brightness=$((current_brightness + step))
elif [[ "$1" == "down" ]]; then
    new_brightness=$((current_brightness - step))
else
    echo "Usage: brightness_ddc up|down"
    exit 1
fi

# Ensure brightness stays within valid limits
if (( new_brightness > max_brightness )); then
    new_brightness=$max_brightness
elif (( new_brightness < min_brightness )); then
    new_brightness=$min_brightness
fi

# Apply the new brightness setting
ddcutil setvcp 10 $new_brightness

