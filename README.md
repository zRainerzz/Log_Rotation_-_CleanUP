# Log Rotation and Cleanup Script

## Overview
This Bash script automates the rotation and cleanup of log files in a specified directory. It ensures that logs do not exceed a defined size and removes old logs after a set number of days. Additionally, it monitors disk usage and logs warnings if usage exceeds 90%.

## Features
- **Automatic Log Rotation**: Compresses logs exceeding the defined size.
- **Log Cleanup**: Deletes logs older than the configured retention period.
- **Disk Usage Monitoring**: Logs a warning if disk usage surpasses 90%.
- **Timestamps for Actions**: Keeps a record of rotation and cleanup events.

## Installation
1. Clone this repository:
   ```bash
   git clone https://github.com/zRainerzz/log-rotation-script.git
   ```
2. Navigate to the script directory:
   ```bash
   cd log-rotation-script
   ```
3. Make the script executable:
   ```bash
   chmod +x log_rotate.sh
   ```

## Configuration
Modify the following variables in the script as needed:
```bash
LOG_DIR="/var/log/zRainerzz"  # Change to your desired log directory
MAX_LOG_SIZE=10485760  # Set max log size (default: 10MB)
LOG_FILE_AGE=30  # Set log retention period in days (default: 30)
LOG_EXTENSION=".log"  # Change if needed
```

## Usage
Run the script manually:
```bash
./log_rotate.sh
```
Or schedule it using a cron job for automation:
```bash
crontab -e
```
Add a line to execute the script daily at midnight:
```bash
0 0 * * * /path/to/log_rotate.sh
```

## Logs & Monitoring
- Rotation and cleanup actions are logged in `rotation.log` within the specified log directory.
- Disk usage warnings are also recorded in `rotation.log`.

## License
This project is licensed under the MIT License.

## Author
Developed by [zRainerzz](https://github.com/zRainerzz).

