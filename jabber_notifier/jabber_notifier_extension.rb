require_dependency 'application'

class JabberNotifierExtension < Tosca:Extension
  version "1.0"
  description "Allows to receive instant notification when a request is submitted."
  url "http://tosca-project.net"

  def activate
    require 'jabber_demandes_controller'
  end

  def deactivate
    # reload seems to be a good way to flush the alias
    require 'demandes_controller'
  end

end
