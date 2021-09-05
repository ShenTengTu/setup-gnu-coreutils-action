Build GNU coreutils from source, then setup to the environment.

## Why create this action?
Because some coreutils command on Ubuntu are not from GNU coreutils.
For example, command `uptime` is from [procps-ng/procps](https://gitlab.com/procps-ng/procps).
If testing environment need to use GNU coreutils, this action may avoid testing failed.

## How to use
```yml
on: [push]

jobs:
  test-coreutils:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
        # ...
      # use the action before invoking coreutil commands
      - uses: ShenTengTu/setup-gnu-coreutils-action@v1
      # ...
```
