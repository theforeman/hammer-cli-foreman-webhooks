# frozen_string_literal: true

module HammerCLIForemanWebhooks
  require 'hammer_cli'
  require 'hammer_cli_foreman'

  require 'hammer_cli_foreman_webhooks/version'
  require 'hammer_cli_foreman_webhooks/command_extensions'
  require 'hammer_cli_foreman_webhooks/webhook'
  require 'hammer_cli_foreman_webhooks/webhook_template'

  HammerCLI::MainCommand.lazy_subcommand(
    'webhook',
    'Manage webhooks',
    'HammerCLIForemanWebhooks::Webhook',
    'hammer_cli_foreman_webhooks/webhook'
  )
  HammerCLI::MainCommand.lazy_subcommand(
    'webhook-template',
    'Manipulate webhook templates',
    'HammerCLIForemanWebhooks::WebhookTemplate',
    'hammer_cli_foreman_webhooks/webhook_template'
  )
end
