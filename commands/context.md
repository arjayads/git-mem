---
description: "Show current project context and state"
---

# Show Current Context

Display the current project state including saved context, git status, and branch.

## What you need to do:

1. **Show saved context**
    - Display contents of .claude-context if it exists
    - If not, show: "No context saved"

2. **Show modified files**
    - Run: `git status --short`
    - Shows M (modified), A (added), ?? (untracked) files

3. **Show current branch**
    - Run: `git branch --show-current`
    - Display the active git branch name

## Output format:

```
=== Current Context ===
[Contents of .claude-context or "No context saved"]

=== Modified Files ===
[Output of git status --short]

=== Current Branch ===
[Current branch name]
```

## Implementation:

```bash
# Show context file
echo "=== Current Context ==="
if [ -f ".claude-context" ]; then
    cat .claude-context
else
    echo "No context saved"
fi
echo ""

# Show modified files
echo "=== Modified Files ==="
git status --short 2>/dev/null || echo "Not a git repository"
echo ""

# Show current branch
echo "=== Current Branch ==="
git branch --show-current 2>/dev/null || echo "Not a git repository"
```

This gives a quick snapshot of where things stand right now.