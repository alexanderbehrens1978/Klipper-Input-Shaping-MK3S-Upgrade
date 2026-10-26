#!/bin/bash
# Kurze Pause, bis das Board nach dem Einschalten da ist
sleep 1
# USB-Reset ausführen
/usr/bin/usbreset 2c99:0002 > /dev/null 2>&1
# Klipper über systemctl neu anstoßen
/usr/bin/systemctl restart klipper > /dev/null 2>&1
