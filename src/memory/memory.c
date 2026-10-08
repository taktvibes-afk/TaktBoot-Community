#include "memory.h"

void MemoryLessonPlaceholder(EFI_SYSTEM_TABLE* systemTable)
{
    (void)systemTable;

    /*
     * DE - LEHRBEREICH MEMORY MAP:
     * Build 0002 fuehrt noch keine echte Memory-Map-Abfrage aus.
     * Spaeter kann hier erklaert werden:
     * - was EFI_MEMORY_DESCRIPTOR beschreibt
     * - welche Speichertypen UEFI kennt
     * - warum GetMemoryMap() fuer einen Kernel wichtig ist
     * - warum sich die Map bis ExitBootServices aendern kann
     * - warum MapKey und ExitBootServices zusammengehoeren
     *
     * EN - MEMORY MAP LEARNING AREA:
     * Build 0002 does not perform a real Memory Map request yet.
     * A later stage may explain:
     * - what EFI_MEMORY_DESCRIPTOR describes
     * - which memory types UEFI defines
     * - why GetMemoryMap() matters to a kernel
     * - why the map may still change until ExitBootServices
     * - why MapKey and ExitBootServices belong together
     */
}
