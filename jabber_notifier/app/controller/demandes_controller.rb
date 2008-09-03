class DemandesController < ApplicationController
  alias_method :create_without_jabber, :create
  def create
    self.create_without_jabber()
    @demande.send_jabber_notification
  end
end
