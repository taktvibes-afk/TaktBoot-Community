@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "ROOT=%~dp0"
set "EFI=%ROOT%build\EFI\BOOT\BOOTX64.EFI"
set "HASHFILE=%ROOT%SHA256SUMS.txt"

if not exist "%EFI%" (
    echo [ERROR][EN] BOOTX64.EFI not found. Run build.cmd first.
    echo [FEHLER][DE] BOOTX64.EFI nicht gefunden. Zuerst build.cmd ausfuehren.
    exit /b 1
)

if not exist "%HASHFILE%" (
    echo [ERROR][EN] SHA256SUMS.txt not found. Run build.cmd first.
    echo [FEHLER][DE] SHA256SUMS.txt nicht gefunden. Zuerst build.cmd ausfuehren.
    exit /b 1
)

set "EXPECTED="
for /f "usebackq tokens=1" %%H in ("%HASHFILE%") do (
    if not defined EXPECTED set "EXPECTED=%%H"
)

if not defined EXPECTED (
    echo [ERROR][EN] No hash value found in SHA256SUMS.txt.
    echo [FEHLER][DE] Kein Hashwert in SHA256SUMS.txt gefunden.
    exit /b 1
)

for /f "usebackq delims=" %%H in (`powershell -NoProfile -ExecutionPolicy Bypass -Command "(Get-FileHash -LiteralPath '%EFI%' -Algorithm SHA256).Hash.ToLowerInvariant()"`) do set "ACTUAL=%%H"

if /I "!EXPECTED!"=="!ACTUAL!" (
    echo HASH VERIFIED / HASH VERIFIZIERT
    echo SHA-256: !ACTUAL!
    exit /b 0
)

echo HASH MISMATCH / HASH STIMMT NICHT UEBEREIN
echo Expected / Erwartet: !EXPECTED!
echo Actual   / Aktuell:  !ACTUAL!
exit /b 2
