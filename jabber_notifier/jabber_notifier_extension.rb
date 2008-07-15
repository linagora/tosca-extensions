require_dependency 'application'

class JabberNotifierExtension < Radiant::Extension
  version "1.0"
  description "Allows to receive instant notification when a request is submitted."
  url "http://tosca-project.net"

  def activate
    puts "JabberNotifierExtension : it's activated !"
=begin
    class DemandesController < ApplicationController
      include JabberNotifier
      alias_method :create, :create_without_jabber
      def create
        create_without_jabber
        @demande.send_jabber_notification
      end
    end
=end
  end

  def deactivate
    # reload seems to be a good way to flush the alias
    require 'demandes_controller'
  end

end
