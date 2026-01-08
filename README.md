# Hammer CLI Foreman Webhooks

This Hammer CLI plugin contains set of commands for [foreman_webhooks](
  https://github.com/theforeman/foreman_webhooks
), a plugin to Foreman for Webhooks management.

## Versions

This is the list of which version of Foreman Webhooks is needed to which version of this plugin.

| hammer_cli_foreman_webhooks | v0.0.1 | v0.0.3 |
|-----------------------------|--------|--------|
|            foreman_webhooks | v0.0.1 | v3.0.2 |

## Installation

    $ gem install hammer_cli_foreman_webhooks

    $ mkdir -p ~/.hammer/cli.modules.d/

    $ cat <<EOQ > ~/.hammer/cli.modules.d/foreman_webhooks.yml
    :foreman_webhooks:
      :enable_module: true
    EOQ

    # to confirm things work, this should return useful output
    hammer webhooks --help

## More info

See our [Hammer CLI installation and configuration instuctions](
https://github.com/theforeman/hammer-cli/blob/master/doc/installation.md#installation).

## Release

Please refer to [RELEASE.md](RELEASE.md)
