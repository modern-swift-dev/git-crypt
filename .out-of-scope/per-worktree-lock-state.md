# Independent lock state per Git worktree

All linked worktrees of a repository share one git-crypt lock state. git-crypt will not support having one worktree unlocked while another is locked.

## Why this is out of scope

Git's filter configuration (`filter.git-crypt.*`) lives in the repository-wide config, not per worktree. The fork stores the unlocked key in the common Git directory, so `lock` and `unlock` act on every worktree consistently. Per-worktree keys combined with a shared filter config produce inconsistent states. Upstream PR `#333` tried a per-worktree fallback in which a stale per-worktree key keeps decrypting after `lock`, which is a security regression. Doing this properly would need `extensions.worktreeConfig` and per-worktree filter configuration, adding complexity for little gain.

The fork's worktree support (`lock`/`unlock` across all worktrees, state in `--git-common-dir`) resolves the underlying bug reports.

## Prior requests

- `AGWA/git-crypt#105`: per-worktree ideas in the comments (`.gitcryptignore`, `extensions.worktreeConfig`)
- PR `AGWA/git-crypt#333`: "Fix git-crypt in linked worktrees (per-worktree fallback)"
- PR `AGWA/git-crypt#222`: moves state to `.git/common/git-crypt`; superseded by the fork's `--git-common-dir` approach
