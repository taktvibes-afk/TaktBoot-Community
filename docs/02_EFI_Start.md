# 02 - EFI-Start

Die Firmware laedt `EFI\BOOT\BOOTX64.EFI` auf x86_64-Systemen im standardisierten Removable-Media-Pfad.
Danach wird der EFI-Einstiegspunkt aufgerufen und eine Systemtabelle uebergeben.

Build 0002 zeigt diese Phase bewusst minimal und nachvollziehbar.
