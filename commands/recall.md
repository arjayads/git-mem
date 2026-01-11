---
description: "Load previous session context from git history"
---

# Recall Previous Session

You need to load and display the previous session's context so we can continue where we left off.

## Steps to execute:

1. **Check for .claude-context file** in the current project directory
    - If it exists, display its full contents
    - If not, show: "No previous context saved yet"

2. **Show recent git commits** (last 5 commits)
    - Use: `git log -5 --oneline 2>/dev/null`
    - If git not initialized, skip this section

3. **Show context-specific commits** (last 3 with "context:" prefix)
    - Use: `git log --grep="context:" -3 --pretty=format:"%h - %s%n%b%n" 2>/dev/null`

4. **Show current working tree status**
    - Use: `git status --short 2>/dev/null`
    - This shows modified/staged/untracked files

## Output format:

```
=== Last Session Context ===
[Contents of .claude-context or "No previous context saved yet"]

=== Recent Commits (Last 5) ===
[Git log output - commit hash and message]

=== Context Commits ===
[Commits with "context:" prefix, showing full message body]

=== Modified Files ===
[Git status output showing current changes]
```

## Commands to run:

```bash
# Check and display context file
if [ -f ".claude-context" ]; then
    echo "=== Last Session Context ==="
    cat .claude-context
    echo ""
else
    echo "=== Last Session Context ==="
    echo "No previous context saved yet"
    echo ""
fi

# Show recent commits
echo "=== Recent Commits (Last 5) ==="
git log -5 --oneline 2>/dev/null || echo "Not a git repository or no commits yet"
echo ""

# Show context commits
echo "=== Context Commits ==="
git log --grep="context:" -3 --pretty=format:"%h - %s%n%b%n" 2>/dev/null || echo "No context commits found"
echo ""

# Show current status
echo "=== Modified Files ==="
git status --short 2>/dev/null || echo "Not a git repository"
```

After displaying this information, ask the user if they want to continue previous work or start something new.