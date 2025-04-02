#!/bin/bash
# system_info.sh
# This script displays the OS version, lists all users with a bash shell, and shows open ports.

echo "========== OS Version Information =========="
# Try to use /etc/os-release if available; fallback to uname
if [ -f /etc/os-release ]; then
  cat /etc/os-release
else
  uname -a
fi

echo -e "\n========== Users with Bash Shell =========="
# List users with /bin/bash in their login shell from /etc/passwd
awk -F: '$NF=="/bin/bash" {print $1}' /etc/passwd

echo -e "\n========== Open Ports =========="
# Check for open ports using netstat or ss, whichever is available.
if command -v netstat &>/dev/null; then
  echo "Using netstat:"
  netstat -tuln
elif command -v ss &>/dev/null; then
  echo "Using ss:"
  ss -tuln
else
  echo "Neither netstat nor ss command found. Please install one of these utilities."
fi
