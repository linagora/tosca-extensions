class User < ActiveRecord::Base
  acts_as_reportable

  register_action 'users_export_link'

  private
  # For Ruport :
  def recipient_client_name
    recipient.client.name if recipient
  end

  def role_name
    role.name if role
  end

end
