Klipperized Input Shaping für die MK3S/+, ein vereinfachter Leitfaden für ein leistungsstarkes Upgrade
Neueste Updates:

6/2026

Verschiedene Updates anderer Mitwirkender wurden zusammengeführt
4/2025

Aktualisierung der Leitlinien
Ich habe die PrusaSlicer-Einstellungen basierend auf der neuesten Version (2.9.2 zum Zeitpunkt des Schreibens) überarbeitet.
Aktualisierte IS-Anweisungen basierend auf dem aktuellen Klipper.
Aktualisierung der Makros
Druckstart und -reinigung wurden geändert, sodass sie eher wie beim MK4 sind.
Das Druckende erhöht den Werkzeugkopf auf mindestens 50 mm, um leichter an das Entfernen des restlichen Filaments vor dem nächsten Start heranzukommen.
Filament-Runout nutzt es wieder, entlastet das Filament-Makro und parkt an einem günstigeren Ort.
Die Filamententladung verwendet die MK3.5-Sequenz für einen saubereren Bruch
IS-Update – Unterstützung für BIGTREETECH (BTT) ADXL345 Beschleunigungsanzeigetafel.
Adaptive Bettgitter-Kalibrierung aktivieren
Schritt-Einstellungen für Strom und Mikroschritte auf MK3.5-Werte eingestellt
17.04.2024 – Anleitung – In PrusaSlicer, Druckeinstellungen > Fortgeschritten: "Arc Fitting" deaktivieren – G2/G3 sollte nicht mit Klipper verwendet werden und ist nicht notwendig.

02.04.2024 – Makro zur mechanischen Gantry-Kalibrierung entfernt. Ich bin mir nicht sicher, ob es jemals richtig funktioniert hat.

01.04.2024 – Fehlende Tabs auf PRUSA_LINE_PURGE in Makros behoben und doppelte gcode_arc Zeilen in einsy-rambo entfernt.

27.03.2024 – Filament-Runout-Code aktualisiert, um eine doppelte Pause zu verhindern

26.03.2024 – Doppelte Makros Pause/Cancel/Resume aus macros.cfg entfernt

25.03.2024 – "Pullups" zu einsy-rambo.cfg hinzugefügt

