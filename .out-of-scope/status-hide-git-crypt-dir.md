# Hiding `.git-crypt/` from default `git-crypt status` output

The default output of `git-crypt status` will keep listing every file, including `.git-crypt/`.

## Why this is out of scope

`status` lists all tracked files with their encryption state, and scripts parse that output. Users who only want the relevant files can use `-e` (encrypted only) or `-u` (unencrypted only). Changing the default would break existing consumers for a purely cosmetic gain.

## Prior requests

- `AGWA/git-crypt#66`: "'status' subcommand should not include '.git-crypt/' directory"
