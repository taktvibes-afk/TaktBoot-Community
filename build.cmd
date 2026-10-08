@echo off
setlocal EnableExtensions EnableDelayedExpansion

rem ============================================================
rem TaktBoot Community 0.1.0 - Build 0002
rem Date / Datum: 2026-10-05
rem Vendor: TaktVibes
rem Channel: Official / Learning
rem Target: Microsoft Visual C/C++ x64 UEFI
rem ============================================================

set "ROOT=%~dp0"
set "SRC=%ROOT%src"
set "OBJ=%ROOT%build\obj"
set "OUT=%ROOT%build\EFI\BOOT"
set "EFI=%OUT%\BOOTX64.EFI"
set "HASHFILE=%ROOT%SHA256SUMS.txt"
set "BUILDINFO=%ROOT%BUILD_INFO.txt"
set "STATUSFILE=%ROOT%STATUS.md"

where cl.exe >nul 2>nul
if errorlevel 1 (
    echo [ERROR][EN] cl.exe was not found.
    echo [FEHLER][DE] cl.exe wurde nicht gefunden.
    echo.
    echo Start this script from an x64 Visual Studio Developer Command Prompt.
    echo Dieses Skript aus einer x64 Visual Studio Developer Command Prompt starten.
    exit /b 1
)

where link.exe >nul 2>nul
if errorlevel 1 (
    echo [ERROR][EN] link.exe was not found.
    echo [FEHLER][DE] link.exe wurde nicht gefunden.
    exit /b 1
)

where powershell.exe >nul 2>nul
if errorlevel 1 (
    echo [ERROR][EN] powershell.exe is required for SHA-256 generation.
    echo [FEHLER][DE] powershell.exe wird fuer SHA-256 benoetigt.
    exit /b 1
)

if not exist "%OBJ%" mkdir "%OBJ%"
if not exist "%OUT%" mkdir "%OUT%"

rem Delete old output first so a failed build cannot leave a stale EFI.
if exist "%EFI%" del /q "%EFI%"

echo.
echo [1/4] main.c
cl /nologo /c /TC /W4 /WX /O2 /GS- /Zl /D_AMD64_ /Fo"%OBJ%\main.obj" "%SRC%\main.c"
if errorlevel 1 goto :fail

echo [2/4] console.c
cl /nologo /c /TC /W4 /WX /O2 /GS- /Zl /D_AMD64_ /Fo"%OBJ%\console.obj" "%SRC%\console\console.c"
if errorlevel 1 goto :fail

echo [3/4] boot.c + memory.c
cl /nologo /c /TC /W4 /WX /O2 /GS- /Zl /D_AMD64_ /Fo"%OBJ%\boot.obj" "%SRC%\boot\boot.c"
if errorlevel 1 goto :fail
cl /nologo /c /TC /W4 /WX /O2 /GS- /Zl /D_AMD64_ /Fo"%OBJ%\memory.obj" "%SRC%\memory\memory.c"
if errorlevel 1 goto :fail

echo [4/4] Link BOOTX64.EFI
link /nologo /nodefaultlib /machine:x64 /subsystem:efi_application /entry:efi_main /opt:ref /out:"%EFI%" "%OBJ%\main.obj" "%OBJ%\console.obj" "%OBJ%\boot.obj" "%OBJ%\memory.obj"
if errorlevel 1 goto :fail

if not exist "%EFI%" (
    echo [ERROR][EN] Linker returned success but BOOTX64.EFI is missing.
    echo [FEHLER][DE] Linker meldete Erfolg, aber BOOTX64.EFI fehlt.
    goto :fail
)

for /f "usebackq delims=" %%H in (`powershell -NoProfile -ExecutionPolicy Bypass -Command "(Get-FileHash -LiteralPath '%EFI%' -Algorithm SHA256).Hash.ToLowerInvariant()"`) do set "EFIHASH=%%H"
if not defined EFIHASH goto :hashfail

>"%HASHFILE%" echo !EFIHASH!  build\EFI\BOOT\BOOTX64.EFI

>"%BUILDINFO%" echo TaktBoot Community
>>"%BUILDINFO%" echo Version: 0.1.0
>>"%BUILDINFO%" echo Build: 0002
>>"%BUILDINFO%" echo Build Date: 2026-10-05
>>"%BUILDINFO%" echo Vendor: TaktVibes
>>"%BUILDINFO%" echo Channel: Official / Learning
>>"%BUILDINFO%" echo Target: x86_64 / UEFI
>>"%BUILDINFO%" echo Toolchain: Microsoft Visual C/C++ x64
>>"%BUILDINFO%" echo EFI SHA-256: !EFIHASH!
>>"%BUILDINFO%" echo Signature: UNSIGNED unless sign_release.cmd is run successfully

>"%STATUSFILE%" echo # TaktBoot Community 0.1.0 Build 0002 - Status
>>"%STATUSFILE%" echo.
>>"%STATUSFILE%" echo - LOCAL MSVC BUILD STATUS: PASS
>>"%STATUSFILE%" echo - REAL HARDWARE BOOT STATUS: NOT TESTED YET
>>"%STATUSFILE%" echo - HASH STATUS: GENERATED - run verify_hash.cmd for verification
>>"%STATUSFILE%" echo - SIGNATURE STATUS: UNSIGNED / OPTIONAL
>>"%STATUSFILE%" echo - CERTIFICATE FINGERPRINT: run cert\fingerprint_sha256.cmd when CER is present

echo.
echo ============================================================
echo BUILD PASS / BUILD BESTANDEN
echo Version 0.1.0 Build 0002
echo Date / Datum: 2026-10-05
echo EFI: %EFI%
echo SHA-256: !EFIHASH!
echo ============================================================
echo.
echo [EN] Next: run verify_hash.cmd, then perform the UEFI hardware test.
echo [DE] Danach: verify_hash.cmd ausfuehren, dann UEFI-Hardwaretest.
exit /b 0

:hashfail
echo.
echo [ERROR][EN] EFI was built, but SHA-256 generation failed.
echo [FEHLER][DE] EFI wurde gebaut, aber SHA-256-Erzeugung ist fehlgeschlagen.
exit /b 2

:fail
echo.
echo ============================================================
echo BUILD FAILED / BUILD FEHLGESCHLAGEN
echo Send the first compiler/linker error.
echo Erste Compiler-/Linker-Fehlermeldung senden.
echo ============================================================
exit /b 1
