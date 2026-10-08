# TaktBoot Community 0.1.0 - Build 0002

TaktBoot Community is an independent UEFI learning/demo edition by TaktVibes.
It intentionally remains separate from the internal TaktBoot/TKV.OS project.

## Identity

- Version: `0.1.0`
- Build: `0002`
- Build date: `2026-10-05`
- Vendor: `TaktVibes`
- Channel: `Official / Learning`
- Target architecture: `x86_64 / UEFI`

Build numbers are assigned sequentially and are never reused. Build 0001 remains historically unchanged.

## Goal of Build 0002

Build 0002 intentionally does not add EFI functionality compared with Build 0001. It improves identification, documentation, bilingual presentation and release security.

Included:
- x86_64 UEFI application
- DE/EN startup screen
- DE/EN source comments
- console output
- key press handling
- prepared learning areas for boot and Memory Map topics
- SHA-256 generation after the build
- hash verification via `verify_hash.cmd`
- security and release documentation
- an optional prepared signing step

Not included:
- no file-system loader
- no ELF64 loader
- no real Memory Map request
- no ExitBootServices
- no kernel handoff
- no internal TKV.OS/TaktBoot loader code

## Build

1. Install Visual Studio 2019/2022 or matching C++ Build Tools.
2. Open an `x64 Native Tools Command Prompt`.
3. Change to this project directory.
4. Run `build.cmd`.

Output:

`build\EFI\BOOT\BOOTX64.EFI`

After a successful link, `build.cmd` writes the SHA-256 hash to `SHA256SUMS.txt` and updates `BUILD_INFO.txt` and `STATUS.md` for the local build status.

## Verify the hash

Run:

`verify_hash.cmd`

The check must report `HASH VERIFIED / HASH VERIFIZIERT` before a build is treated as unchanged.

## Certificate and signature

The public certificate may be stored as `cert\TaktVibes_TaktBoot_Community.cer`.
The private PFX key must never be stored inside this project, a public ZIP or a repository.

`cert\fingerprint_sha256.cmd` documents the SHA-256 fingerprint of the public certificate once the CER file is locally present.

`sign_release.cmd` is only an optional prepared signing step. The private PFX path is supplied from outside the project. After signing, the EFI hash is generated again because a digital signature changes the binary.

## Official and Modified/Fork

Only a TaktVibes-controlled build may be labelled `Official`. Modified copies or forks must clearly identify themselves as `Modified`, `Fork` or equivalent and must not claim to be an official TaktVibes build.

## Status

Build, boot, hash and signature status are documented separately. A successful compiler run is not proof of a successful real-hardware boot.
