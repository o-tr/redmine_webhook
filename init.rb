if Rails.try(:autoloaders).try(:zeitwerk_enabled?)
  Rails.autoloaders.main.push_dir File.dirname(__FILE__) + '/lib/redmine_webhook'
  RedmineWebhook::ProjectsHelperPatch
  RedmineWebhook::WebhookListener
else
  require "redmine_webhook"
end

Redmine::Plugin.register :redmine_webhook do
  name 'Redmine Discord Webhook plugin'
  author 'ootr'
  description 'A Redmine plugin posts webhook on creating and updating tickets to Discord. original: https://github.com/suer/redmine_webhook'
  version '0.0.6'
  url 'https://github.com/o-tr/redmine_webhook'
  author_url 'https://github.com/o-tr'
  project_module :webhooks do
    permission :manage_hook, {:webhook_settings => [:index, :show, :update, :create, :destroy]}, :require => :member
  end
end
