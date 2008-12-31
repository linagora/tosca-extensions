class User < ActiveRecord::Base
  acts_as_reportable

  register_action 'users_export_link'

  private
  # For Ruport :
  def client_name
    client.name if recipient?
  end

  def role_name
    role.name if role
  end

end
