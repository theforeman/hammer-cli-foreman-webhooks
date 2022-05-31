# frozen_string_literal: true

module HammerCLIForemanWebhooks
  class Webhook < HammerCLIForeman::Command
    resource :webhooks

    class ListCommand < HammerCLIForeman::ListCommand
      output do
        field :id, _('Id')
        field :name, _('Name')
        field :target_url, _('Target URL')
        field :enabled, _('Enabled'), Fields::Boolean
      end

      build_options
    end

    class InfoCommand < HammerCLIForeman::InfoCommand
      output Webhook::ListCommand.output_definition do
        field :event, _('Event')
        field :http_method, _('HTTP Method')
        field :http_content_type, _('HTTP Content Type')
        custom_field Fields::Reference, label: _('Webhook Template'), path: [:webhook_template]
        field :user, _('User'), Fields::Field, sets: %w[ADDITIONAL ALL]
        field :verify_sll, _('Verify SSL'), Fields::Boolean, sets: %w[ADDITIONAL ALL]
        field :proxy_authorization, _('Proxy Authorization'), Fields::Boolean, sets: %w[ADDITIONAL ALL]
        field :ssl_ca_certs, _('X509 Certification Authorities'), Fields::Text, sets: %w[ADDITIONAL ALL]
        collection :http_headers, _('HTTP Headers'), sets: %w[ADDITIONAL ALL] do
          custom_field Fields::KeyValue
        end
        HammerCLIForeman::References.timestamps(self)
      end

      build_options

      extend_with(HammerCLIForemanWebhooks::CommandExtensions::Webhook.new(only: :before_print))
    end

    class CreateCommand < HammerCLIForeman::CreateCommand
      success_message _('Webhook [%{name}] created.')
      failure_message _('Could not create the webhook')

      build_options without: %i[ssl_ca_certs http_headers]

      extend_with(HammerCLIForemanWebhooks::CommandExtensions::Webhook.new(only: :options))
    end

    class UpdateCommand < HammerCLIForeman::UpdateCommand
      success_message _('Webhook [%{name}] updated.')
      failure_message _('Could not update the webhook')

      build_options without: %i[ssl_ca_certs http_headers]

      extend_with(HammerCLIForemanWebhooks::CommandExtensions::Webhook.new(only: :options))
    end

    class DeleteCommand < HammerCLIForeman::DeleteCommand
      success_message _('Webhook [%{name}] deleted.')
      failure_message _('Could not delete the webhook')

      build_options
    end

    autoload_subcommands
  end
end
