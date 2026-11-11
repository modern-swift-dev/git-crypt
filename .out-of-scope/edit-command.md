# `git-crypt edit` (decrypt-edit-reencrypt without unlocking)

git-crypt will not add an `edit` command that decrypts one file into a temporary location, opens an editor and re-encrypts it, while the repository stays locked.

## Why this is out of scope

git-crypt's model is transparent encryption through Git's clean/smudge filters on an unlocked working tree. An `edit` mode would need a parallel "unlocked but filters disabled" state and secure temp-file handling for arbitrary editors, which may write swap and backup files. It also needs its own staging path. That is a second workflow with its own security surface, for limited benefit: users can `unlock`, edit, commit and `lock`. Tools such as `sops` are designed for edit-in-place secrets files.

## Prior requests

- `AGWA/git-crypt#34`: "Add `edit` command for more security."
