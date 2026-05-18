#!/usr/bin/env bash
# publish.sh — idempotent npm publish for @barkermoney/skills.
# Skips silently if the current package.json version is already on the registry.
# build.sh runs automatically via the prepublishOnly hook.

set -euo pipefail
cd "$(dirname "$0")"

PKG_NAME=$(node -p "require('./package.json').name")
PKG_VERSION=$(node -p "require('./package.json').version")

REMOTE_VERSION=$(npm view "$PKG_NAME" version 2>/dev/null || echo "")

if [ "$REMOTE_VERSION" = "$PKG_VERSION" ]; then
  echo "• $PKG_NAME@$PKG_VERSION already on npm, skipping"
  exit 0
fi

echo "→ publishing $PKG_NAME@$PKG_VERSION (latest on npm: ${REMOTE_VERSION:-none})"
npm publish
echo "✓ published $PKG_NAME@$PKG_VERSION"
echo ""
echo "Next: tag the release"
echo "  git tag v$PKG_VERSION && git push origin v$PKG_VERSION"
