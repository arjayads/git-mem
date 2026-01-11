# Git Memory Plugin for Claude Code

🧠 Persistent memory system for Claude Code using git commits. Never lose context between sessions!

## Features

- ✅ **Auto-load context** - Automatically loads previous session when Claude Code starts
- ✅ **Session memory** - Save and restore work context across sessions
- ✅ **Quick checkpoints** - Create save points during development
- ✅ **Git-based** - Uses git commits as persistent storage
- ✅ **Per-project** - Each project maintains independent memory

## Installation

### From GitHub (Recommended)

```bash
# In Claude Code, run:
/plugin marketplace add arjayads/git-mem
/plugin install git-memory
```

### Verify Installation

```bash
# Check plugin is installed
/plugin list

# You should see git-memory in the list

# Check available commands
/help
# Should show /git-memory:* commands
```

## Commands

### `/git-memory:recall`
Load previous session context from git history.

Shows:
- Last session notes
- Recent commits
- Context commits
- Modified files

**Usage:**
```
/git-memory:recall
```

### `/git-memory:remember [notes]`
Save current session context to git.

**Usage:**
```
/git-memory:remember finished authentication system
/git-memory:remember
  (Will prompt for notes if not provided)
```

### `/git-memory:checkpoint [message]`
Create a quick checkpoint without full context.

**Usage:**
```
/git-memory:checkpoint refactored user service
/git-memory:checkpoint
  (Uses timestamp if no message)
```

### `/git-memory:context`
Show current project state.

**Usage:**
```
/git-memory:context
```

## How It Works

1. **Auto-start**: When you open Claude Code, the SessionStart hook automatically runs and loads your last session context
2. **Work normally**: Claude remembers what you were working on
3. **Save checkpoints**: Use `/git-memory:checkpoint` to save progress
4. **End session**: Use `/git-memory:remember` to save session notes
5. **Next session**: Context loads automatically when you start Claude Code again!

## Example Workflow

### Day 1: Starting Work

```bash
# Start Claude Code
claude

# (Auto-loads context - shows "First Session" if new project)

You: "Let's build a user authentication system"
# ... work happens ...

# Save checkpoint
/git-memory:checkpoint "finished login endpoint"

# Continue working...

# End of day
/git-memory:remember "Completed login and registration, needs password reset next"
```

### Day 2: Resuming

```bash
# Start Claude Code next day
claude

# Auto-loads:
# === Last Session ===
# Session: Thu Jan 9 2025 17:30:00
# Notes: Completed login and registration, needs password reset next
# Recent work: wip: finished login endpoint
# ...

You: "Let's add password reset"
# Claude knows exactly where you left off!
```

## File Structure

The plugin creates one file in your project:

```
your-project/
├── .claude-context    ← Session context (created automatically)
├── .git/             ← Your git repo
└── ... your code
```

**Important:** Add `.claude-context` to your `.gitignore` if you don't want to share it publicly!

## Requirements

- Claude Code version 1.0.33 or higher
- Git initialized in your project (`git init`)
- **Windows users**: Git Bash required (comes with Git for Windows)

## Windows Support

✅ **Fully compatible with Windows!**

**Prerequisites:**
1. Install Git for Windows: https://gitforwindows.org/
2. Use Git Bash (not PowerShell or CMD)
3. Claude Code automatically uses Git Bash on Windows

**Installation on Windows:**
```bash
# Open Git Bash
git --version  # Verify git installed

# Install Claude Code
npm install -g @anthropic-ai/claude-code

# Install plugin (same as Linux/Mac)
claude
/plugin marketplace add arjayads/git-mem
/plugin install git-mem
```

## Troubleshooting

### Commands not showing up

```bash
# Reinstall the plugin
/plugin uninstall git-memory
/plugin marketplace add arjayads/git-mem
/plugin install git-memory

# Restart Claude Code
exit
claude
```

### Auto-load not working

The SessionStart hook only runs in directories with git initialized:

```bash
# Make sure git is initialized
git init
git add .
git commit -m "Initial commit"
```

### Context file not created

Ensure you have write permissions in the directory:

```bash
# Test write permission
touch .claude-context
# If this fails, you have permission issues
```

### Windows: "bash: command not found"

```bash
# Install Git for Windows
# Download: https://gitforwindows.org/
# Make sure to use Git Bash, not PowerShell
```

## Privacy Note

The `.claude-context` file contains your session notes and is stored in your project directory.

**Options:**
1. **Keep it private**: Add to `.gitignore`
2. **Share with team**: Commit it to git (useful for team context)
3. **Hybrid**: Keep personal notes elsewhere, use generic project notes

## Contributing

Found a bug or have a feature request?

1. Open an issue: https://github.com/arjayads/git-mem/issues
2. Submit a pull request
3. Star the repo if you find it useful!

## License

MIT License - see LICENSE file for details

## Author

Your Name - your.email@example.com

## Changelog

### v1.0.0 (2025-01-10)
- Initial release
- Basic recall, remember, checkpoint, context commands
- SessionStart auto-load hook
- Git-based persistent storage
- Full Windows support via Git Bash

---

**Star ⭐ this repo if it helps you!**