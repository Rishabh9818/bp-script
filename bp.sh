#!/bin/bash
set -x
# Get current date in YYYY-MM-DD format
current_date=$(date +'%Y-%m-%d')

log_file="/var/log/buildpiper/api/$current_date.log"
shutdown_command="sudo shutdown -h now"

# Get the last modification time of the log file if it exists
if [ -f "$log_file" ]; then
    last_modified=$(stat -c %Y "$log_file")
else
    echo "Log file not found!"
    last_modified=0 
fi

current_time=$(date +%s)
time_difference=$((current_time - last_modified))

if [ "$time_difference" -ge 120 ]; then
    echo "No new logs found in the last 2 minutes or log file not found. Initiating shutdown..."
    $shutdown_command
else
    echo "New logs have been generated within the last 2 minutes."
fi
