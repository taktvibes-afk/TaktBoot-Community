# Certificate / Zertifikat

## DE

Vorgesehene oeffentliche Zertifikatdatei:

`TaktVibes_TaktBoot_Community.cer`

Das oeffentliche Zertifikat darf in diesem Ordner liegen.

Niemals hier ablegen:
- `.pfx`
- `.p12`
- `.pvk`
- private `.key`-Dateien
- Passwortdateien
- andere private Schluesselmaterialien

Der private Schluessel bleibt getrennt, vorzugsweise offline, z. B. im getrennten `TaktVibes Signing`-Bereich.

Nach dem Kopieren des CER-Zertifikats `fingerprint_sha256.cmd` ausfuehren.

## EN

Expected public certificate file:

`TaktVibes_TaktBoot_Community.cer`

The public certificate may be stored in this directory.

Never place here:
- `.pfx`
- `.p12`
- `.pvk`
- private `.key` files
- password files
- any other private key material

The private key remains separate, preferably offline, for example in the separate `TaktVibes Signing` area.

After copying the CER certificate, run `fingerprint_sha256.cmd`.
