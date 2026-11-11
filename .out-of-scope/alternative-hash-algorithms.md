# Switching HMAC-SHA1 to SHA-256 (or other algorithms)

git-crypt will not change its HMAC-SHA1 nonce derivation or its use of AES-256-CTR merely to follow Git's SHA-256 transition.

## Why this is out of scope

- **SHA-1's weakness doesn't apply here.** git-crypt uses HMAC-SHA1 as a keyed PRF to derive the 12-byte CTR nonce from the plaintext. SHA-1's practical weakness is collision resistance, which HMAC security does not depend on, and the output is truncated to 96 bits anyway.
- **Git's SHA-256 object format is a separate thing.** It is about Git's own object IDs and does not affect git-crypt's filters.
- **Changing it has a real cost.** It would mean a new file format and key-format negotiation, and every existing repository would be incompatible with older clients. That cost isn't justified without an actual weakness.

This would be revisited only if a practical attack on HMAC-SHA1 as a PRF appeared.

## Prior requests

- `AGWA/git-crypt#236`: "Support for SHA-256?"
