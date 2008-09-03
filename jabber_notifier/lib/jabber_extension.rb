# Overrides xmpp4r debuglog method to log message in tosca logger
module Jabber
  def self.debuglog(string)
    return if not Jabber::debug
    s = string.chomp.gsub("\n", "\n    ")
    t = Time::new.strftime('%H:%M:%S')
    # Log in stdout unless JabberNotifier could be log in tosca
    ActiveRecord::Base.logger.debug "#{t} #{s}"
  end
end
