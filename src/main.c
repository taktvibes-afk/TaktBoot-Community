#include "uefi_min.h"
#include "build_info.h"
#include "console/console.h"
#include "boot/boot.h"
#include "memory/memory.h"

/*
 * TaktBoot Community 0.1.0 - Build 0002
 * Build date / Baudatum: 2026-10-05
 * Vendor: TaktVibes
 * Channel: Official / Learning
 *
 * DE - Minimalziel:
 * - als x86_64 UEFI-Anwendung starten
 * - zweisprachige Textausgabe anzeigen
 * - Tastendruck abwarten
 * - ohne Kernelstart sauber zur Firmware zurueckkehren
 *
 * EN - Minimum goal:
 * - start as an x86_64 UEFI application
 * - display bilingual text output
 * - wait for a key press
 * - return cleanly to firmware without loading a kernel
 */

EFI_STATUS EFIAPI efi_main(EFI_HANDLE imageHandle, EFI_SYSTEM_TABLE* systemTable)
{
    (void)imageHandle;

    ConsoleInit(systemTable);
    ConsoleClear();

    ConsoleWrite(L"========================================\r\n");
    ConsoleWrite(L"       TaktBoot Community\r\n");
    ConsoleWrite(L"       Version " TAKTBOOT_VERSION_TEXT_W L" Build " TAKTBOOT_BUILD_TEXT_W L"\r\n");
    ConsoleWrite(L"       Date / Datum: " TAKTBOOT_DATE_TEXT_W L"\r\n");
    ConsoleWrite(L"       Vendor: " TAKTBOOT_VENDOR_TEXT_W L"\r\n");
    ConsoleWrite(L"       Channel: " TAKTBOOT_CHANNEL_TEXT_W L"\r\n");
    ConsoleWrite(L"========================================\r\n\r\n");

    ConsoleWrite(L"[EN] UEFI application started successfully.\r\n");
    ConsoleWrite(L"[DE] UEFI-Anwendung erfolgreich gestartet.\r\n\r\n");

    ConsoleWrite(L"[EN] Learning build - no kernel is loaded.\r\n");
    ConsoleWrite(L"[DE] Lernversion - es wird kein Kernel geladen.\r\n\r\n");

    MemoryLessonPlaceholder(systemTable);
    BootDemo(systemTable);

    ConsoleWrite(L"\r\n[EN] Press any key to return to the firmware.\r\n");
    ConsoleWrite(L"[DE] Beliebige Taste druecken, um zur Firmware zurueckzukehren.\r\n");
    ConsoleWaitForKey();

    return EFI_SUCCESS;
}
