#!/bin/bash
# Auto-load context at Claude Code session start

# NOTE: This runs in the USER'S project directory, not the plugin directory
# Use absolute paths or check working directory

echo "🔄 Loading previous session context..."
echo ""

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "📁 Not in a git repository"
    echo "💡 Initialize git to use memory features: git init"
    echo ""
    exit 0
fi

# Display last session context if it exists
if [ -f ".claude-context" ]; then
    echo "=== Last Session ==="
    cat .claude-context
    echo ""
else
    echo "=== First Session ==="
    echo "No previous context found. This appears to be your first session."
    echo ""
fi

# Show recent activity (suppress errors if no commits)
echo "=== Recent Commits ==="
if git log -1 --oneline > /dev/null 2>&1; then
    git log -3 --oneline 2>/dev/null
else
    echo "No commits yet"
fi
echo ""

# Show current working tree status
MODIFIED_COUNT=$(git status --short 2>/dev/null | wc -l | tr -d ' ')
if [ "$MODIFIED_COUNT" -gt 0 ]; then
    echo "=== Uncommitted Changes ($MODIFIED_COUNT files) ==="
    git status --short 2>/dev/null | head -5
    if [ "$MODIFIED_COUNT" -gt 5 ]; then
        echo "... and $((MODIFIED_COUNT - 5)) more files"
    fi
    echo ""
fi

# Show helpful commands
echo "💡 Memory Commands:"
echo "  /git-mem:recall       - Full context reload"
echo "  /git-mem:remember     - Save this session"
echo "  /git-mem:checkpoint   - Quick save point"
echo "  /git-mem:context      - Show current state"
echo ""

# Exit successfully
exit 0