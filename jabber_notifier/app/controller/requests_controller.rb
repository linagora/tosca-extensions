class RequestsController < ApplicationController
  alias_method :create_without_jabber, :create
  def create
    self.create_without_jabber()
    @request.send_jabber_notification
  end
end
