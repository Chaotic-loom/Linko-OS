#!/bin/bash

### CONFIGURATION ###
USER_TO_RUN="player"
JAR_PATH="/home/player/linko/launcher/LinkoLauncher.jar"
LWJGL_MAIN_CLASS="com.chaotic_loom.core.Main"
JAVA_CMD="/usr/bin/java"
CAGE="/usr/bin/cage"
JAVA_ARGS=""
CRASH_ARG="crashed"
######################

# redirect all output to /dev/tty1
exec >/dev/tty1 2>&1 </dev/tty1

# run under the kiosk user
if [ "$(id -un)" != "$USER_TO_RUN" ]; then
  echo "This script must be run as $USER_TO_RUN (or via systemd User=$USER_TO_RUN)."
  exit 1
fi

while true; do
  echo "Starting LWJGL kiosk..." >&2

  # Launch the LWJGL kiosk.
  "$CAGE" -- "$JAVA_CMD" $JAVA_ARGS -cp "$JAR_PATH" "$LWJGL_MAIN_CLASS"

  EXIT_CODE=$?
  if [ $EXIT_CODE -eq 0 ]; then
    # Normal exit – don’t show crash handler, just exit
    echo "LWJGL kiosk exited cleanly (exit code 0)."
    exit 0
  fi

  echo "LWJGL kiosk crashed (exit code $EXIT_CODE).  Dropping to Lanterna menu…" >&2

  # Switch to VT1 and clear the screen before launching Lanterna UI
  chvt 1

  # Use Linux framebuffer ANSI clear
  printf "\033[2J\033[H"

  # Launch the Lanterna‐based crash handler. It should attach to /dev/tty1
  # and only return once the user selects something.
  "$JAVA_CMD" $JAVA_ARGS -cp "$JAR_PATH" "$LWJGL_MAIN_CLASS" CRASH_ARG
  HANDLER_EXIT=$?

  # Based on the exit code of the crash handler, decide what to do:
  if [ $HANDLER_EXIT -eq 0 ]; then
    echo "User chose to exit kiosk. Exiting wrapper script."
    exit 0
  elif [ $HANDLER_EXIT -eq 1 ]; then
    echo "User chose to restart kiosk. Looping..."
    sleep 1
    continue
  else
    echo "Crash handler returned unexpected code $HANDLER_EXIT. Exiting with 1."
    exit 1
  fi
done