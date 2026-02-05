#!/bin/bash
echo "=== RAPPORT SYSTEME ==="
echo "Hostname : $(hostname)"
echo "Uptime : $(uptime -p)"
echo "Load : $(cat /proc/loadavg | awk '{print $1,$2,$3}')"
echo "RAM : $(free -h | awk '/Mem:/ {print $3 "/" $2}')"
echo "Disque : $(df -h / | awk 'NR==2 {print $3 "/" $2 " (" $5 ")"}')"
echo "IP : $(hostname -I | awk '{print $1}')"
echo "======================="