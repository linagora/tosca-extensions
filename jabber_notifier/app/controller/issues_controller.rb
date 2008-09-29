class IssuesController < ApplicationController
  alias_method :create_without_jabber, :create
  def create
    self.create_without_jabber()
    @issue.send_jabber_notification
  end
end
