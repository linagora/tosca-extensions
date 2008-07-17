require 'demandes_controller'

class DemandesController < ApplicationController
  include JabberNotifier
  alias_method :create_without_jabber, :create
  def create
    self.create_without_jabber()
    @demande.send_jabber_notification
  end
end
