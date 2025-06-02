#!/usr/bin/env bash

LAUNCHER_DIR="/home/player/linko/launcher"
UPDATE_JAR="$LAUNCHER_DIR/Update.jar"
TARGET_JAR="$LAUNCHER_DIR/LinkoLauncher.jar"
FLAG_FILE="/boot/updated"

if [[ ! -d "$LAUNCHER_DIR" ]]; then
  echo "Error: Directory $LAUNCHER_DIR not found."
  exit 1
fi

if [[ ! -f "$UPDATE_JAR" ]]; then
  echo "Update.jar not found on $LAUNCHER_DIR."
  exit 0
fi

if [[ -f "$TARGET_JAR" ]]; then
  echo "Deleting $TARGET_JAR..."
  rm -f "$TARGET_JAR"
  if [[ $? -ne 0 ]]; then
    echo "Error deleting $TARGET_JAR."
    exit 1
  fi
fi

echo "Renaming Update.jar to LinkoLauncher.jar..."
mv "$UPDATE_JAR" "$TARGET_JAR"
if [[ $? -ne 0 ]]; then
  echo "Error renaming $UPDATE_JAR."
  exit 1
fi

touch "$FLAG_FILE" || {
  echo "Error creating $FLAG_FILE." >&2
  exit 1
}

echo "Updated!"

exit 0