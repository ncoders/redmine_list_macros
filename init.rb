require 'redmine'

Redmine::Plugin.register :redmine_list_macros do
  name 'Redmine List Macros plugin'
  author 'dup2'
  author_url 'https://github.com/dup2'
  description 'Wiki macros for rendering issue lists from saved queries'
  url 'https://github.com/ncoders/redmine_list_macros'
  version '1.0.0'
  requires_redmine version_or_higher: '5.0'
end

Rails.configuration.to_prepare do
  require_dependency File.expand_path('../lib/redmine_list_macros/ref_issues', __FILE__)
end
