require 'rake/testtask'
require 'bundler/gem_tasks'

Bundler::GemHelper.install_tasks

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
  t.warning = ENV.key?('RUBY_WARNINGS')
end

namespace :pkg do
  desc 'Generate package source gem'
  task generate_source: :build
end

require "hammer_cli_foreman_webhooks/version"
require "hammer_cli_foreman_webhooks/i18n"
require "hammer_cli/i18n/find_task"
HammerCLI::I18n::FindTask.define(HammerCLIForemanWebhooks::I18n::LocaleDomain.new, HammerCLIForemanWebhooks.version.to_s)
