#!/bin/bash
echo "===== SYSTEM INFO ====="
USER_NAME=$(whoami)
HOST_NAME=$(hostname)
DATE_TIME=$(date)
echo "User: $USER_NAME"
echo "Host: $HOST_NAME"
echo "Date: $DATE_TIME"
echo "--- Uptime ---"
UPTIME_STR=$(uptime -p)
echo "$UPTIME_STR"
echo "--- Memory (MB) ---"
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_FREE=$(free -m | awk '/Mem:/ {print $7}')
echo "Total: ${MEM_TOTAL}MB | Used: ${MEM_USED}MB | Free: ${MEM_FREE}MB"
echo "--- Disk Usage ---"
DISK_TOTAL=$(df -h / | awk 'NR==2 {print $2}')
DISK_USED=$(df -h / | awk 'NR==2 {print $3}')
DISK_FREE=$(df -h / | awk 'NR==2 {print $4}')
echo "Total: $DISK_TOTAL | Used: $DISK_USED | Free: $DISK_FREE"
echo "--- Processes ---"
PROC_COUNT=$(ps aux | wc -l)
echo "Running: $PROC_COUNT"
echo "Top 5 by memory:"
ps aux --sort=-%mem | head -n 6 | awk 'NR>1 {printf "%-8s %-20s %s%%\n", $2, $11, $4}'