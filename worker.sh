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
mkdir -p "${HOME}/.ssh"
mkdir -p "${HOME}/recipes"
chmod -R a+rwX,go-rwX "${HOME}/.ssh"
chmod -R a+rX,go-w "${HOME}/recipes"
chmod a+rX,gu-w "${HOME}"
chown -R cyberbrain-ci:nogroup "${HOME}"

# Executing a recipe (if exists)
RECIPE="${HOME}/recipes/$1"
if [[ -x "${RECIPE}" ]]; then
    logger -t "CyberBrain-CI" -s -p syslog.info -- "Executing [$1]..."
    eval `ssh-agent`
    ssh-add "${HOME}/.ssh/id_rsa"
    "${HOME}/recipes/$1"
    eval `ssh-agent -k`
elif [[ -r "${RECIPE}" ]]; then
    logger -t "CyberBrain-CI" -s -p syslog.warning -- "Skipping [$1] - not an executable (yet)..."
else
    logger -t "CyberBrain-CI" -s -p syslog.notice -- "Ignoring [$1] - no recipe found..."
fi
