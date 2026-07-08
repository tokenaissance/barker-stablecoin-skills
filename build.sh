#!/usr/bin/env bash
# build.sh — pre-publish validation for @barkermoney/skills.
# Pure JS package, no compile step. Just sanity-check what npm will pack.

set -euo pipefail
cd "$(dirname "$0")"

# Required top-level files
for f in bin/cli.js bin/mcp-server.mjs package.json README.md LICENSE; do
  [ -f "$f" ] || { echo "✗ missing: $f"; exit 1; }
done

# Bins are executable
chmod +x bin/cli.js bin/mcp-server.mjs

# Skill dirs
SKILL_COUNT=$(find skills -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')
[ "$SKILL_COUNT" -ge 7 ] || { echo "✗ skills/ has $SKILL_COUNT entries, expected ≥7"; exit 1; }

# Each skill ships the files Claude Code expects in the npm payload
for d in skills/*/; do
  for f in SKILL.md SUMMARY.md .claude-plugin/plugin.json; do
    [ -f "$d$f" ] || { echo "✗ $d missing $f"; exit 1; }
  done
done

# package.json parseable
node -e "require('./package.json')" > /dev/null || { echo "✗ package.json invalid"; exit 1; }

# Regenerate llms-full.txt from current SKILL.md files (avoid manual drift)
node scripts/gen-llms-full.mjs

echo "✓ build OK — $SKILL_COUNT skills, bins ready"
