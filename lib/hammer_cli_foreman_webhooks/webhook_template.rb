# frozen_string_literal: true

module HammerCLIForemanWebhooks
  class WebhookTemplate < HammerCLIForeman::Command
    resource :webhook_templates

    class ListCommand < HammerCLIForeman::ListCommand
      output do
        field :id, _('Id')
        field :name, _('Name')
      end

      build_options
    end

    class InfoCommand < HammerCLIForeman::InfoCommand
      output WebhookTemplate::ListCommand.output_definition do
        field :description, _('Description'), Fields::Text
        field :locked, _('Locked'), Fields::Boolean
        field :default, _('Default'), Fields::Boolean
        HammerCLIForeman::References.timestamps(self)
        HammerCLIForeman::References.taxonomies(self)
        collection :inputs, _('Template inputs') do
          field :id, _('Id'), Fields::Id
          field :name, _('Name')
          field :description, _('Description')
          field :required, _('Required'), Fields::Boolean
          field :options, _('Options'), Fields::List, hide_blank: true
        end
      end

      build_options
    end

    class CloneCommand < HammerCLIForeman::UpdateCommand
      action :clone
      command_name 'clone'

      success_message _('Webhook template cloned.')
      failure_message _('Could not clone the webhook template')

      validate_options do
        option(:option_new_name).required
      end

      build_options
    end

    class ImportCommand < HammerCLIForeman::Command
      command_name 'import'
      action :import

      option '--file', 'PATH', _('Path to a file that contains the webhook template content including metadata'),
             attribute_name: :option_template, format: HammerCLI::Options::Normalizers::File.new

      validate_options do
        all(:option_name, :option_template).required
      end

      success_message _('Imported webhook template successfully.')
      failure_message _('Could not import the webhook template')

      build_options without: %i[template]
    end

    class DumpCommand < HammerCLIForeman::InfoCommand
      command_name 'dump'
      desc _('View webhook template content')

      def print_data(webhook_template)
        puts webhook_template['template']
      end

      build_options
    end

    class CreateCommand < HammerCLIForeman::CreateCommand
      success_message _('Webhook template [%{name}] created.')
      failure_message _('Could not create the webhook template')

      build_options
    end

    class UpdateCommand < HammerCLIForeman::UpdateCommand
      success_message _('Webhook template [%{name}] updated.')
      failure_message _('Could not update the webhook template')

      build_options
    end

    class DeleteCommand < HammerCLIForeman::DeleteCommand
      success_message _('Webhook template [%{name}] deleted.')
      failure_message _('Could not delete the webhook template')

      build_options
    end

    autoload_subcommands
  end
end
