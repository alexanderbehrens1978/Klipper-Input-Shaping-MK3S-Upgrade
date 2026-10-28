#!/bin/bash

LOGFILE="/tmp/klippy_MK3s_Nr_2_Klipper.log"
OUTLOG="/var/log/prusa-nr2-watchdog.log"
HUB="1-1.3"
PORT="2"
VEND="2c99"
PROD="0002"

echo "$(date): [Prusa-Watchdog] Dienst gestartet und aktiv." >> "$OUTLOG"

last_reset=0

while true; do
    now=$(date +%s)
    
    if [ -f "$LOGFILE" ] && tail -n 30 "$LOGFILE" | grep -qE "Got EOF when reading from device|Lost communication with MCU|Transition to shutdown state|shutdown clock="; then
        
        if [ $((now - last_reset)) -gt 30 ]; then
            echo "$(date): [Prusa-Watchdog] FEHLER ERKANNT! Starte Reset..." >> "$OUTLOG"
            
            # 1. Klipper stoppen
            systemctl stop klipper 2>/dev/null
            sleep 0.5
            
            # 2. USB-Port stromlos machen
            /usr/bin/uhubctl -l "$HUB" -p "$PORT" -a 0 2>/dev/null
            sleep 1.5
            
            # 3. USB-Port einschalten
            /usr/bin/uhubctl -l "$HUB" -p "$PORT" -a 1 2>/dev/null
            sleep 1
            
            # 4. Hub Rebind
            echo "$HUB" > /sys/bus/usb/drivers/usb/unbind 2>/dev/null
            sleep 0.5
            echo "$HUB" > /sys/bus/usb/drivers/usb/bind 2>/dev/null
            
            # 5. Warten auf USB
            for i in {1..10}; do
                if lsusb | grep -q "${VEND}:${PROD}"; then
                    echo "$(date): [Prusa-Watchdog] Drucker nach ${i}s am USB-Bus erkannt." >> "$OUTLOG"
                    break
                fi
                sleep 0.8
            done
            
            sleep 1.5
            
            # 6. Klipper starten
            systemctl start klipper
            echo "$(date): [Prusa-Watchdog] Klipper neu gestartet." >> "$OUTLOG"
            
            last_reset=$(date +%s)
        fi
    fi

    sleep 2
done
