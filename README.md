Build GNU coreutils from source, then setup to the environment.

## Why create this action?
Because some coreutils command on Ubuntu are not from GNU coreutils.
For example, command `uptime` & `kill` are from [procps-ng/procps](https://gitlab.com/procps-ng/procps).
If testing environment need to use GNU coreutils, this action may avoid testing failed.