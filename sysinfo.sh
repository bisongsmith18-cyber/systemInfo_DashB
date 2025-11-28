#!/bin/bash
RED="\e[31m"
YELLOW="\e[33m"
GREEN="\e[32m"
RESET="\e[0m"
USER_NAME=$(whoami)
HOST_NAME=$(hostname)
DATE_NOW=$(date)
UPTIME=$(uptime -p)
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_FREE=$(free -m | awk '/Mem:/ {print $4}')
MEM_PERCENT=$(( 100 * MEM_USED / MEM_TOTAL ))
DISK_TOTAL=$(df -h / | awk 'NR==2 {print $2}')
DISK_USED=$(df -h / | awk 'NR==2 {print $3}')
DISK_FREE=$(df -h / | awk 'NR==2 {print $4}')
DISK_PERCENT=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
PROC_TOTAL=$(ps aux | wc -l)
TOP_PROCS=$(ps aux --sort=-%mem | head -6)
if [ "$MEM_PERCENT" -ge 80 ]; then
    MEM_COLOR=$RED
elif [ "$MEM_PERCENT" -ge 60 ]; then
    MEM_COLOR=$YELLOW
else
    MEM_COLOR=$GREEN
fi
if [ "$DISK_PERCENT" -ge 85 ]; then
    DISK_COLOR=$RED
elif [ "$DISK_PERCENT" -ge 60 ]; then
    DISK_COLOR=$YELLOW
else
    DISK_COLOR=$GREEN
fi
clear
echo "===== SYSTEM INFO DASHBOARD ====="
echo
echo "User: $USER_NAME"
echo "Host: $HOST_NAME"
echo "Date: $DATE_NOW"
echo
echo "----- UPTIME -----"
echo "$UPTIME"
echo
echo "----- MEMORY (MB) -----"
echo -e "Total: $MEM_TOTAL | Used: ${MEM_COLOR}$MEM_USED ($MEM_PERCENT%)${RESET} | Free: $MEM_FREE"
echo
echo "----- DISK USAGE -----"
echo -e "Total: $DISK_TOTAL | Used: ${DISK_COLOR}$DISK_USED ($DISK_PERCENT%)${RESET} | Free: $DISK_FREE"
echo
echo "----- PROCESSES -----"
echo "Running: $PROC_TOTAL"
echo
echo "Top 5 by Memory:"
echo "$TOP_PROCS"
echo
echo "===== END ====="