# `git add -p` / partial staging of encrypted files

git-crypt cannot make `git add --patch` (or any hunk-level staging) work on encrypted files.

## Why this is out of scope

Interactive staging diffs the *cleaned* (encrypted) index content against the working tree. Encrypted output has no line structure, so Git reports "Only binary files changed". Making it work would need Git itself to apply hunks to the smudged form and re-run the clean filter, which is a change to Git, not git-crypt. The limitation and workarounds (stage whole files, or edit and stage via a temporary copy) are documented in the Git workflow notes (#33).

## Prior requests

- `AGWA/git-crypt#167`: "Make `git add --patch` work on encrypted files?"
- `AGWA/git-crypt#178`: "git-crypt breaks git partial staging"
- `AGWA/git-crypt#291`: "`git add -p` workaround?"
