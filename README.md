# template_base
The base template that all the repositories should create from.

## Features
- PR Auto Labeler: automatically labels all PRs based on their type specified in the title (chore:, docs:, feat:, etc...)

## Getting Started
This template is a [mason](https://pub.dev/packages/mason) brick, so make sure to have it installed in your machinxe.
1) [Install mason_cli](https://pub.dev/packages/mason_cli#installation)
2) [Initialize mason_cli](https://pub.dev/packages/mason_cli#initializing)
3) Add the brick to the generated `mason.yaml`:

```yaml
# Register bricks which can be consumed via the Mason CLI.
# https://github.com/felangel/mason
bricks:
  # Run `mason make template_base` to generate it.
  template_base:
    git:
      url: https://github.com/fabriziocacicia/template_base.git
      ref: v1.0.0 # put the latest version here
```
4) After executing `mason get`, you are able to generate the template by running `mason make template_base`
