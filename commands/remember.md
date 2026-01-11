---
description: "Save current session context to git"
---

# Remember This Session

Save the current session state to git so it can be recalled later.

## What you need to do:

1. **Get session notes**
    - Check if user provided notes via $ARGUMENTS
    - If $ARGUMENTS is empty or not provided, ask: "What did you accomplish this session?"
    - Store the response

2. **Create .claude-context file** with this exact format:
   ```
   Session: [current date and time]
   Notes: [session notes from user]
   Recent work: [last git commit message, one line]
   Timestamp: [current date and time in full format]
   ```

3. **Commit to git**
    - Add the file: `git add .claude-context`
    - Commit with message: `context: Session saved - YYYY-MM-DD`
    - Use --quiet flag to suppress output

4. **Confirm to user**
    - Display: "✓ Context saved to git"

## Implementation:

```bash
# Get session notes from arguments or prompt user
if [ -n "$ARGUMENTS" ]; then
    NOTES="$ARGUMENTS"
else
    echo "What did you accomplish this session?"
    read -r NOTES
fi

# Get recent work from git
RECENT_WORK=$(git log -1 --oneline 2>/dev/null || echo "No commits yet")

# Create context file
cat > .claude-context << EOF
Session: $(date)
Notes: ${NOTES}
Recent work: ${RECENT_WORK}
Timestamp: $(date '+%Y-%m-%d %H:%M:%S %Z')
EOF

# Commit to git
git add .claude-context 2>/dev/null
git commit -m "context: Session saved - $(date +%Y-%m-%d)" --quiet 2>/dev/null

# Confirm
echo "✓ Context saved to git"
```

## Usage examples:

User types: `/git-memory:remember finished authentication module`
- $ARGUMENTS = "finished authentication module"
- Skip the prompt, use this directly

User types: `/git-memory:remember`
- $ARGUMENTS is empty
- Prompt user for notes