Hast du es satt, alle auf MK4 upgraden zu sehen und das Gefühl zu haben, die Action zu verpassen? Dieses Projekt ist der Versuch, eine einfache, leicht verständliche Dokumentation für ein kostengünstiges, einfaches und leistungsstarkes Upgrade Ihres Prusa MK3S/+ zu erstellen. Ursprünglich basierend auf Arbeiten von dz0ny (https://github.com/dz0ny/klipper-prusa-mk3s).

WARNUNG: Dieses Upgrade beinhaltet die Nutzung und Installation von Klipper, was ein deutlich anderes Erlebnis ist als Prusas Firmware. Denk an Klipper = Custom Android, vs. Prusa = Apple iOS. Klipper ist mächtig, kann aber potenziell gefährlich sein, wenn er falsch konfiguriert ist. Wir übernehmen keine Verantwortung für Schäden oder Verletzungen. Dieser Leitfaden und die Konfigurationsdateien können Fehler oder Auslassungen enthalten.

Stand 31.03.2024 – Aktuelle Diskussionen und Live-Hilfe finden Sie hier, möglicherweise müssen Sie zuerst dem Klipper Discord beitreten: https://discord.klipper3d.org/ in diesem Kanal: https://discord.com/channels/431557959978450984/1205590905378312293

Es gibt mehrere Gründe, warum Sie dieses Upgrade ausprobieren sollten:

Geschwindigkeit – Wie Sie vielleicht wissen, kann Input Shaping erhebliche Geschwindigkeits- und Druckqualitätsverbesserungen für Ihren Drucker ermöglichen. Das ist gerade total angesagt in der 3D-Druck-Community.
Niedrige Kosten – Es ist günstig und benötigt nur 50-100 Dollar an Hardware, was im Vergleich zum Prusa MKS3.5 Upgrade Kit eine angemessene Einsparung darstellt.
Einfachheit – Wir haben unsere Anleitung und Dokumentation so strukturiert, dass es so einfach wie möglich ist, obwohl Klipper beteiligt ist und historisch als schwierig umzusetzen galt. Klipper ist sehr mächtig und kann einfach sein, wenn es richtig umgesetzt wird.
Einfach zurückzusetzen – Dieses Upgrade rückgängig zu machen und zur Original-Prusa-Firmware zurückzuführen, dauert nur wenige Schritte und kann in weniger als 10 Minuten abgeschlossen werden.
Kein Abfall – Ihr MK3S/+ Drucker sammelt keinen Staub. Viele in der Prusa-Community empfehlen entweder beim Verkauf einen MK4 zu kaufen oder den MK3S zu behalten. Dieses Upgrade ermöglicht es Ihnen, Ihren Drucker zu behalten, erhöht die Geschwindigkeit erheblich und erhöht möglicherweise die Druckqualität.
Wie machen wir das?

Wir werden Input Shaping auf deinem MK3S/+ mit Hilfe von Klipper implementieren. "AU, Klipper?! Ist das nicht super kompliziert?" Nein, auch wenn Klipper schwierig zu bedienen sein kann, haben wir für Sie die Arbeit investiert, um eine einfache Installation und Konfiguration von Klipper zu ermöglichen. Das bedeutet nicht zwangsläufig, dass es einfach sein wird, denn die Implementierung von Klippers Input Shaping kann Hardware-Fehlkonfigurationen aufdecken.

Was, wenn ich wieder auf Lager gehen muss?

Das Rückgängigmachen dieses Upgrades und die Rückkehr zur Original-Prusa-Firmware kann in weniger als 10 Minuten abgeschlossen werden. Bitte siehe den Abschnitt "Zurück zur Standard-Prusa-Firmware".

Benötigte Hardware
Prusa MK3S oder MK3S+

Während die Konfigurationsdateien für dieses Projekt für die Verwendung mit dem STOCK-Hotend und Extruder gedacht sind. Weitere unten aufgeführte Hotends und Extruder können mit einer modifizierten Konfiguration verwendet werden, liegen jedoch außerhalb des Bereichs dieses Repositorys. Für Beispielkonfigurationen siehe bitte das dz0ny-Repository, auf dem dieses Projekt basiert: https://github.com/dz0ny/klipper-prusa-mk3s
Mögliche Hotends: Stock, Dragon ST, Dragon HF, Revo und viele andere werden von Klipper selbst unterstützt.
Mögliche Extruder: Aktien, Bondtech BMG und viele andere werden von Klipper selbst unterstützt.
Wie bei der Prusa-Firmware erfordern auch nicht serienmäßige Extrudern umfangreichere Anpassungen der Konfiguration.
Raspberry Pi (eine der folgenden Optionen)

Raspberry Pi 3B+: https://amzn.to/3PuZN7D
Raspberry Pi 4: https://amzn.to/4a2ZE3p
Raspberry Pi Zero 2 W (erfordert USB-Adapter im Kit): https://amzn.to/3ODvStE
MainSailOS unterstützt außerdem den Orange Pi Zero 2 und den Orange Pi 3 LTS / 4 LTS.
Der Raspberry Pi Zero 1 W wird nicht empfohlen, da er zu wenig Leistung hat.
USB-Typ-B-Männchen-zu-USB-Typ-A-Männelkabel (Wurde mit deiner Prusa geliefert)

USB Type A Weibchen-zu-MicroUSB-Männchenkonverter (bei Verwendung eines Pi Zero 2 W, enthalten im oben verlinkten Kit)

Ein Beschleunigungsmesser (ermöglicht eine einfachere Input Shaping-Kalibrierung, optional, aber empfohlen):

Direkte Unterstützung in diesem Leitfaden wird bereitgestellt für:
KUSBA: Klipper USB-Beschleunigungsmeter (~20 USD): https://amzn.to/4bzgAzA
HINWEIS: 01.03.2024 – 3D-gedruckte KUSBA-Halterungen online funktionierten, mussten aber angepasst werden, um zu passen; der an der Düse montierte Beschleunigungsmeter könnte besser funktionieren.
BTT: BIGTREETECH USB Accelerometer v2.0 (~16 USD): https://amazon.com/dp/B0CHJQ6CXF
Am einfachsten am MK3S+ zu montieren
Alternative Optionen, die möglicherweise eine gewisse Konfiguration erfordern:
Günstigere Alternative: BTT Nozzle-mountable USB Accelerometer v1.0 (~14 USD): https://amzn.to/4cg55gQ
Eine weitere Alternative: FYSETC 3D (~17 USD) https://amzn.to/3VqvN0B
Als Amazon Associate verdiene ich durch qualifizierte Käufe.

Überblick über das Verfahren auf hoher Ebene (siehe detaillierte Leitfaden unten)
Drucke erst mit PrusaSlicer mit PrusaSlicer bis Schritt 6!

Installiere MainsailOS auf deinem Raspberry Pi
Erstellen Sie die Konfiguration mit den Primärkonfigurationsdateien in diesem Repository
Flash-Firmware
Verwenden Sie die USB-Methode, die serielle Methode ist möglicherweise nur für einige Nutzer notwendig
Führen Sie Konfigurationsprüfungen durch
PrusaSlicer für Klipper anpassen
Folge Ellis' Leitfaden für die wichtigsten Abstimmungsschritte (NICHT OPTIONAL)
Führen Sie Kalibrierungen und Messungen des Input Shapers durch – Zur Info: Dieser Schritt hat für mich als Secondhand-Drucker persönlich mehrere Hardware-Fehlkonfigurationen/Probleme aufgedeckt.
Wiederholen Sie die Druckvorschiebungskalibrierung nach Aktivierung des IS
Detaillierte Verfahren
Schritt 0. Pre-Check und Erwartungen
Sehen Sie sich dieses YouTube-Video für eine grundlegende Einführung in Klipper an: https://www.youtube.com/watch?v=iNHta6zljoM
Je nachdem, wie gut du mit Klipper vertraut bist, kannst du damit rechnen, dass dieser gesamte Prozess (einschließlich Tuning, das am zeitaufwendigsten ist) zwischen 5 und 20 Stunden dauern wird. Dieser Bereich ist groß, weil er von: 1) deiner eigenen Vertrautheit mit Tuning-Verfahren abhängt, die Prusa normalerweise für dich übernimmt, 2) deiner Vertrautheit mit Klipper, 3) deiner Vertrautheit mit Tools wie Raspberry Pi, SSH und Kommandozeilenschnittstellen. Es kann auch eher hoch sein, wenn Hardware-Fehlkonfigurationen zu Problemen wie starken Vibrationen im Drucker beitragen, was die Input Shapeing-Kalibrierung bis zur Adressierung erschwert. Bitte seid darauf vorbereitet.
Hol dir den Z-Offset-Wert aus deiner aktuellen Firmware (Menü -> Kalibrierung > Z-Offset), du brauchst ihn für die Klipper-Konfiguration.
Dein Bett muss senkrecht stehen (basierend auf den Kalibrierungsergebnissen von Prusa XYZ). Ein ungleichmäßiger Drucker bedeutet, dass Sie zuerst die physische Hardware reparieren und die Montageanleitung erneut überprüfen müssen. Wenn nicht, musst du vor dem Drucken die Schietkalibrierung durchführen, sonst riskierst du, dass deine Düse am Bett abstürzt.
Einige der Anleitungen werden direkte Links zu externen Anleitungen sein, was hier keinen Sinn machen würde, insbesondere Ellis' 3D-Druck-Handbuch.
Schritt 1. Installiere MainSailOS auf deinem Raspberry Pi
Wir verwenden MainSailOS, da es Ihnen alle Komponenten bereitstellt, die Sie für Ihren Raspberry Pi benötigen. Es gibt noch andere Methoden, aber das ist die einfachste.
Bitte folgen Sie diesem externen Leitfaden: https://docs-os.mainsail.xyz/
Schritt 2. Verbinden Sie sich mit Raspberry Pi über den PC und konfigurieren Sie Klipper
Mit einem Webbrowser navigieren Sie zu der von Ihnen ausgewählten URL für Ihren Drucker, zum Beispiel .mainsailos.local
Sobald es geladen ist, ist dies deine primäre Schnittstelle, um dich an deinen Raspberry Pi und den Drucker an einem Ort zu verbinden. Denk daran, der Pi wird den Drucker genauso betreiben wie das Einsy-Board bei deinem Prusa.
Navigiere zur Maschine. Im Root-Dropdown-Menü wähle "config" aus. Hier befinden sich Klippers kritische Konfigurationsdateien.
Im Update Manager rechts aktualisieren Sie alles. AKTUALISIERE DIESE IN ZUKUNFT NICHT, ES SEI DENN, DU BIST SICHER, DASS SIE DEINE KONFIGURATION NICHT KAPUTT MACHEN.
Im Config-Ordner verwenden Sie die in den primären Konfigurationsdateien dieses Repositorys gefundenen Dateien, um die bestehenden Dateien zu ersetzen: https://github.com/charminULTRA/Klipper-Input-Shaping-MK3S-Upgrade/tree/main/1%20-%20Primary%20Configuration%20Files
HINWEIS: Entweder benennen Sie Printer.Template.cfg um oder kopieren und fügen Sie den Inhalt in Ihre eigene printer.cfg ein.
Bearbeiten Sie die printer.cfg nach Bedarf, die Anweisungen befinden sich in der Datei printer.template.cfg.
Bearbeite die anderen Dateien NICHT, wenn du nicht weißt, was du tust.
Sobald alle Dateien aktualisiert wurden, klicke oben rechts auf das Power-Symbol und wähle "Neustart".
Schritt 3. Verbinde den physischen Drucker Prusa MK3S/+ und flashe die Klipper-Firmware auf deinen Drucker
Schließe das USB-Typ-B-Male-auf-USB-A-Malekabel zwischen deinem Raspberry Pi und deinem Prusa-Drucker an.
Wir werden jetzt einige Befehle ausführen, die das Using SSH flashen lassen (bitte googeln Sie nach geeigneten Methoden je nach Betriebssystem Ihres PCs), sich mit Ihrem Raspberry Pi verbinden und sich anmelden.
Führen Sie die folgenden Befehle nacheinander aus:
cd ~/klipper/
make menuconfig
Im Konfigurationsmenü sollte die Firmware für den AVR atmega2560 kompiliert werden. Um sie über USB zu verwenden, wähle in "make menuconfig" "Zusätzliche Low-Level-Konfigurationsoptionen aktivieren" und wähle UART0, wenn du eine Verbindung über USB planst. Fahren Sie fort, indem Sie folgenden Befehl ausführen, um die eindeutige Port-ID Ihres Druckers zu bestimmen:

