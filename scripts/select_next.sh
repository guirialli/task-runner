#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="tasks/pendentes"
WIP_DIR="tasks/em_andamento"
DONE_DIR="tasks/concluidas"

mkdir -p "$SRC_DIR" "$WIP_DIR" "$DONE_DIR"

# Seleciona o primeiro arquivo por ordenação natural (versão)
TARGET=$(find "$SRC_DIR" -maxdepth 1 -type f -name "*.md" | sort -V | head -n 1 || true)

if [[ -z "$TARGET" ]]; then
    echo "NO_TASKS"
    exit 0
fi

FILENAME=$(basename "$TARGET")
mv "$TARGET" "$WIP_DIR/$FILENAME"
echo "$WIP_DIR/$FILENAME"
