#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PASS=0; FAIL=0

for f in "$ROOT/flake.nix" "$ROOT/overlays/aurekai.nix"; do
  if grep -q "aurekai" "$f" 2>/dev/null; then
    echo "  v $(basename "$f")"; PASS=$((PASS+1))
  else
    echo "  x $(basename "$f") missing or empty"; FAIL=$((FAIL+1))
  fi
done

echo; echo "Nix files: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
