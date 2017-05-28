#!/bin/bash

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
    sudo -u root -H -b $0 $@
    exit 0
fi

if [ -x "$1" ]; then
    logger -t "Launcher" "Executng [$@] as root..."
    $@ &
else
    logger -t "Launcher" "Skipping execution of [$@] - not an executable..."
fi
