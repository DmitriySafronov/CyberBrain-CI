# CyberBrain-CI
A "Continuous Integration" solution for CyberBrain

Quick & dirty solution for fast development builds deployment.

You can use any scripting language installed in you recipes.

## Requirements

PHP with exec() enabled, BASH; your favorite scripting language for recipes ;)

## Installation

For Ubuntu

0. Clone this repo somewhere into your web server's html directory (this will be your CI url).

1. Create system user `cyberbrain-ci` with group `nogroup`:

    `adduser --system --home /var/local/cyberbrain-ci --disabled-login --disabled-password cyberbrain-ci`

2. Copy `CyberBrain-CI.sudoers_example` to `/etc/sudoers.d` as `CyberBrain-CI`:

    `cp CyberBrain-CI.sudoers_example /etc/sudoers.d/CyberBrain-CI`

3. Edit `/etc/sudoers.d/CyberBrain-CI` - correct path to your `worker.sh`

4. Create dir hierarchy in `cyberbrain-ci`'s home (like `service_name_dir`/`user_name_dir`):

    `mkdir -p ~/recipes/github.com/DmitriySafronov`

5. Edit recipe file in hierarchy (`service_name_dir`/`user_name_dir`/`repo_name_file'):

    `editor ~/recipes/github.com/DmitriySafronov/CyberBrain-CI`

6. Make recipe file executable:

    `chmod +x ~/recipes/github.com/DmitriySafronov/CyberBrain-CI`

7. Create a webhook and attach it to your CI url.
