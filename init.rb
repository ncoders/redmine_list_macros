require 'redmine'

Redmine::Plugin.register :redmine_list_macros do
  name 'Redmine List Macros plugin'
  author 'dup2'
  description 'In-house wiki macros for rendering issue lists from saved queries'
  version '1.0.0'
  requires_redmine version_or_higher: '5.0'
end

Rails.configuration.to_prepare do
  require_dependency File.expand_path('../lib/redmine_list_macros/ref_issues', __FILE__)
end
