# TaktBoot Community

**Version:** 0.1.0  
**Build:** 0002  
**Vendor:** TaktVibes  
**Channel:** Official / Learning  
**Target:** x86_64 / UEFI

TaktBoot Community is a small educational UEFI project. Build 0002 intentionally remains a learning build: it starts as a UEFI application, displays bilingual DE/EN information, demonstrates the project structure, and returns to the firmware. **It does not load or start a kernel.**

TaktBoot Community ist ein kleines UEFI-Lernprojekt. Build 0002 bleibt absichtlich ein Lehr-Build: Die UEFI-Anwendung startet, zeigt zweisprachige DE/EN-Informationen, demonstriert die Projektstruktur und kehrt anschließend zur Firmware zurück. **Es wird kein Kernel geladen oder gestartet.**

## Documentation / Dokumentation

- [English README](README_EN.md)
- [Deutsche README](README_DE.md)
- [Security / Sicherheit](SECURITY_DE_EN.md)
- [Release notes / Versionshinweise](RELEASE_NOTES_DE_EN.md)
- [Build information](BUILD_INFO.txt)
- [Current status](STATUS.md)
- [QA report](QA_REPORT_DE_EN.md)

## Build

Use an x64 Visual Studio Developer Command Prompt (tested target: Visual Studio 2019/2022):

```bat
build.cmd
```

After a successful local build, verify the generated SHA-256 value with:

```bat
verify_hash.cmd
```

The expected EFI path is:

```text
build\EFI\BOOT\BOOTX64.EFI
```

## Security / Sicherheit

The repository may contain the **public** TaktBoot Community certificate (`.cer`). Private signing material such as `.pfx`, `.p12`, `.pvk`, `.key` or `.pem` must never be committed.

Das Repository darf das **öffentliche** TaktBoot-Community-Zertifikat (`.cer`) enthalten. Privates Signiermaterial wie `.pfx`, `.p12`, `.pvk`, `.key` oder `.pem` darf niemals eingecheckt werden.

See [SECURITY_DE_EN.md](SECURITY_DE_EN.md) for the project security model.

## Project boundary / Projektgrenze

This public learning project is intentionally separated from internal TKV.OS / TaktBoot development. Internal loader, BootInfo, diagnostic and Golden-Build details are not part of this repository.

Dieses öffentliche Lernprojekt ist bewusst von der internen TKV.OS-/TaktBoot-Entwicklung getrennt. Interne Loader-, BootInfo-, Diagnose- und Golden-Build-Details sind nicht Bestandteil dieses Repositorys.

## Build identity

Build numbers are sequential and are not reused. Build 0001 remains historical; this repository state represents Build 0002.

Buildnummern werden fortlaufend vergeben und nicht wiederverwendet. Build 0001 bleibt historisch erhalten; dieser Repository-Stand repräsentiert Build 0002.

## License / Lizenz

No public license has been selected yet. Until a license is deliberately chosen and added, no additional rights are granted beyond those provided by applicable law.

Es wurde noch keine öffentliche Lizenz festgelegt. Bis bewusst eine Lizenz gewählt und hinzugefügt wurde, werden keine zusätzlichen Nutzungsrechte über das gesetzlich Vorgesehene hinaus eingeräumt.
