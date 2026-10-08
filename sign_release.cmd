@echo off
setlocal EnableExtensions EnableDelayedExpansion

rem OPTIONAL signing step. The PFX remains outside this project.
rem OPTIONALER Signierschritt. Der PFX bleibt ausserhalb dieses Projekts.

set "ROOT=%~dp0"
set "EFI=%ROOT%build\EFI\BOOT\BOOTX64.EFI"
set "HASHFILE=%ROOT%SHA256SUMS.txt"

if not exist "%EFI%" (
    echo [ERROR][EN] BOOTX64.EFI not found. Build first.
    echo [FEHLER][DE] BOOTX64.EFI nicht gefunden. Zuerst bauen.
    exit /b 1
)

if "%TAKTVIBES_PFX%"=="" (
    echo [ERROR][EN] Set TAKTVIBES_PFX to the external PFX path.
    echo [FEHLER][DE] TAKTVIBES_PFX auf den externen PFX-Pfad setzen.
    echo Example / Beispiel:
    echo set "TAKTVIBES_PFX=C:\TaktVibes Signing\TaktBootCommunity_Private.pfx"
    exit /b 1
)

if not exist "%TAKTVIBES_PFX%" (
    echo [ERROR][EN] External PFX file not found.
    echo [FEHLER][DE] Externe PFX-Datei nicht gefunden.
    exit /b 1
)

where signtool.exe >nul 2>nul
if errorlevel 1 (
    echo [ERROR][EN] signtool.exe not found in PATH.
    echo [FEHLER][DE] signtool.exe nicht im PATH gefunden.
    exit /b 1
)

if "%TAKTVIBES_PFX_PASSWORD%"=="" (
    echo [ERROR][EN] Set TAKTVIBES_PFX_PASSWORD for this process only.
    echo [FEHLER][DE] TAKTVIBES_PFX_PASSWORD nur fuer diesen Prozess setzen.
    exit /b 1
)

signtool sign /fd SHA256 /f "%TAKTVIBES_PFX%" /p "%TAKTVIBES_PFX_PASSWORD%" "%EFI%"
if errorlevel 1 exit /b 2

for /f "usebackq delims=" %%H in (`powershell -NoProfile -ExecutionPolicy Bypass -Command "(Get-FileHash -LiteralPath '%EFI%' -Algorithm SHA256).Hash.ToLowerInvariant()"`) do set "EFIHASH=%%H"
if not defined EFIHASH exit /b 3

>"%HASHFILE%" echo !EFIHASH!  build\EFI\BOOT\BOOTX64.EFI

echo SIGNATURE STEP PASS / SIGNIERSCHRITT BESTANDEN
echo New SHA-256 / Neuer SHA-256: !EFIHASH!
echo.
echo [EN] Run verify_hash.cmd and then verify the signature with your trusted certificate workflow.
echo [DE] verify_hash.cmd ausfuehren und danach die Signatur mit dem vertrauten Zertifikats-Workflow pruefen.
exit /b 0
