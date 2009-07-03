# User to send Jabber Notification
Rails.configuration.gem 'xmpp4r'
Rails.configuration.after_initialize do
  require 'xmpp4r'
  require_dependency 'jabber_extension'
end
