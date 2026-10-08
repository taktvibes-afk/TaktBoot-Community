@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "ROOT=%~dp0"
set "CERT=%ROOT%TaktVibes_TaktBoot_Community.cer"
set "OUT=%ROOT%CERTIFICATE_SHA256.txt"

if not exist "%CERT%" (
    echo [ERROR][EN] Public certificate not found:
    echo %CERT%
    echo [FEHLER][DE] Oeffentliches Zertifikat nicht gefunden.
    exit /b 1
)

for /f "usebackq delims=" %%H in (`powershell -NoProfile -ExecutionPolicy Bypass -Command "(Get-FileHash -LiteralPath '%CERT%' -Algorithm SHA256).Hash.ToLowerInvariant()"`) do set "CERTHASH=%%H"
if not defined CERTHASH exit /b 2

>"%OUT%" echo TaktBoot Community public certificate SHA-256 fingerprint
>>"%OUT%" echo File: TaktVibes_TaktBoot_Community.cer
>>"%OUT%" echo SHA-256: !CERTHASH!

echo CERTIFICATE SHA-256 / ZERTIFIKAT SHA-256:
echo !CERTHASH!
echo Written to / Geschrieben nach: %OUT%
exit /b 0
