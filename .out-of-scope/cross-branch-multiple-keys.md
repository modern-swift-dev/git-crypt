# Cross-branch checkout/diff when branches use different keys for the same path

git-crypt will not support checking out or diffing a single file from another branch when that branch encrypts the path with a different key.

## Why this is out of scope

Git chooses the filter driver for a path from the `.gitattributes` in effect in the *current* working tree. A blob encrypted with key B is therefore handed to the smudge or textconv filter for key A, and fails authentication ("tampered with"). git-crypt never sees which key a blob was encrypted with, and the file format doesn't record it. Fixing this would need a format change or Git support for per-blob filter selection. The supported approach is one key per path across branches. The limitation is documented in the multiple-keys and Git workflow docs (#33).

## Prior requests

- `AGWA/git-crypt#103`: "Multi-keys setup: Diff + Checkout from other branch impossible when using different keys per branch"
