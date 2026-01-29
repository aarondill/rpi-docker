#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob
files=(./*/compose.yaml)
if [[ "${#files[@]}" -eq 0 ]]; then
  echo "No compose files found" >&2
  exit 1
fi

args=()
for file in "${files[@]}"; do
  args+=(-f "$file")
done
docker compose "${args[@]}" up -d
