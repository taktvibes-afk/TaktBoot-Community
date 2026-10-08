#ifndef TAKTBOOT_UEFI_MIN_H
#define TAKTBOOT_UEFI_MIN_H

/*
 * DE:
 * Minimale UEFI-Deklarationen fuer TaktBoot Community 0.1.0.
 * Es werden nur die Typen und Protokolle definiert, die Build 0002
 * tatsaechlich verwendet. Keine Windows-Header und keine externe
 * UEFI-Bibliothek sind notwendig.
 *
 * EN:
 * Minimal UEFI declarations for TaktBoot Community 0.1.0.
 * Only types and protocols actually used by Build 0002 are declared.
 * No Windows headers and no external UEFI library are required.
 */

#ifdef _MSC_VER
#define EFIAPI __cdecl
#else
#define EFIAPI
#endif

typedef unsigned char      UINT8;
typedef unsigned short     UINT16;
typedef unsigned int       UINT32;
typedef int                INT32;
typedef unsigned long long UINT64;
typedef UINT64             UINTN;
typedef UINT64             EFI_STATUS;
typedef void*              EFI_HANDLE;
typedef void*              EFI_EVENT;
typedef UINT16             CHAR16;
typedef UINT8              BOOLEAN;

typedef struct EFI_SIMPLE_TEXT_INPUT_PROTOCOL  EFI_SIMPLE_TEXT_INPUT_PROTOCOL;
typedef struct EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL;
typedef struct EFI_SYSTEM_TABLE                EFI_SYSTEM_TABLE;

typedef struct {
    UINT16 ScanCode;
    CHAR16 UnicodeChar;
} EFI_INPUT_KEY;

/* DE: Auf x64 markiert Bit 63 einen UEFI-Fehlerstatus.
 * EN: On x64, bit 63 marks a UEFI error status. */
#define EFI_SUCCESS     ((EFI_STATUS)0)
#define EFI_NOT_READY   ((EFI_STATUS)0x8000000000000006ULL)

/* ---------- Text Input / Texteingabe ---------- */

typedef EFI_STATUS (EFIAPI *EFI_INPUT_RESET)(
    EFI_SIMPLE_TEXT_INPUT_PROTOCOL* This,
    BOOLEAN ExtendedVerification
);

typedef EFI_STATUS (EFIAPI *EFI_INPUT_READ_KEY)(
    EFI_SIMPLE_TEXT_INPUT_PROTOCOL* This,
    EFI_INPUT_KEY* Key
);

struct EFI_SIMPLE_TEXT_INPUT_PROTOCOL {
    EFI_INPUT_RESET    Reset;
    EFI_INPUT_READ_KEY ReadKeyStroke;
    EFI_EVENT          WaitForKey;
};

/* ---------- Text Output / Textausgabe ---------- */

typedef EFI_STATUS (EFIAPI *EFI_TEXT_RESET)(
    EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL* This,
    BOOLEAN ExtendedVerification
);

typedef EFI_STATUS (EFIAPI *EFI_TEXT_STRING)(
    EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL* This,
    CHAR16* String
);

typedef EFI_STATUS (EFIAPI *EFI_TEXT_TEST_STRING)(
    EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL* This,
    CHAR16* String
);

typedef EFI_STATUS (EFIAPI *EFI_TEXT_QUERY_MODE)(
    EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL* This,
    UINTN ModeNumber,
    UINTN* Columns,
    UINTN* Rows
);

typedef EFI_STATUS (EFIAPI *EFI_TEXT_SET_MODE)(
    EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL* This,
    UINTN ModeNumber
);

typedef EFI_STATUS (EFIAPI *EFI_TEXT_SET_ATTRIBUTE)(
    EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL* This,
    UINTN Attribute
);

typedef EFI_STATUS (EFIAPI *EFI_TEXT_CLEAR_SCREEN)(
    EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL* This
);

typedef EFI_STATUS (EFIAPI *EFI_TEXT_SET_CURSOR_POSITION)(
    EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL* This,
    UINTN Column,
    UINTN Row
);

typedef EFI_STATUS (EFIAPI *EFI_TEXT_ENABLE_CURSOR)(
    EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL* This,
    BOOLEAN Visible
);

typedef struct {
    INT32 MaxMode;
    INT32 Mode;
    INT32 Attribute;
    INT32 CursorColumn;
    INT32 CursorRow;
    BOOLEAN CursorVisible;
} SIMPLE_TEXT_OUTPUT_MODE;

struct EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL {
    EFI_TEXT_RESET               Reset;
    EFI_TEXT_STRING              OutputString;
    EFI_TEXT_TEST_STRING         TestString;
    EFI_TEXT_QUERY_MODE          QueryMode;
    EFI_TEXT_SET_MODE            SetMode;
    EFI_TEXT_SET_ATTRIBUTE       SetAttribute;
    EFI_TEXT_CLEAR_SCREEN        ClearScreen;
    EFI_TEXT_SET_CURSOR_POSITION SetCursorPosition;
    EFI_TEXT_ENABLE_CURSOR       EnableCursor;
    SIMPLE_TEXT_OUTPUT_MODE*     Mode;
};

/* ---------- UEFI Table Header / Tabellenkopf ---------- */

typedef struct {
    UINT64 Signature;
    UINT32 Revision;
    UINT32 HeaderSize;
    UINT32 CRC32;
    UINT32 Reserved;
} EFI_TABLE_HEADER;

/*
 * DE:
 * Build 0002 benutzt nur ConIn und ConOut. Die restlichen Felder muessen
 * trotzdem an ihrer korrekten Position stehen, damit das UEFI-Layout stimmt.
 *
 * EN:
 * Build 0002 only uses ConIn and ConOut. The remaining fields still need
 * to exist at the correct positions so the UEFI structure layout is valid.
 */
struct EFI_SYSTEM_TABLE {
    EFI_TABLE_HEADER Hdr;
    CHAR16* FirmwareVendor;
    UINT32 FirmwareRevision;
    EFI_HANDLE ConsoleInHandle;
    EFI_SIMPLE_TEXT_INPUT_PROTOCOL* ConIn;
    EFI_HANDLE ConsoleOutHandle;
    EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL* ConOut;
    EFI_HANDLE StandardErrorHandle;
    EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL* StdErr;
    void* RuntimeServices;
    void* BootServices;
    UINTN NumberOfTableEntries;
    void* ConfigurationTable;
};

#endif
