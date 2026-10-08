# TaktBoot Community 0.1.0 - Build 0002

TaktBoot Community ist eine eigenstaendige UEFI-Lehr-/Demo-Version von TaktVibes.
Sie bleibt bewusst vom internen TaktBoot/TKV.OS getrennt.

## Identitaet

- Version: `0.1.0`
- Build: `0002`
- Baudatum: `2026-10-05`
- Vendor: `TaktVibes`
- Channel: `Official / Learning`
- Zielarchitektur: `x86_64 / UEFI`

Buildnummern werden fortlaufend vergeben und niemals wiederverwendet. Build 0001 bleibt historisch unveraendert.

## Ziel von Build 0002

Build 0002 erweitert die EFI-Funktionalitaet gegenueber Build 0001 bewusst nicht. Er verbessert Kennzeichnung, Dokumentation, Zweisprachigkeit und Release-Sicherheit.

Enthalten:
- x86_64-UEFI-Anwendung
- DE/EN-Startbildschirm
- DE/EN-Codekommentare
- Konsolenausgabe
- Tastendruck
- vorbereitete Lehrbereiche fuer Boot und Memory Map
- SHA-256-Erzeugung nach dem Build
- Hash-Pruefung per `verify_hash.cmd`
- Sicherheits- und Release-Dokumentation
- optional vorbereiteter Signierschritt

Nicht enthalten:
- kein Dateisystem-Loader
- kein ELF64-Loader
- keine echte Memory Map
- kein ExitBootServices
- kein Kernel-Handoff
- kein interner TKV.OS/TaktBoot-Loadercode

## Bauen

1. Visual Studio 2019/2022 oder entsprechende C++ Build Tools installieren.
2. `x64 Native Tools Command Prompt` oeffnen.
3. In diesen Projektordner wechseln.
4. `build.cmd` ausfuehren.

Ergebnis:

`build\EFI\BOOT\BOOTX64.EFI`

Nach erfolgreichem Linken erzeugt `build.cmd` den SHA-256-Hash in `SHA256SUMS.txt` und aktualisiert `BUILD_INFO.txt` sowie `STATUS.md` fuer den lokalen Buildstatus.

## Hash pruefen

`verify_hash.cmd`

Die Pruefung muss `HASH VERIFIED / HASH VERIFIZIERT` melden, bevor ein Build als unveraendert betrachtet wird.

## Zertifikat und Signatur

Das oeffentliche Zertifikat darf unter `cert\TaktVibes_TaktBoot_Community.cer` liegen.
Der private PFX-Schluessel gehoert niemals in dieses Projekt, in eine oeffentliche ZIP oder in ein Repository.

`cert\fingerprint_sha256.cmd` dokumentiert den SHA-256-Fingerprint des oeffentlichen Zertifikats, sobald die CER-Datei lokal vorhanden ist.

`sign_release.cmd` ist nur ein optional vorbereiteter Signierschritt. Der private PFX-Pfad wird von ausserhalb des Projekts uebergeben. Nach jeder Signierung wird der Hash der EFI neu erzeugt, weil die Signatur die Datei veraendert.

## Official und Modified/Fork

Nur ein von TaktVibes kontrollierter Build darf als `Official` bezeichnet werden. Veraenderte Kopien oder Forks muessen deutlich als `Modified`, `Fork` oder vergleichbar gekennzeichnet werden und duerfen sich nicht als offizieller TaktVibes-Build ausgeben.

## Status

Build-, Boot-, Hash- und Signaturstatus werden getrennt dokumentiert. Ein erfolgreicher Compilerlauf ist noch kein Hardware-Boot-Nachweis.
