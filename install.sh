#!/usr/bin/env bash
# Installs the olostep CLI for testers:
#   curl -fsSL https://raw.githubusercontent.com/samyakkkk/olostep-cli/main/install.sh | bash
# It goes into ~/.olostep (no sudo, nothing read from Downloads) and onto PATH. Run it again to update.
set -euo pipefail

URL="${OLOSTEP_CLI_URL:-https://github.com/samyakkkk/olostep-cli/releases/download/staging/olostep.tgz}"
PREFIX="${OLOSTEP_HOME:-$HOME/.olostep}"
BIN="$PREFIX/bin"

fail() { printf 'olostep install: %s\n' "$1" >&2; exit 1; }

command -v node >/dev/null 2>&1 || fail "Node.js 22.18 or newer is needed. Install it from https://nodejs.org (or: brew install node), then run this again."
command -v npm >/dev/null 2>&1 || fail "npm is missing. It comes with Node.js from https://nodejs.org."
node -e 'const [a, b] = process.versions.node.split(".").map(Number); process.exit(a > 22 || (a === 22 && b >= 18) ? 0 : 1)' \
  || fail "Node.js 22.18 or newer is needed; this is $(node -v). Update it from https://nodejs.org, then run this again."

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
printf 'Downloading the olostep CLI...\n'
curl -fsSL "$URL" -o "$tmp/olostep.tgz" || fail "Could not download $URL"
npm install --global --prefix "$PREFIX" "$tmp/olostep.tgz" --silent --no-fund --no-audit >/dev/null
[ -x "$BIN/olostep" ] || fail "The install finished but $BIN/olostep is missing."

case "$(basename "${SHELL:-}")" in
  zsh) rc="$HOME/.zshrc" ;;
  bash) if [ "$(uname)" = Darwin ]; then rc="$HOME/.bash_profile"; else rc="$HOME/.bashrc"; fi ;;
  *) rc="$HOME/.profile" ;;
esac
line="export PATH=\"$BIN:\$PATH\""
if ! grep -qsF "$line" "$rc"; then
  printf '\n# olostep CLI\n%s\n' "$line" >> "$rc"
fi

version="$(node -p "require('$PREFIX/lib/node_modules/olostep/package.json').version" 2>/dev/null || true)"
printf '\nInstalled olostep %s in %s\n' "$version" "$BIN"
case ":$PATH:" in
  *":$BIN:"*) printf 'Next: olostep auth login\n' ;;
  *) printf 'Open a new terminal (or run: %s), then: olostep auth login\n' "$line" ;;
esac
