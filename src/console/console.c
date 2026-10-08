#include "console.h"

/* DE: Von der Firmware uebergebene Systemtabelle.
 * EN: System table supplied by the firmware. */
static EFI_SYSTEM_TABLE* gSystemTable = 0;

void ConsoleInit(EFI_SYSTEM_TABLE* systemTable)
{
    gSystemTable = systemTable;
}

void ConsoleClear(void)
{
    if (gSystemTable && gSystemTable->ConOut && gSystemTable->ConOut->ClearScreen) {
        gSystemTable->ConOut->ClearScreen(gSystemTable->ConOut);
    }
}

void ConsoleWrite(CHAR16* text)
{
    if (gSystemTable && gSystemTable->ConOut && gSystemTable->ConOut->OutputString) {
        gSystemTable->ConOut->OutputString(gSystemTable->ConOut, text);
    }
}

void ConsoleWaitForKey(void)
{
    EFI_INPUT_KEY key;
    EFI_STATUS status;

    if (!gSystemTable || !gSystemTable->ConIn || !gSystemTable->ConIn->ReadKeyStroke) {
        return;
    }

    /*
     * DE:
     * Fuer diesen ersten Lehrstand reicht bewusst einfaches Polling.
     * Spaetere Lernstufen koennen WaitForEvent() erklaeren.
     *
     * EN:
     * Simple polling is intentionally sufficient for this first learning build.
     * Later learning stages may explain WaitForEvent().
     */
    do {
        status = gSystemTable->ConIn->ReadKeyStroke(gSystemTable->ConIn, &key);
    } while (status == EFI_NOT_READY);
}
