config = Rails.configuration

# Used to generate export in Ods Format
# Versions are enforced because ruport devs seems to love
# "the break everything at each release" mantra
config.gem 'acts_as_reportable', :lib => 'ruport/acts_as_reportable', :version => '1.1.1'
config.gem 'ruport', :version => '1.6.1'
config.gem 'ruport-util', :lib => 'ruport/util', :version => '0.14.0'

require_plugin 'ar_actions'

# In order to not have conflict with other extension #
Rails.configuration.after_initialize do
  IssuesController.class_eval { helper :export }
  %w(contract contribution issue phonecall user).each { |dep|
    require_dependency dep
  }
end
