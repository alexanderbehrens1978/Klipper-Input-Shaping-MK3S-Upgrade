#!/bin/bash

LOGFILE="/tmp/klippy_MK3s_Nr_2_Klipper.log"
OUTLOG="/var/log/prusa-nr2-watchdog.log"

# Drucker eindeutig auswählen
PRINTER_PATH="/dev/serial/by-path/platform-fd500000.pcie-pci-0000:01:00.0-usb-0:1.2.1:1.0"

echo "$(date): [Prusa-Watchdog] Dienst gestartet." >> "$OUTLOG"

last_reset=0

while true; do

    now=$(date +%s)

    if [ -f "$LOGFILE" ] && \
       tail -n 30 "$LOGFILE" | grep -qE \
       "Got EOF when reading from device|Lost communication with MCU|Transition to shutdown state|shutdown clock="; then

        if [ $((now - last_reset)) -gt 30 ]; then

            echo "$(date): [Prusa-Watchdog] FEHLER ERKANNT." >> "$OUTLOG"

            if [ ! -e "$PRINTER_PATH" ]; then
                echo "$(date): [Prusa-Watchdog] Druckerpfad nicht gefunden: $PRINTER_PATH" >> "$OUTLOG"
                sleep 5
                continue
            fi

            REALTTY=$(readlink -f "$PRINTER_PATH")

            USB_NODE=$(udevadm info -q path -n "$REALTTY" | \
                grep -oE '[0-9]+-[0-9]+(\.[0-9]+)+' | \
                tail -1)

            if [ -z "$USB_NODE" ]; then
                echo "$(date): [Prusa-Watchdog] USB_NODE konnte nicht ermittelt werden." >> "$OUTLOG"
                sleep 5
                continue
            fi

            HUB="${USB_NODE%.*}"
            PORT="${USB_NODE##*.}"

            echo "$(date): [Prusa-Watchdog] USB_NODE=$USB_NODE HUB=$HUB PORT=$PORT" >> "$OUTLOG"

            #
            # Klipper stoppen
            #
            systemctl stop klipper_MK3s_Nr_2_Klipper.service
            sleep 2

            #
            # USB-Port ausschalten
            #
            /usr/bin/uhubctl -l "$HUB" -p "$PORT" -a off >> "$OUTLOG" 2>&1
            sleep 3

            #
            # USB-Port einschalten
            #
            /usr/bin/uhubctl -l "$HUB" -p "$PORT" -a on >> "$OUTLOG" 2>&1
            sleep 5

            #
            # Auf Drucker warten
            #
            FOUND=0

            for i in {1..20}; do
                if [ -e "$PRINTER_PATH" ]; then
                    FOUND=1
                    echo "$(date): [Prusa-Watchdog] Drucker nach ${i}s wieder erkannt." >> "$OUTLOG"
                    break
                fi

                sleep 1
            done

            if [ "$FOUND" -eq 1 ]; then
                systemctl start klipper_MK3s_Nr_2_Klipper.service

                echo "$(date): [Prusa-Watchdog] Klipper neu gestartet." >> "$OUTLOG"
            else
                echo "$(date): [Prusa-Watchdog] Drucker wurde nicht wieder erkannt!" >> "$OUTLOG"
            fi

            last_reset=$(date +%s)
        fi
    fi

    sleep 2

done
