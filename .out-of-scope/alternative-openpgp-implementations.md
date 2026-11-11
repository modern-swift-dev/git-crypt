# Native support for non-GnuPG OpenPGP implementations and remote keys

git-crypt will not embed its own OpenPGP stack or add direct integrations with key servers or remote key stores.

## Why this is out of scope

git-crypt invokes the program named by `git config gpg.program`, defaulting to `gpg`. Any implementation offering a GnuPG-compatible CLI, such as the Sequoia `sq` compatibility shim, can be used that way. Embedding an OpenPGP library, or talking to remote key stores, would greatly enlarge the security-critical code for a need that the existing `gpg.program` setting already covers.

## Prior requests

- `AGWA/git-crypt#239`: "Support for other PGP implementations and remote keys"
