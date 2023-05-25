# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hammer_cli_foreman_webhooks/version'

Gem::Specification.new do |spec|
  spec.name          = 'hammer_cli_foreman_webhooks'
  spec.version       = HammerCLIForemanWebhooks.version.dup
  spec.authors       = ['Oleh Fedorenko']
  spec.email         = ['ofedoren@redhat.com']
  spec.homepage      = 'https://github.com/theforeman/hammer-cli-foreman-webhooks'
  spec.license       = 'GPL-3.0'

  spec.platform      = Gem::Platform::RUBY
  spec.summary       = 'Foreman Webhooks plugin for Hammer CLI'

  spec.files         = Dir['{lib,config}/**/*', 'LICENSE', 'README*']
  spec.require_paths = ['lib']
  spec.test_files    = Dir['{test}/**/*']

  spec.required_ruby_version = '>= 2.7', '< 4'

  spec.add_dependency 'hammer_cli_foreman', '>= 2.0.0', '< 4.0.0'
end
