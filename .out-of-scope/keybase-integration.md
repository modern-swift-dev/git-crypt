# Keybase (or other identity-service) integration

git-crypt will not integrate directly with Keybase or similar identity services for key lookup or wrapping.

## Why this is out of scope

- **GPG is the extension point.** git-crypt delegates identity to GnuPG through `gpg.program`, so any service that can supply OpenPGP keys already works through the local keyring.
- **Keybase itself isn't a good base.** It has been effectively unmaintained since its acquisition.
- **It adds risk.** Building on a specific online service adds a network dependency and a third-party trust root to a security tool.

## Prior requests

- `AGWA/git-crypt#127`: "Integrate directly with Keybase"
