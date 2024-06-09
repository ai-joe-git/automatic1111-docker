#!/usr/bin/env bash

# Because automatic1111 only runs this when the folder is missing entirely, we
# need to run it manually in the scenario where the folder exists but the venv
# has yet to be initialized (e.g. when using a volume mount)
python3 -m venv ./venv

# Run with -f because Docker is setup to run as Root, and automatic1111 disables
# running as root by default, unless you pass the `-f` flag.
./webui.sh -f
