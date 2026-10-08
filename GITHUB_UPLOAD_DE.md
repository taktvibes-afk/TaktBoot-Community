# GitHub-Upload – TaktBoot Community 0.1.0 Build 0002

Diese Datei ist nur eine Schritt-für-Schritt-Hilfe für den ersten GitHub-Upload.

## Vor dem Upload

1. `build.cmd` lokal erfolgreich ausführen.
2. `verify_hash.cmd` ausführen.
3. Optional das öffentliche `.cer` nach `cert\` kopieren und `cert\fingerprint_sha256.cmd` ausführen.
4. Prüfen, dass KEINE privaten Dateien enthalten sind:
   - `.pfx`
   - `.p12`
   - `.pvk`
   - `.key`
   - `.pem`
5. `pre_release_check.cmd` ausführen.

## Repository-Name – Vorschlag

`TaktBoot-Community`

## Repository-Beschreibung – Vorschlag

`Educational x86_64 UEFI project by TaktVibes – bilingual DE/EN learning build with reproducible build IDs and SHA-256 verification.`

## Sichtbarkeit

Für die Community-Veröffentlichung: `Public`.

Beim Erstellen des Repositorys KEINE automatische README, .gitignore oder Lizenz erzeugen lassen, weil diese Dateien bereits vorbereitet sind.

## Erster Upload über die GitHub-Webseite

1. Repository öffnen.
2. `Add file` anklicken.
3. `Upload files` wählen.
4. Den INHALT dieses Projektordners hochladen – nicht die private Signing-Ablage.
5. Vor dem Commit die Dateiliste kontrollieren.
6. Commit-Nachricht als Vorschlag:

   `TaktBoot Community 0.1.0 Build 0002 - initial public learning build`

7. `Commit changes` ausführen.

## Unbedingt NICHT hochladen

- den Ordner `TaktVibes Signing`
- private PFX-Dateien
- private Schlüssel
- interne TKV.OS-/TaktBoot-Projektstände
- persönliche Sicherungen oder Backups

## Nach dem Upload prüfen

Auf der Repository-Startseite muss `README.md` automatisch angezeigt werden. Danach prüfen:

- Version 0.1.0
- Build 0002
- Vendor TaktVibes
- Official / Learning
- kein privates Signiermaterial vorhanden
- `.gitignore` vorhanden
- `SECURITY_DE_EN.md` vorhanden

Ein GitHub Release sollte erst erstellt werden, wenn der lokale MSVC-Build und der reale Hardware-Boot dieses konkreten Build-0002-Stands bestätigt wurden.
