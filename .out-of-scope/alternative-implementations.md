# Bundling alternative (e.g. Python) implementations of git-crypt

The repository will not ship re-implementations of git-crypt's decryption in other languages.

## Why this is out of scope

A second implementation of security-critical crypto code doubles the review and maintenance burden. It can drift from the reference format, and it gets none of the C++ binary's testing. Manual decryption without the normal workflow is covered by documenting `git-crypt smudge --key-file` and the file format (#29). Third-party tools are welcome to live in their own repositories.

## Prior requests

- PR `AGWA/git-crypt#200`: "write python script to decrypt git-crypt encrypted files."
