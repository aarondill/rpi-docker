#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob
files=(./*/compose.yaml)
if [[ "${#files[@]}" -eq 0 ]]; then
  echo "No compose files found" >&2
  exit 1
fi

for file in "${files[@]}"; do
  dir="$(dirname -- "$file")"
  pushd "$dir" || continue
  docker compose up -d
  popd
done
