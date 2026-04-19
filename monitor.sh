#!/usr/bin/env bash
# monitor.sh — Real-time system monitoring dashboard
set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/config.cfg"

mkdir -p "${SCRIPT_DIR}/${LOG_DIR}" "${SCRIPT_DIR}/${REPORT_DIR}"

# ANSI colors
RST="\033[0m"
BOLD="\033[1m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
GREEN="\033[1;32m"
CYAN="\033[1;36m"
MAGENTA="\033[1;35m"
BLUE="\033[1;34m"
WHITE="\033[1;37m"
BG_RED="\033[41m"
BG_YELLOW="\033[43m"
BG_GREEN="\033[42m"


color_by_threshold() {
	local val=$1 wrn=$2 cri=$3
	val=$(echo $val | awk '{print int($1 + 0.5)}') #acts a celing and flour function for decimal values
	if [[ $val -gt $cri ]] || [[ $val -eq $cri ]]; then
		echo -ne $RED
	elif [[ $val -gt $wrn ]] || [[ $val -eq $wrn ]]; then
		echo -ne $YELLOW
	else
		echo -ne $GREEN
	fi
}
