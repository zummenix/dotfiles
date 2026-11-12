---
name: jj-review-commit
description: Review current changes and commit if all is good.
disable-model-invocation: true
---

Review current uncommited changes using `jj diff`.

Focus on correctness, unintended changes, and anything that would make this
change unsafe or unnecessarily difficult to maintain. Check whether relevant
tests are missing.

If all is good, commit the changes using `jj commit -m`, following the
repository's existing commit message style (for example 10 latest commits:
`jj log -r .. --limit 10`).

If you find issues, clearly report them and do not commit the changes.
