#ifndef TAKTBOOT_CONSOLE_H
#define TAKTBOOT_CONSOLE_H

#include "../uefi_min.h"

/* DE: Kleine Konsolen-Schnittstelle fuer die Lehr-EFI.
 * EN: Small console interface for the learning EFI. */
void ConsoleInit(EFI_SYSTEM_TABLE* systemTable);
void ConsoleClear(void);
void ConsoleWrite(CHAR16* text);
void ConsoleWaitForKey(void);

#endif
