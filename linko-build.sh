#!/usr/bin/env bash

rootPath="$(cd "$(dirname "$0")" && pwd)"

"$rootPath/build.sh" -o linko.options -c linko
# -o: Is the options located at root
# -c: Is the cfg located at root/config