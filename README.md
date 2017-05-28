# CyberBrain-CI
A "Continuous Integration" solution for CyberBrain

Quick & dirty solution for fast development builds deployment.

You can use any scripting language installed in you recipes.

## Installation

For Ubuntu

1. Create system user `cyberbrain-ci` with group `nogroup`:

`adduser --system --home /var/local/cyberbrain-ci --disabled-login --disabled-password cyberbrain-ci`

2. Copy `CyberBrain-CI.sudoers_example` to `/etc/sudoers.d` as `CyberBrain-CI`

`cp CyberBrain-CI.sudoers_example /etc/sudoers.d/CyberBrain-CI`

3. Edit `/etc/sudoers.d/CyberBrain-CI` - correct path to your `worker.sh`
