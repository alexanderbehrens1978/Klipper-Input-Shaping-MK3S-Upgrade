#!/home/alex/printer_data/config/scripts/tapo_env/bin/python3
import sys
import asyncio
import time
import subprocess
from tapo import ApiClient

KLIPPER_SERVICE = "klipper_MK3s_Nr_2_Klipper.service"
TAPO_IP = "IP Adresse"        # IP deiner Tapo P110
TAPO_USER = "Email"
TAPO_PASS = "Passwort"

async def main():
    if len(sys.argv) < 2:
        print("Nutze: tapo_mk3snr2_control.py [on|off]")
        return

    command = sys.argv[1]
    client = ApiClient(TAPO_USER, TAPO_PASS)
    device = await client.p110(TAPO_IP)

    if command == "on":
        await device.on()
        print("Tapo Steckdose eingeschaltet.")
        
        print("Warte 3 Sekunden auf Drucker-Boot...")
        time.sleep(3.0)
        
        try:
            print(f"Starte Klipper-Dienst ({KLIPPER_SERVICE}) neu...")
            subprocess.run(["sudo", "systemctl", "restart", KLIPPER_SERVICE], check=True)
            print("Klipper erfolgreich neu gestartet.")
        except Exception as e:
            print(f"Fehler beim Neustarten des Klipper-Dienstes: {e}")

    elif command == "off":
        await device.off()
        print("Tapo Steckdose ausgeschaltet.")

if __name__ == "__main__":
    asyncio.run(main())
