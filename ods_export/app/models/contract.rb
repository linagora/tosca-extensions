class Contract < ActiveRecord::Base
  acts_as_reportable

  register_action 'contracts_export_link'

  private
  def contract_name
    self.name
  end
  def users_size
    self.users.size
  end
  def issues_size
    self.issues.size
  end
  def releases_size
    self.releases.size
  end
  def tam_name
    (self.tam || '-').to_s
  end
  def salesman_name
    (self.salesman || '-').to_s
  end
  def pname_teams
    self.teams.collect(&:name).join("\n")
  end
  def pname_users
    self.engineer_users.collect(&:name).join("\n")
  end


end
