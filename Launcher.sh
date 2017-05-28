#!/bin/bash

# Script should be runned as root
if [ "$(id -u)" != "0" ]; then
    sudo -u root -H -b $0 $@
    exit 0
fi

if [ -x "$1" ]; then
    logger -t "Launcher" "Executing [$@] as root..."
    eval `ssh-agent`
    ssh-add ~/.ssh/id_rsa
    $@
    ssh-agent -k
else
    logger -t "Launcher" "Skipping execution of [$@] - not an executable..."
fi
