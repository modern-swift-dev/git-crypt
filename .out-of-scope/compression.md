# Compressing files before encryption

git-crypt will not compress file contents before encrypting them.

## Why this is out of scope

- **It leaks information.** git-crypt's encryption is deterministic: the same plaintext gives the same ciphertext, which lets Git deduplicate and diff. Compressing before encrypting makes ciphertext length depend on content redundancy. That leaks information about the plaintext, the class of weakness behind CRIME/BREACH-style attacks.
- **It changes the format.** Compression would require a new on-disk format and break compatibility with every existing git-crypt client.
- **Git already compresses.** Git compresses objects itself; it just can't compress encrypted data well. If large encrypted files are a problem, that suggests the files don't belong in Git (see the README limitations).

## Prior requests

- `AGWA/git-crypt#324`: "File compression"
