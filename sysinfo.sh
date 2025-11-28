#!/bin/bash

RED="\e[31m"
YELLOW="\e[33m"
GREEN="\e[32m"
CYAN="\e[36m"
BLUE="\e[34m"
MAGENTA="\e[35m"
BOLD="\e[1m"
RESET="\e[0m"

USER_NAME=$(whoami)
HOST_NAME=$(hostname)
DATE_NOW=$(date)

UPTIME=$(uptime -p)

MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_FREE=$(free -m | awk '/Mem:/ {print $4}')
MEM_FREE_PCT=$(( MEM_FREE * 100 / MEM_TOTAL ))

DISK_TOTAL=$(df -h / | awk 'NR==2 {print $2}')
DISK_USED=$(df -h / | awk 'NR==2 {print $3}')
DISK_FREE=$(df -h / | awk 'NR==2 {print $4}')
DISK_FREE_PCT=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
DISK_FREE_PCT=$((100 - DISK_FREE_PCT))

if (( MEM_FREE_PCT < 15 )); then
    MEM_COLOR=$RED
elif (( MEM_FREE_PCT < 30 )); then
    MEM_COLOR=$YELLOW
else
    MEM_COLOR=$GREEN
fi

if (( DISK_FREE_PCT < 15 )); then
    DISK_COLOR=$RED
elif (( DISK_FREE_PCT < 30 )); then
    DISK_COLOR=$YELLOW
else
    DISK_COLOR=$GREEN
fi

PROC_TOTAL=$(ps aux | wc -l)
TOP_PROCS=$(ps aux --sort=-%mem | head -6)

clear
echo -e "${BOLD}${MAGENTA}===== SYSTEM INFO DASHBOARD =====${RESET}\n"

echo -e "${CYAN}User:${RESET} $USER_NAME"
echo -e "${CYAN}Host:${RESET} $HOST_NAME"
echo -e "${CYAN}Date:${RESET} $DATE_NOW"
echo

echo -e "${BOLD}${BLUE}----- UPTIME -----${RESET}"
echo "$UPTIME"
echo

echo -e "${BOLD}${BLUE}----- MEMORY (MB) -----${RESET}"
echo -e "Total: $MEM_TOTAL | Used: $MEM_USED | Free: ${MEM_COLOR}$MEM_FREE (${MEM_FREE_PCT}%)${RESET}"
echo

echo -e "${BOLD}${BLUE}----- DISK USAGE -----${RESET}"
echo -e "Total: $DISK_TOTAL | Used: $DISK_USED | Free: ${DISK_COLOR}$DISK_FREE (${DISK_FREE_PCT}%)${RESET}"
echo

echo -e "${BOLD}${BLUE}----- PROCESSES -----${RESET}"
echo -e "${CYAN}Running:${RESET} $PROC_TOTAL"
echo
echo -e "${CYAN}Top 5 by Memory:${RESET}"
echo "$TOP_PROCS"
echo
echo -e "${BOLD}${MAGENTA}===== END =====${RESET}"