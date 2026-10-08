@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "ROOT=%~dp0"
set "FAIL=0"

echo TaktBoot Community 0.1.0 Build 0002 - Pre-Release Check
echo.

for %%F in (pfx p12 pvk key pem) do (
    for /r "%ROOT%" %%G in (*.%%F) do (
        echo [BLOCKED] Private/sensitive key-like file found: %%G
        set "FAIL=1"
    )
)

for %%R in (README_DE.md README_EN.md SECURITY_DE_EN.md RELEASE_NOTES_DE_EN.md BUILD_INFO.txt STATUS.md build.cmd verify_hash.cmd sign_release.cmd src\main.c src\uefi_min.h) do (
    if not exist "%ROOT%%%R" (
        echo [MISSING] %%R
        set "FAIL=1"
    )
)

if "!FAIL!"=="1" (
    echo.
    echo PRE-RELEASE CHECK FAILED / PRUEFUNG FEHLGESCHLAGEN
    exit /b 1
)

echo No private-key file extensions found in the project.
echo Keine privaten Schluesseldatei-Endungen im Projekt gefunden.
echo Required files are present / Pflichtdateien vorhanden.
echo.
echo PRE-RELEASE CHECK PASS / PRUEFUNG BESTANDEN
exit /b 0
