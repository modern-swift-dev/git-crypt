# Passphrase-based encryption

git-crypt will not offer a mode where the repository key is protected by a passphrase instead of GPG or a separately shared key file.

## Why this is out of scope

Anything git-crypt uses to wrap the repository key is committed to the repository, so every clone, fork and mirror holds a copy. A passphrase-wrapped key would be open to offline brute force by anyone with read access. No rate limiting or lockout is possible, and most human-chosen passphrases are far weaker than the 256-bit key they would protect. The existing options are stronger and cover the same need:

- **GPG collaborators:** the key is wrapped to each person's public key.
- **A symmetric key file shared out of band:** `git-crypt export-key` / `git-crypt unlock KEYFILE`. In CI, provide it from a secret (see #31).

## Prior requests

- `AGWA/git-crypt#75`: "Support encrypting with passphrase"
