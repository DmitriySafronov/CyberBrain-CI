#!/bin/bash

# Script should be runned as root
if [ "${USER}" != "cyberbrain-ci" ]; then
    sudo -u cyberbrain-ci -H -b $0 $@
    exit 0
fi

if [ -x "~/recipes/$1" ]; then
    logger -t "CyberBrain-CI" "Executing [$@]..."
    eval `ssh-agent`
    ssh-add ~/.ssh/id_rsa
    ~/recipes/$@
    ssh-agent -k
else
    logger -t "CyberBrain-CI" "Skipping execution of [$@] - not an executable..."
fi
