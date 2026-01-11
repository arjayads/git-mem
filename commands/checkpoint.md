---
description: "Create a quick checkpoint with optional message"
---

# Create Checkpoint

Create a quick git checkpoint to save current state without full context.

## What you need to do:

1. **Get checkpoint message**
    - If user provided $ARGUMENTS, use that as the message
    - If no $ARGUMENTS, use default: "Checkpoint at HH:MM" (current time)

2. **Stage all changes**
    - Run: `git add . 2>/dev/null`
    - This stages all modified and new files

3. **Create commit**
    - Commit with message: `wip: [message]`
    - Use --quiet flag
    - The "wip:" prefix indicates "work in progress"

4. **Confirm to user**
    - Display: "✓ Checkpoint created: [message]"

## Implementation:

```bash
# Get message from arguments or use default timestamp
if [ -n "$ARGUMENTS" ]; then
    MESSAGE="$ARGUMENTS"
else
    MESSAGE="Checkpoint at $(date +%H:%M)"
fi

# Stage all changes
git add . 2>/dev/null

# Create checkpoint commit
git commit -m "wip: ${MESSAGE}" --quiet 2>/dev/null

# Confirm
echo "✓ Checkpoint created: ${MESSAGE}"
```

## Usage examples:

User types: `/git-memory:checkpoint refactored auth module`
- Creates commit: "wip: refactored auth module"

User types: `/git-memory:checkpoint`
- Creates commit: "wip: Checkpoint at 14:30"