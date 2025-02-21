#!/bin/bash

# Variables
LOG_DIR="/var/log/zRainerzz"  # Your specific app log directory
MAX_LOG_SIZE=10485760  # 10MB in bytes
LOG_FILE_AGE=30  # 30 days
LOG_EXTENSION=".log"

# Ensure log directory exists
mkdir -p "$LOG_DIR"

# Function to rotate logs
rotate_logs() {
    find "$LOG_DIR" -type f -name "*$LOG_EXTENSION" | while read -r log_file; do
        if [ "$(stat -c%s "$log_file")" -gt "$MAX_LOG_SIZE" ]; then
            timestamp=$(date +'%Y%m%d-%H%M%S')
            gzip -c "$log_file" > "$log_file.$timestamp.gz"
            : > "$log_file"  # Truncate instead of moving to maintain active log file
            echo "$(date +'%Y-%m-%d %H:%M:%S') - Log rotated: $log_file -> $log_file.$timestamp.gz" >> "$LOG_DIR/rotation.log"
        fi
    done
}

# Function to clean up old logs
clean_old_logs() {
    find "$LOG_DIR" -type f -name "*.gz" -mtime +"$LOG_FILE_AGE" -exec rm -f {} \;
    echo "$(date +'%Y-%m-%d %H:%M:%S') - Old logs cleaned up" >> "$LOG_DIR/rotation.log"
}

# Function to monitor disk usage
monitor_disk_usage() {
    usage=$(df "$LOG_DIR" | awk 'NR==2 {print $5}' | sed 's/%//')
    if [ "$usage" -gt 90 ]; then
        echo "$(date +'%Y-%m-%d %H:%M:%S') - WARNING: Disk usage exceeded 90% ($usage%)" >> "$LOG_DIR/rotation.log"
    fi
}

# Run functions
rotate_logs
clean_old_logs
monitor_disk_usage
