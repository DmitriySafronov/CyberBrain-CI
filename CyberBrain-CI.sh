#!/bin/bash

# Script should be runned as "cyberbrain-ci"
if [ "${USER}" != "cyberbrain-ci" ]; then
    sudo -u cyberbrain-ci -H -b $0 $1
    exit 0
fi

if [ -x "${HOME}/recipes/$1" ]; then
    logger -t "CyberBrain-CI" "Executing [$1]..."
    eval `ssh-agent`
    ssh-add "${HOME}/.ssh/id_rsa"
    "${HOME}/recipes/$1"
    ssh-agent -k
else
    logger -t "CyberBrain-CI" "Skipping execution of [$1] - not an executable..."
fi