ls /dev/serial/by-id/*
Danach kannst du die folgenden Tests einzeln durchlaufen. Stellen Sie sicher, dass Sie die YOUR_UNQIUE_ID mit der einzigartigen USB-Port-ID des Druckers aktualisieren.

sudo service klipper stop
make flash FLASH_DEVICE=/dev/serial/by-id/YOUR_UNIQUE_ID
sudo service klipper start
Wenn dieser Prozess fehlschlägt, ist es möglich, dass Sie über den Seriellen Anschluss verbinden müssen, was ein aufwändiger Prozess ist und eine Hardwaremodifikation erfordert. Der Serial-Port-Ansatz ist für diesen Guide außerhalb des Umfangsbereichs. Bitte suchen Sie bei Google nach der Methode oder wenden Sie sich auf dem Klipper-Discord: https://discord.com/channels/431557959978450984/1205590905378312293

Bekanntes Problem: ATmega 32u2 USB-Seriellbeschädigung
Das Einsy RAMBo-Board verwendet einen ATmega 32u2-Chip als USB-zu-Seriell-Brücke zwischen deinem Pi und dem Haupt-ATmega 2560. Prusas Standard-Firmware auf diesem Chip weist einen bekannten Fehler auf, der die serielle Daten unter Klippers Durchsatz beschädigt. Dies zeigt sich in steigenden Zahlen in Klippers Statistiken, was schließlich zu "Kommunikationsverlust mit dem MCU" führt – oft mitten im Druck.bytes_invalid

Zu den Symptomen gehören:

bytes_invalid Klettern während des Drucks (prüfen bei grep bytes_invalid ~/printer_data/logs/klippy.log | tail -5)
Zufällige MCU-Verbindungsabbrüche, besonders bei schnellen Bewegungen oder langen Prints
Auf Pi Zero 2W: USB-Absturz zerstört auch WLAN (gemeinsamer Bus), was einen vollständigen Neustart erfordert
Behebung: Flashe die Hoodserial-Firmware mit einem ISP-Programmierer auf die 32u2. Dies erfordert einen USBasp-Programmierer (8 $) und einen 10-poligen-zu-6-poligen ISP-Adapter (6 $). Siehe den 32u2 Hoodserial Flash Guide für das vollständige getestete Verfahren. Nach dem Flashen sinkt es auf null.bytes_invalid

Schritt 4. Führen Sie Konfigurationsprüfungen und PID-Abstimmung durch
Führen Sie alle Verifizierungs- und PID-Abstimmungsanweisungen MIT Ausnahme von Endstopps auf der Klipper-Konfigurationsprüfungsseite durch: https://www.klipper3d.org/Config_checks.html

Schritt 5. Customize PrusaSlicer für Klipper (NICHT AUS DEM SLICER DRUCKEN, BIS SCHRITT 6 ABGESCHLOSSEN IST!!)
Fügen Sie MK3.5-Drucker über den Konfigurationsassistenten zur PrusaSlicer-Konfiguration hinzu
Stellen Sie sicher, dass Sie sich im "Expertenmodus" befinden, indem Sie ihn im Modus-Dropdown-Menü oben rechts im Fenster auswählen.
Kopieren Sie den MK3.5-Drucker:
Geh zu Abhängigkeiten > "Vom System-Preset trennen"

Nennen Sie den neu abgetrennten Drucker um, Sie können diesen jetzt für Ihr Klipper-Druckerprofil verwenden.

Öffne deinen neuen Drucker, indem du zu "Drucker" gehst und deinen neuen Drucker im Dropdown-Menü oben links auswählst.

Setze G-Code-Flavour auf Klipper, indem du zu General > Firmware gehst> setze "G-Code Flavor" auf "Klipper"

Deaktiviere binären G-Code, indem du zu General > Firmware gehst > "Supports binary G-code" deaktivierst.

Lösche alles unter Custom G-Code

Lösche ALLE vorhandenen Daten in ALLEN Boxen.
Deaktivieren Sie "Automatisch Temperaturbefehle aussenden"
Setze den Start- und Endcode auf den untenstehenden Inhalt. Du wirst nicht den werkseitigen Start- und End-G-Code verwenden. Die Befehle "PRINT_START" und "PRINT_END" aktivieren die identisch benannten Makros in deiner macros.cfg-Datei. Makros sind wie Container für ihren eigenen Gcode-Satz, der leichter referenzierbar ist.

Startcode MK3S+

PRINT_START EXTRUDER_TEMP=[first_layer_temperature] BED_TEMP=[first_layer_bed_temperature]
Startcode MK3S

PRINT_START EXTRUDER_TEMP=[first_layer_temperature] BED_TEMP=[first_layer_bed_temperature] PRINTER_MODEL="MK3S"
Endcode

PRINT_END
Speichere dein Preset, indem du auf das Speichersymbol oben auf dem Bildschirm klickst.

Kopieren Sie die Werks-Prusa-Druckprofile:
Für "Druckeinstellungen"-Voreinstellungen und Filament-Einstellungsvoreinstellungen – Verwenden Sie die MK3.5-Systemvoreinstellungen zu Abhängigkeiten > "Systemvoreinstellung trennen"
Benenne die neu abgetrennten Presets um, du kannst sie jetzt für dein Klipper-Druckerprofil verwenden.
WICHTIG: In den Druckeinstellungen > Erweitert – DEAKTIVIERE "Arc Fitting" – G2/G3 sollte nicht mit Klipper verwendet werden und ist nicht notwendig.
Schritt 5 Alternative: Orca Slicer statt PrusaSlicer verwenden
Wenn du Orca Slicer bevorzugst, kannst du es für Klipper wie folgt einrichten:

Füge einen neuen Prusa MK3S+ Drucker in Orca Slicer hinzu.

Klicken Sie auf das WLAN-Symbol neben dem Druckernamen und geben Sie Ihre Mainsail-URL (z. B. oder die IP-Adresse Ihres Pi) ein, um den direkten Upload und das Drucken zu aktivieren.http://mainsailos.local

Öffne die Druckereinstellungen (Zahnradsymbol neben dem Drucker-Dropdown-Menü).

Unter General > Firmware setze "G-code flavor" auf "Klipper".

Unter General > Firmware deaktivieren Sie "Unterstützt binären G-Code", falls vorhanden.

Lösche alles unter Custom G-Code – Lösche ALLE vorhandenen Daten in ALLEN Boxen. Deaktivieren Sie "Emittieren der Temperaturbefehle automatisch", falls vorhanden.

Setze den Start- und Endcode:

Startcode MK3S+

PRINT_START EXTRUDER_TEMP=[nozzle_temperature_initial_layer] BED_TEMP=[bed_temperature_initial_layer_single]
Startcode MK3S

PRINT_START EXTRUDER_TEMP=[nozzle_temperature_initial_layer] BED_TEMP=[bed_temperature_initial_layer_single] PRINTER_MODEL="MK3S"
Endcode

PRINT_END
Speichere deine Drucker-Preset.

Für Druckeinstellungen: Öffne die Prozesseinstellungen (Notizblock/Bearbeiten-Symbol neben dem Dropdown-Menü Prozess). Unter Qualität > Präzision deaktivieren Sie "Arc Fitting" – G2/G3 sollte nicht mit Klipper verwendet werden.

Für Filamentprofile: Pressure Advance kann pro Filament hinzugefügt werden > Custom G-Code > Start G-Code, wie z. B. .SET_PRESSURE_ADVANCE ADVANCE=.055

Hinweis: Orca Slicer verwendet andere Platzhalter-Variablennamen als PrusaSlicer. Achte darauf, und (nicht und ) zu verwenden.[nozzle_temperature_initial_layer][bed_temperature_initial_layer_single][first_layer_temperature][first_layer_bed_temperature]

Schritt 6. Stimmung
Der MK3S/+ ist dafür bekannt, eine leichte Verdrehung in der X-Achse zu haben, was dazu führt, dass der PINDA ungenaue Z-Höhen je nach Position entlang X meldet. Führe , an jedem der drei Punkte, einen manuellen Papiertest durch, um den Z-Offset einzustellen. Laufen, wenn du fertig bist. Das muss nur einmal gemacht werden, es sei denn, du zerlegst die X-Achse. Weitere Informationen finden Sie https://www.klipper3d.org/Axis_Twist_Compensation.html.AXIS_TWIST_COMPENSATION_CALIBRATESAVE_CONFIG
Bevor Sie mit PrusaSlicer drucken, folgen Sie Ellis' Leitfaden für die wichtigsten Abstimmungsschritte: https://ellis3dp.com/Print-Tuning-Guide/articles/index_tuning.html
Extruder-Kalibrierung und Druckvorrückung sind entscheidende Bestandteile der Implementierung von Klipper und können nicht übersprungen werden. Die Befolgung der anderen Schritte wird empfohlen, kann aber bei Bedarf erneut durchgeführt werden.
Für Pressure Advance und Extrusion Multiplier wird empfohlen, diese Werte in jedes einzelne Filamentprofil in PrusaSlicer hinzuzufügen. PA kann zu den Filamenten > Custom G-Code > Start-G-Code hinzugefügt werden, wie zum Beispiel SET_PRESSURE_ADVANCE ADVANCE=.055
Sobald du das Tuning abgeschlossen hast, versuche, einige Testdrucke mit den STOCK MK3S+ PROFILES zu drucken.
Fast fertig!!
Du kannst jetzt mit PrusaSlicer mit deiner gefundenen Geschwindigkeit drucken. Allerdings geht diese Geschwindigkeit auf Kosten einer schlechteren Druckqualität (Klingeln) als im Original, und das Abstimmen von Input Shaping ist der einzige Weg, es wiederherzustellen! Es wird dringend empfohlen, mit einem Beschleunigungsmesser weiterzumachen und einzustellen. Optional kann man jetzt einen Benchy ausdrucken und dann nach dem IS-Tuning genau denselben G-Code erneut ausführen, um den Unterschied zu sehen. Wenn du keinen Beschleunigungssensor willst oder nicht bekommen kannst, gibt es Alternativen zum nächsten Schritt, die gut funktionieren können, wie zum Beispiel https://www.klipper3d.org/Resonance_Compensation.html.

Schritt 7. EINGABEFORMUNG :)
Es gibt viele Schritte, aber das dauert tatsächlich nicht viel Zeit und ist von Klipper sehr automatisiert.

Um Erwartungen zu setzen, ist es wichtig, dass Sie Ihre Input Shaping Tests auf einer sehr stabilen Oberfläche durchführen. Die Verwendung von Schaumstoff oder einer Polsterung unter dem Drucker wird nicht empfohlen, da dies das Ergebnis verzerren kann und du es nach der Anwendung von IS ohnehin nicht mehr verwenden wirst. Dieser Prozess kann durch Resonanzmessungen auch potenzielle Probleme mit Hardwarefehlern aufdecken, wie lose Bauteile, lose Riemen usw., die zeitaufwendig zu beheben sind, sich aber später auszahlen.

Aktualisieren Sie die Firmware des Besprüngungsmessers, indem Sie der Benutzeranleitung folgen
KUSBA: https://github.com/xbst/KUSBA/blob/main/Docs/v2-Firmware.md
BTT: https://github.com/bigtreetech/ADXL345
Drucke einen Werkzeugkopf und eine Beschleunigungsbeschleunigungsmontierung (wenn du nicht die Düsenmontageoption nutzt)
KUSBA: https://www.printables.com/search/models?q=kusba&ctx=models
BTT v2.0 MK3S+ Werkzeugkopf: https://www.printables.com/model/1270348-bigtreetech-btt-adxl345-prusa-mk3s-extruder-mount
BTT v1.0/v2.0 MK3S/MK3S+ Bett: https://www.printables.com/model/1270385-bigtreetech-btt-adxl345-prusa-mk3s-bed-mount
Installiere das Beschleunigungsmessgerät am Werkzeugkopf und verbinde das USB-Kabel mit dem Raspberry Pi
Entkommentiere die entsprechende Beschleunigungskonfigurationsdatei (entweder adxlmcu-BTT.cfg oder adxlmcu-KUSBA.cfg) in deiner printer.cfg, speichere und starte die Firmware neu.
Überprüfen Sie, ob der Beschleunigungssensor Werte sendet
Über die Konsole senden Sie den Befehl "ACCELEROMETER_QUERY"
Führen Sie eine X-Achsen-Kalibrierung durch:
Über die Konsole senden Sie den Befehl "SHAPER_CALIBRATE AXIS=X"
Wenn abgeschlossen, senden Sie den Befehl "SAVE_CONFIG"
Entferne den Beschleunigungsmesser vom Werkzeugkopf und installiere es auf dem Bett
Führen Sie eine Y-Achsen-Kalibrierung durch:
Über die Konsole senden Sie den Befehl "SHAPER_CALIBRATE AXIS=Y"
Wenn abgeschlossen, senden Sie den Befehl "SAVE_CONFIG"
Zieh den Stecker aus dem Beschleunigungsmesser und entferne ihn vom Bett. Bewahre es sicher für einen anderen Tag auf.
Öffne deine printer.cfg und kommentiere (oder entferne) die Accelerometer-Konfigurationsdatei, die du in Schritt 5 aktiviert hast.
Speichere printer.cfg und starte die Firmware neu. Du bist mit dem Stimmen von IS fertig!
Schritt 8. Mach Pressure Advance nochmal, nachdem du deine IS-Einrichtung abgeschlossen hast
Vielleicht hast du hier Glück, aber denselben Test schnell zu wiederholen, um die PA-Einstellung zu überprüfen, ist immer eine gute Idee.

ENDE! Viel Spaß beim Drucken.
Anmerkungen für Raspberry Pi Zero 2 W-Nutzer
Der Pi Zero 2 W ist eine unterstützte und leistungsfähige Platine für den Betrieb von Klipper, aber seine begrenzten Ressourcen (512 MB RAM, ein einzelner USB-OTG-Anschluss) erfordern einige zusätzliche Überlegungen:

USB-Hub-Anforderung
Der Pi Zero 2 W hat nur einen Micro-USB-Datenanschluss (der andere ist nur Stromverbraucher). Bei der Durchführung der Input Shaping-Kalibrierung (Schritt 7) müssen sowohl der Drucker als auch das Beschleunigungsmesser gleichzeitig verbunden sein. Du brauchst einen USB-2.0-OTG-Hub, der am Datenport angeschlossen ist. Wichtig: USB-3.0-Hubs werden vom USB 2.0 OTG-Controller des Pi Zero 2 W möglicherweise nicht erkannt – verwenden Sie einen USB-2.0-Hub.

Empfohlene Betriebssystemoptimierungen
Der BCM43430 WiFi-Chip des Pi Zero 2 W kann gelegentlich zu Kernel-Blockaden bei starker Last führen. Die folgenden Minderungsmaßnahmen werden empfohlen:

Aktivieren Sie persistente Journal-Logging – Dies stellt sicher, dass Kernel-Logs eine Sperrung für die Post-Mortem-Analyse überstehen:

sudo sed -i 's/#Storage=auto/Storage=persistent/' /etc/systemd/journald.conf
sudo systemctl restart systemd-journald
Aktivieren Sie den Hardware-Watchdog — Dieser startet den Pi automatisch neu, wenn der Kernel blockiert:

# Add to /boot/firmware/config.txt:
dtparam=watchdog=on

# Install and configure watchdog:
sudo apt install watchdog
# Add to /etc/watchdog.conf:
watchdog-device = /dev/watchdog
watchdog-timeout = 15
max-load-1 = 24

sudo systemctl enable watchdog
sudo systemctl start watchdog
Reduzieren Sie den WLAN-Scan-Overhead — Erstellen Sie :/etc/NetworkManager/conf.d/wifi-scan.conf

[device]
wifi.scan-rand-mac-address=no
wifi.scan-generate-mac-address-mask=

[connection]
wifi.bgscan=simple:30:-65:300
Diese Optimierungen helfen, während langer Druckaufträge eine stabile Verbindung zwischen Ihrem PC, dem Pi und dem Drucker aufrechtzuerhalten.

Rückkehr zur originalen Prusa-Firmware
Verbinde das USB-Kabel vom Drucker mit deinem PC
Laden Sie Prusas Firmware von ihrer Website herunter: https://help.prusa3d.com/downloads
Von PrusaSlicer, Konfiguration > Flash-Firmware. Wählen Sie Ihre Datei aus und flashen.
