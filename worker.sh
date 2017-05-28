#!/bin/bash

# Script should be runned as "cyberbrain-ci"
if [[ "${USER}" != "cyberbrain-ci" ]]; then
    sudo -u cyberbrain-ci -g nogroup -H -b $0 $1
    exit 1
fi

# First argument should be a recipe
if [[ -z "$1" ]]; then
    logger -t "CyberBrain-CI" -s "No recipe defined..."
    exit 1
fi

# Recipes and .ssh dirs should exist and have valid acls
mkdir -p "${HOME}/recipes"
mkdir -p "${HOME}/.ssh"
chown -R cyberbrain-ci:nogroup "${HOME}"
chmod a+rX,gu-w "${HOME}"
chmod -R a+rwX,go-rwX "${HOME}/.ssh"
chmod -R a+rX,go-w "${HOME}/recipes"

# Executing a recipe (if exists)
if [[ -x "${HOME}/recipes/$1" ]]; then
    logger -t "CyberBrain-CI" -s "Executing [$1]..."
    eval `ssh-agent`
    ssh-add "${HOME}/.ssh/id_rsa"
    "${HOME}/recipes/$1"
    ssh-agent -k
else
    logger -t "CyberBrain-CI" -s "Skipping execution of [$1] - not an executable..."
fi
